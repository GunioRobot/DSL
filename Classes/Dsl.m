//
//  Dsl.m
//  DSL
//
//  Created by David Astels on 9/29/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "Dsl.h"
#import "SymbolTable.h"

@implementation Dsl

- (Dsl *) init
{
  parser = [[DslParser alloc] init];
  symbolTable = [[SymbolTable alloc] init];
  return self;  
}


- (DslExpression *) parse:(NSString*)codeString
{
  return [parser parseExpression:[InputStream withString:codeString]];
}


- (DslSymbol *) intern:(NSString *)name
{
  return [symbolTable intern:name];
}


- (DslExpression*) bind:(DslSymbol*)symbol to:(DslExpression*)value
{
  return [symbolTable bind:symbol to:value];
}


- (DslExpression*) valueOf:(DslSymbol*)symbol
{
  return [symbolTable valueOf:symbol];
}


- (void) pushLocalBindings
{
  [symbolTable pushLocalBindings];
}


- (void) popLocalBindings
{
  [symbolTable popLocalBindings];
}


- (DslFunction*) lambda:(DslCons*)args
{
}


- (DslFunction*) defun:(DslCons*)args
{
}


- (DslFunction*) defBuiltin:(DslCons*)args
{
}


- (DslExpression*) apply:(DslCons*)args
{
}


- (DslExpression*) let:(DslCons*)args
{
}


- (DslCons*) cons:(DslCons*)args
{
  return [DslCons withHead:args.head andTail:args.tail.head];
}


- (DslExpression*) car:(DslCons*)args
{
  return args.head.head;
}


- (DslExpression*) cdr:(DslCons*)args
{
  return args.head.tail;
}


- (DslExpression*) caar:(DslCons*)args
{
  return args.head.head.head;

}


- (DslExpression*) cadr:(DslCons*)args
{
  return args.head.tail.head;

}


- (DslExpression*) cdar:(DslCons*)args
{
  return args.head.head.tail;
}


- (DslExpression*) cddr:(DslCons*)args
{
  return args.head.tail.tail;
}


- (DslExpression*) caaar:(DslCons*)args
{
  return args.head.head.head.head;
}


- (DslExpression*) caadr:(DslCons*)args
{
  return args.head.tail.head.head;
}


- (DslExpression*) cadar:(DslCons*)args
{
  return args.head.head.tail.head;
}


- (DslExpression*) caddr:(DslCons*)args
{
  return args.head.tail.tail.head;
}


- (DslExpression*) cdaar:(DslCons*)args
{
  return args.head.head.head.tail;
}


- (DslExpression*) cdadr:(DslCons*)args
{
  return args.head.tail.head.tail;
}


- (DslExpression*) cddar:(DslCons*)args
{
  return args.head.head.tail.tail;
}


- (DslExpression*) cdddr:(DslCons*)args
{
  return args.head.tail.head.tail;
}


- (DslNumber*) length:(DslCons*)args
{
  if (args == nil) return [DslNumber numberWith:0];

  DslCons *arg = args.head;
  int len = 0;
  while (![arg isNil]) {
    arg = arg.tail;
    len++;
  }
  return [DslNumber numberWith:len];
}


- (DslCons*) map:(DslCons*)args
{
}


- (DslCons*) select:(DslCons*)args
{
}


- (DslCons*) any:(DslCons*)args
{
}


- (DslCons*) cond:(DslCons*)args
{
}


- (DslBoolean*) logicalOr:(DslCons*)args
{
  if (args == nil) return [DslBoolean withFalse];
  
  DslCons *arg = args.head;

  while (![arg isNil]) {
    DslBoolean *result = [[self eval:arg.head] booleanValue];
    if ([result booleanValue]) return result;
    arg = arg.tail;
  }
  return [DslBoolean withFalse];  
}


- (DslBoolean*) logicalAnd:(DslCons*)args
{
  if (args == nil) return [DslBoolean withTrue];
  
  DslCons *arg = args.head;
  
  while (![arg isNil]) {
    DslBoolean *result = [[self eval:arg.head] booleanValue];
    if (![result booleanValue]) return result;
    arg = arg.tail;
  }
  return [DslBoolean withTrue];  
}


- (DslBoolean*) locicalNot:(DslCons*)args
{
  return [DslBoolean booleanWith:![args.head booleanValue]];
}


- (DslNumber*) add:(DslCons*)args
{
  if (args == nil) return [DslNumber numberWith:0];
  
  DslCons *arg = args.head;
  int sum = 0;
  while (![arg isNil]) {
    sum += [arg intValue];
    arg = arg.tail;
  }
  return [DslNumber numberWith:sum];
}


- (DslNumber*) subtract:(DslCons*)args
{
  if (args == nil) return [DslNumber numberWith:0];
  
  DslCons *arg = args.head;
  BOOL first = YES;
  int result = 0;
  while (![arg isNil]) {
    if (first) {
      result = [arg intValue];
      first = NO;
    } else {
      result -= [arg intValue];
    }
    arg = arg.tail;
  }
  return [DslNumber numberWith:result];
}


- (DslNumber*) multiply:(DslCons*)args
{
  if (args == nil) return [DslNumber numberWith:0];
  
  DslCons *arg = args.head;
  int product = 1;
  while (![arg isNil]) {
    product *= [arg intValue];
    arg = arg.tail;
  }
  return [DslNumber numberWith:product];
}


- (DslNumber*) divide:(DslCons*)args
{
  if (args == nil) return [DslNumber numberWith:0];
  
  DslCons *arg = args.head;
  BOOL first = YES;
  int quotient = 0;
  while (![arg isNil]) {
    if (first) {
      quotient = [arg intValue];
      first = NO;
    } else {
      quotient /= [arg intValue];
    }
    arg = arg.tail;
  }
  return [DslNumber numberWith:quotient];
}


- (DslNumber*) modulus:(DslCons*)args
{
  if (args == nil) return [DslNumber numberWith:0];
  if ([[self length:args] intValue] != 2) return [DslNumber numberWith:0];
  
  DslExpression *lval = args.head;
  DslExpression *rval = args.tail.head;

  return [DslNumber numberWith:([lval intValue] % [rval intValue])];
}




@end
