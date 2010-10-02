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


+ (void) initialize
{
  DSL = [[Dsl alloc] init];
  NIL = [DslNil alloc];
}


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


- (DslFunction*) defBuiltinNamed:(NSString*)pName withTarget:(id)pTarget andSelector:(SEL)pSelector
{
  return (DslFunction*)[self bind:[self intern:pName] to:[DslBuiltinFunction withTarget:pTarget andSelector:pSelector]];
}


- (DslExpression*) apply:(DslFunction*)func to:(DslCons*)args
{
  return [func evalWithArguments:args];
}


- (DslExpression*) eval:(DslExpression*)sexp
{
  return [sexp eval];
}


- (DslFunction*) lambda:(DslCons*)args
{
  return [DslDefinedFunction withParameters:(DslCons*)args.head andBody:(DslCons*)args.tail];
}


- (DslFunction*) defun:(DslCons*)args
{
  return (DslFunction*)[self bind:(DslSymbol*)args.head to:[self lambda:(DslCons*)args.tail]];
}


- (DslExpression*) apply:(DslCons*)args
{
  DslFunction *function = (DslFunction*)[args.head eval];
  return [self apply:function to:(DslCons*)args.tail];
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

  DslCons *arg = (DslCons*)args.head;
  int len = 0;
  while (![arg isNil]) {
    arg = (DslCons*)arg.tail;
    len++;
  }
  return [DslNumber numberWith:len];
}


- (DslCons*) map:(DslCons*)args
{
  if (args == nil) return [DslCons empty];
  if ([[self length:args] intValue] != 2) return [DslCons empty];
  
  DslFunction *function = (DslFunction*)[self eval:args.head];
  DslCons *data = (DslCons*)[self eval:(DslCons*)args.tail.head];
  DslCons *result = [DslCons empty];
  DslCons *trailingCell = result;
  
  while (![data isNil]) {
    trailingCell.tail = [DslCons withHead:[self apply:function to:(DslCons*)data.head]];
    trailingCell = (DslCons*)trailingCell.tail;
    data = (DslCons*)data.tail;
  }
  trailingCell = (DslCons*)result.tail;
  result.tail = nil;
  [result release];
  return trailingCell;
}


- (DslCons*) select:(DslCons*)args
{
  if (args == nil) return [DslCons empty];
  if ([[self length:args] intValue] != 2) return [DslCons empty];
  
  DslFunction *predicate = (DslFunction*)[self eval:args.head];
  DslCons *data = [self eval:(DslCons*)args.tail.head];
  DslCons *result = [DslCons empty];
  DslCons *trailingCell = result;
  
  while (![data isNil]) {
    if ([[self apply:predicate to:data.head] boolValue]) {
      trailingCell.tail = [DslCons withHead:data.head];
      trailingCell = trailingCell.tail;
    }
    data = data.tail;
  }
  if ([result.tail isNil]) {
    return result;
  } else {
    trailingCell = result.tail;
    result.tail = nil;
    [result release];
    return trailingCell;
  }
}


- (DslCons*) any:(DslCons*)args
{
  if (args == nil) return [DslBoolean withFalse];
  if ([[self length:args] intValue] != 2) return [DslBoolean withFalse];
  
  DslFunction *predicate = (DslFunction*)[self eval:args.head];
  DslCons *data = [self eval:(DslCons*)args.tail.head];
  
  while (![data isNil]) {
    DslBoolean *result = [self apply:predicate to:data.head];
    if ([result booleanValue]) return result;
    data = data.tail;
  }
  return [DslBoolean withFalse];    
}


- (DslCons*) cond:(DslCons*)args
{
  if (args == nil) return [DslNil NIL];
  
  DslCons *pairs = args;
  while (![pairs isNil]) {
    if ([[self eval:pairs.head] boolValue]) {
      return [self eval:pairs.tail.head];
    }
    pairs = pairs.tail;
  }
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


- (DslString*) getString:(DslCons*)args
{
}


- (DslNumber*) getInteger:(DslCons*)args
{
}


- (DslBoolean*) getBoolean:(DslCons*)args
{
}


@end
