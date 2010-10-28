//
//  Dsl.m
//  DSL
//
//  Created by David Astels on 9/29/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "Dsl.h"
#import "SymbolTable.h"
#import "DslDefinedFunction.h"
#import "DslBuiltinFunction.h"

Dsl *DSL = nil;
DslNil *NIL_CONS = nil;

@implementation Dsl


+ (void) initialize
{
  if (DSL == nil) {
    NIL_CONS = [[DslNil alloc] retain];
    DSL = [[[Dsl alloc] init] retain];
  }
}


- (DslExpression*) bindName:(NSString*)name toTarget:(NSObject*)target andSelector:(SEL)selector
{
  return [self bind:[self internal_intern:name] to:[DslBuiltinFunction withTarget:target andSelector:selector]];
}


- (Dsl *) init
{
  parser = [[DslParser alloc] init];
  symbolTable = [[SymbolTable alloc] init];
  [self bindName:@"intern"     toTarget:self andSelector:@selector(intern:)];
  [self bindName:@"lambda"     toTarget:self andSelector:@selector(lambda:)];
  [self bindName:@"defun"      toTarget:self andSelector:@selector(defun:)];
  [self bindName:@"apply"      toTarget:self andSelector:@selector(apply:)];
  [self bindName:@"do"         toTarget:self andSelector:@selector(doList:)];
  [self bindName:@"let"        toTarget:self andSelector:@selector(let:)];
  [self bindName:@"cons"       toTarget:self andSelector:@selector(cons:)];
  [self bindName:@"list"       toTarget:self andSelector:@selector(list:)];
//  [self bindName:@"first"       toTarget:self andSelector:@selector(first:)];
//  [self bindName:@"second"       toTarget:self andSelector:@selector(second:)];
//  [self bindName:@"third"       toTarget:self andSelector:@selector(third:)];
//  [self bindName:@"fourth"       toTarget:self andSelector:@selector(fourth:)];
//  [self bindName:@"fifth"       toTarget:self andSelector:@selector(fifth:)];
//  [self bindName:@"sixth"       toTarget:self andSelector:@selector(sixth:)];
//  [self bindName:@"seventh"       toTarget:self andSelector:@selector(seventh:)];
//  [self bindName:@"eigth"       toTarget:self andSelector:@selector(eigth:)];
//  [self bindName:@"nineth"       toTarget:self andSelector:@selector(ninth:)];
//  [self bindName:@"tenth"       toTarget:self andSelector:@selector(tenth:)];
  [self bindName:@"car"        toTarget:self andSelector:@selector(car:)];
  [self bindName:@"cdr"        toTarget:self andSelector:@selector(cdr:)];
  [self bindName:@"caar"       toTarget:self andSelector:@selector(caar:)];
  [self bindName:@"cadr"       toTarget:self andSelector:@selector(cadr:)];
  [self bindName:@"cdar"       toTarget:self andSelector:@selector(cdar:)];
  [self bindName:@"cddr"       toTarget:self andSelector:@selector(cddr:)];
  [self bindName:@"caaar"      toTarget:self andSelector:@selector(caaar:)];
  [self bindName:@"caadr"      toTarget:self andSelector:@selector(caadr:)];
  [self bindName:@"cadar"      toTarget:self andSelector:@selector(cadar:)];
  [self bindName:@"caddr"      toTarget:self andSelector:@selector(caddr:)];
  [self bindName:@"cdaar"      toTarget:self andSelector:@selector(cdaar:)];
  [self bindName:@"cdadr"      toTarget:self andSelector:@selector(cdadr:)];
  [self bindName:@"cddar"      toTarget:self andSelector:@selector(cddar:)];
  [self bindName:@"cdddr"      toTarget:self andSelector:@selector(cdddr:)];
  [self bindName:@"length"     toTarget:self andSelector:@selector(length:)];
  [self bindName:@"map"        toTarget:self andSelector:@selector(map:)];
  [self bindName:@"select"     toTarget:self andSelector:@selector(select:)];
  [self bindName:@"any?"       toTarget:self andSelector:@selector(any:)];
  [self bindName:@"if"         toTarget:self andSelector:@selector(if:)];
  [self bindName:@"cond"       toTarget:self andSelector:@selector(cond:)];
  [self bindName:@"or"         toTarget:self andSelector:@selector(logicalOr:)];
  [self bindName:@"and"        toTarget:self andSelector:@selector(logicalAnd:)];
  [self bindName:@"not"        toTarget:self andSelector:@selector(logicalNot:)];
  [self bindName:@"+"          toTarget:self andSelector:@selector(add:)];
  [self bindName:@"-"          toTarget:self andSelector:@selector(subtract:)];
  [self bindName:@"*"          toTarget:self andSelector:@selector(multiply:)];
  [self bindName:@"/"          toTarget:self andSelector:@selector(divide:)];
  [self bindName:@"%"          toTarget:self andSelector:@selector(modulus:)];
  [self bindName:@"<"          toTarget:self andSelector:@selector(lessThan:)];
  [self bindName:@"="          toTarget:self andSelector:@selector(equalTo:)];
  [self bindName:@">"          toTarget:self andSelector:@selector(greaterThan:)];
  [self bindName:@"getString"  toTarget:self andSelector:@selector(getString:)];
  [self bindName:@"getInteger" toTarget:self andSelector:@selector(getInteger:)];
  [self bindName:@"getBoolean" toTarget:self andSelector:@selector(getBoolean:)];
  [self bindName:@"quote"      toTarget:self andSelector:@selector(quote:)];
  [self bindName:@"'"          toTarget:self andSelector:@selector(quote:)];
  
  return self;  
}


- (DslExpression*) parse:(NSString*)codeString
{
  return [parser parseExpression:[InputStream withString:codeString]];
}


- (DslSymbol*) internal_intern:(NSString *)name
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
  return (DslFunction*)[self bind:[self internal_intern:pName] to:[DslBuiltinFunction withTarget:pTarget andSelector:pSelector]];
}


- (DslExpression*) apply:(DslFunction*)func to:(DslCons*)args
{
  return [func evalWithArguments:args];
}


- (DslExpression*) apply:(DslCons*)args
{
  DslFunction *func = (DslFunction*)[args.head eval];
  return [func evalWithArguments:(DslCons*)args.tail];
}


- (DslExpression*) eval:(DslExpression*)sexp
{
  return [sexp eval];
}


- (DslExpression*) evalEach:(DslCons*)list
{
  DslExpression *result = NIL_CONS;
  while ([list notNil]) {
    result = [list.head eval];
    list = (DslCons*)list.tail;
  }
  return result;
}


- (DslExpression*) doList:(DslCons*)args
{
  return [self evalEach:args];
}


- (DslExpression*) quote:(DslCons*)args
{
  return args.head;
}


- (DslFunction*) lambda:(DslCons*)args
{
  return [DslDefinedFunction withParameters:(DslCons*)args.head andBody:(DslCons*)args.tail];
}


- (DslFunction*) defun:(DslCons*)args
{
  return (DslFunction*)[self bind:(DslSymbol*)args.head to:[self lambda:(DslCons*)args.tail]];
}


- (DslExpression*) let:(DslCons*)args
{
  DslCons *bindings = (DslCons*)args.head;
  DslCons *body = (DslCons*)args.tail;
  
  [self pushLocalBindings];
  while ([bindings notNil]) {
    DslCons *binding = (DslCons*)bindings.head;
    DslSymbol *sym = (DslSymbol*)binding.head;
    DslExpression *value = [binding.tail.head eval];
    [self bind:sym to:value];
    bindings = (DslCons*)bindings.tail;
  }
  DslExpression *result = [self evalEach:body];
  [self popLocalBindings];
  return result;
}


- (DslSymbol *) intern:(DslCons *)args
{
  return [symbolTable intern:[(DslString*)args.head stringValue]];
}


- (DslCons*) cons:(DslCons*)args
{
  return [DslCons withHead:args.head andTail:args.tail.head];
}


- (DslCons*) list:(DslCons*)args
{
  if (args == nil) return NIL_CONS;
  if ([args isNil]) return NIL_CONS;
  DslCons *result = [DslCons empty];
  DslCons *tail = result;
  
  while ([args notNil]) {
    tail.tail = [DslCons withHead:[args.head eval]];
    tail = (DslCons*)tail.tail;
    args = (DslCons*)args.tail;
  }
  
  return result.tail;
}


- (DslExpression*) car:(DslCons*)args
{
  return [args.head eval].head;
}


- (DslExpression*) cdr:(DslCons*)args
{
  return [args.head eval].tail;
}


- (DslExpression*) caar:(DslCons*)args
{
  return [args.head eval].head.head;

}


- (DslExpression*) cadr:(DslCons*)args
{
  return [args.head eval].tail.head;

}


- (DslExpression*) cdar:(DslCons*)args
{
  return [args.head eval].head.tail;
}


- (DslExpression*) cddr:(DslCons*)args
{
  return [args.head eval].tail.tail;
}


- (DslExpression*) caaar:(DslCons*)args
{
  return [args.head eval].head.head.head;
}


- (DslExpression*) caadr:(DslCons*)args
{
  return [args.head eval].tail.head.head;
}


- (DslExpression*) cadar:(DslCons*)args
{
  return [args.head eval].head.tail.head;
}


- (DslExpression*) caddr:(DslCons*)args
{
  return [args.head eval].tail.tail.head;
}


- (DslExpression*) cdaar:(DslCons*)args
{
  return [args.head eval].head.head.tail;
}


- (DslExpression*) cdadr:(DslCons*)args
{
  return [args.head eval].tail.head.tail;
}


- (DslExpression*) cddar:(DslCons*)args
{
  return [args.head eval].head.tail.tail;
}


- (DslExpression*) cdddr:(DslCons*)args
{
  return [args.head eval].tail.tail.tail;
}


- (int) internalLength:(DslCons*)list
{
  if ([list isNil]) {
    return 0;
  } else if ([list isKindOfClass:[DslCons class]]) {
    int len = 0;
    while ([list notNil]) {
      list = (DslCons*)list.tail;
      len++;
    }
    return len;
  } else {
    return 1;
  }
}


- (DslNumber*) length:(DslCons*)args
{
  if (args == nil) return [DslNumber numberWith:0];
  return [DslNumber numberWith:[self internalLength:(DslCons*)[args.head eval]]];
}


- (DslCons*) map:(DslCons*)args
{
  if (args == nil) return [DslCons empty];
  if ([self internalLength:args] != 2) return [DslCons empty];
  
  DslFunction *function = (DslFunction*)[self eval:args.head];
  DslCons *data = (DslCons*)[self eval:(DslCons*)args.tail.head];
  DslCons *result = [DslCons empty];
  DslCons *trailingCell = result;
  
  while (![data isNil]) {
    trailingCell.tail = [DslCons withHead:[self apply:function to:[DslCons withHead:data.head]]];
    trailingCell = (DslCons*)trailingCell.tail;
    data = (DslCons*)data.tail;
  }
  trailingCell = (DslCons*)result.tail;
  result.tail = nil;
  return trailingCell;
}


- (DslCons*) select:(DslCons*)args
{
  if (args == nil) return [DslCons empty];
  if ([self internalLength:args] != 2) return [DslCons empty];
  
  DslFunction *predicate = (DslFunction*)[args.head eval];
  DslCons *data = (DslCons*)[args.tail.head eval];
  DslCons *result = [DslCons empty];
  DslCons *trailingCell = result;
  
  while ([data notNil]) {
    if ([[self apply:predicate to:[DslCons withHead:data.head]] booleanValue]) {
      trailingCell.tail = [DslCons withHead:data.head];
      trailingCell = (DslCons*)trailingCell.tail;
    }
    data = (DslCons*)data.tail;
  }
  trailingCell = (DslCons*)result.tail;
  result.tail = nil;
  return trailingCell;
}


- (DslBoolean*) any:(DslCons*)args
{
  if (args == nil) return [DslBoolean withFalse];
  if ([self internalLength:args] != 2) return [DslBoolean withFalse];

  DslFunction *predicate = (DslFunction*)[args.head eval];
  DslCons *data = (DslCons*)[args.tail.head eval];
  while ([data notNil]) {
    DslBoolean *result = (DslBoolean*)[self apply:predicate to:[DslCons withHead:data.head]];
    if ([result booleanValue]) return result;
    data = (DslCons*)data.tail;
  }
  return [DslBoolean withFalse];    
}


- (DslExpression*) cond:(DslCons*)args
{
  if (args == nil) return NIL_CONS;
  
  DslCons *pairs = args;
  while ([pairs notNil]) {
    if ([[self eval:pairs.head.head] booleanValue]) {
      return [self evalEach:(DslCons*)pairs.head.tail];
    }
    pairs = (DslCons*)pairs.tail;
  }
  return NIL_CONS;
}


- (DslExpression*) if:(DslCons*)args
{
  if ([args isNil]  || [args.head isNil]) return NIL_CONS;
  
  DslExpression *condition = [args.head eval];
  if ([condition booleanValue]) {
    return ([args.tail isNil] || [args.tail.head isNil]) ? NIL_CONS : [args.tail.head eval];
  } else {
    return ([args.tail isNil] || [args.tail.tail isNil] || [args.tail.tail.head isNil]) ? NIL_CONS : [args.tail.tail.head eval];
  }
}


- (DslBoolean*) logicalOr:(DslCons*)args
{
  if (args == nil) return [DslBoolean withFalse];
  
  while ([args notNil]) {
    DslBoolean *result = (DslBoolean*)[args.head eval];
    if ([result booleanValue]) return result;
    args = (DslCons*)args.tail;
  }
  return [DslBoolean withFalse];  
}


- (DslBoolean*) logicalAnd:(DslCons*)args
{
  if (args == nil) return [DslBoolean withTrue];
  
  while ([args notNil]) {
    DslBoolean *result = (DslBoolean*)[args.head eval];
    if (![result booleanValue]) return result;
    args = (DslCons*)args.tail;
  }
  return [DslBoolean withTrue];  
}


- (DslBoolean*) logicalNot:(DslCons*)args
{
  return [DslBoolean booleanWith:![args.head booleanValue]];
}


- (DslNumber*) add:(DslCons*)args
{
  if (args == nil) return [DslNumber numberWith:0];
  
  DslCons *arg = args;
  int sum = 0;
  while ([arg notNil]) {
    sum += [[arg.head eval] intValue];
    arg = (DslCons*)arg.tail;
  }
  return [DslNumber numberWith:sum];
}


- (DslNumber*) subtract:(DslCons*)args
{
  if (args == nil) return [DslNumber numberWith:0];
  
  DslCons *arg = args;
  BOOL first = YES;
  int result = 0;
  while ([arg notNil]) {
    if (first) {
      result = [[arg.head eval] intValue];
      first = NO;
    } else {
      result -= [[arg.head eval] intValue];
    }
    arg = (DslCons*)arg.tail;
  }
  return [DslNumber numberWith:result];
}


- (DslNumber*) multiply:(DslCons*)args
{
  if (args == nil) return [DslNumber numberWith:0];
  
  DslCons *arg = args;
  int product = 1;
  while (![arg isNil]) {
    product *= [[arg.head eval] intValue];
    arg = (DslCons*)arg.tail;
  }
  return [DslNumber numberWith:product];
}


- (DslNumber*) divide:(DslCons*)args
{
  if (args == nil) return [DslNumber numberWith:0];
  
  DslCons *arg = args;
  BOOL first = YES;
  int quotient = 0;
  while (![arg isNil]) {
    if (first) {
      quotient = [[arg.head eval] intValue];
      first = NO;
    } else {
      quotient /= [[arg.head eval] intValue];
    }
    arg = (DslCons*)arg.tail;
  }
  return [DslNumber numberWith:quotient];
}


- (DslNumber*) modulus:(DslCons*)args
{
  if (args == nil) return [DslNumber numberWith:0];
  if ([self internalLength:args] != 2) return [DslNumber numberWith:0];
  
  DslExpression *lval = args.head;
  DslExpression *rval = args.tail.head;

  return [DslNumber numberWith:([lval intValue] % [rval intValue])];
}


- (DslBoolean*) lessThan:(DslCons*)args
{
  if (args == nil) return [DslBoolean withFalse];
  if ([self internalLength:args] != 2) return [DslBoolean withFalse];
  
  DslExpression *lval = [args.head eval];
  DslExpression *rval = [args.tail.head eval];

  return [DslBoolean booleanWith:([lval intValue] < [rval intValue])];
}


- (DslBoolean*) greaterThan:(DslCons*)args
{
  if (args == nil) return [DslBoolean withFalse];
  if ([self internalLength:args] != 2) return [DslBoolean withFalse];
  
  DslExpression *lval = [args.head eval];
  DslExpression *rval = [args.tail.head eval];
  
  return [DslBoolean booleanWith:([lval intValue] > [rval intValue])];
}


- (DslBoolean*) equalTo:(DslCons*)args
{
  if (args == nil) return [DslBoolean withFalse];
  if ([self internalLength:args] != 2) return [DslBoolean withFalse];
  
  DslExpression *lval = [args.head eval];
  DslExpression *rval = [args.tail.head eval];
  
  return [DslBoolean booleanWith:([lval intValue] == [rval intValue])];
}


- (DslString*) getString:(DslCons*)args
{
  DslObject *obj = (DslObject*)[args.head eval];
  DslSymbol *sel = (DslSymbol*)[args.tail.head eval];
  return [obj getString:[sel identifierValue]];
}


- (DslNumber*) getInteger:(DslCons*)args
{
  DslObject *obj = (DslObject*)[args.head eval];
  DslSymbol *sel = (DslSymbol*)[args.tail.head eval];
  return [obj getInteger:[sel identifierValue]];
}


- (DslBoolean*) getBoolean:(DslCons*)args
{
  DslObject *obj = (DslObject*)[args.head eval];
  DslSymbol *sel = (DslSymbol*)[args.tail.head eval];
  return [obj getBoolean:[sel identifierValue]];
}


@end
