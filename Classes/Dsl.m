//
//  Dsl.m
//  DSL
//
//  Created by David Astels on 9/29/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "Dsl.h"
#import "SymbolTable.h"

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


- (Dsl *) init
{
  parser = [[DslParser alloc] init];
  symbolTable = [[SymbolTable alloc] init];
  [symbolTable bind:[self internal_intern:@"intern"]     to:[DslBuiltinFunction withTarget:self andSelector:@selector(intern:)]];
  [symbolTable bind:[self internal_intern:@"lambda"]     to:[DslBuiltinFunction withTarget:self andSelector:@selector(lambda:)]];
  [symbolTable bind:[self internal_intern:@"defun"]      to:[DslBuiltinFunction withTarget:self andSelector:@selector(defun:)]];
  [symbolTable bind:[self internal_intern:@"apply"]      to:[DslBuiltinFunction withTarget:self andSelector:@selector(apply:)]];
  [symbolTable bind:[self internal_intern:@"begin"]      to:[DslBuiltinFunction withTarget:self andSelector:@selector(begin:)]];
  [symbolTable bind:[self internal_intern:@"let"]        to:[DslBuiltinFunction withTarget:self andSelector:@selector(let:)]];
  [symbolTable bind:[self internal_intern:@"cons"]       to:[DslBuiltinFunction withTarget:self andSelector:@selector(cons:)]];
  [symbolTable bind:[self internal_intern:@"list"]       to:[DslBuiltinFunction withTarget:self andSelector:@selector(list:)]];
  [symbolTable bind:[self internal_intern:@"car"]        to:[DslBuiltinFunction withTarget:self andSelector:@selector(car:)]];
  [symbolTable bind:[self internal_intern:@"cdr"]        to:[DslBuiltinFunction withTarget:self andSelector:@selector(cdr:)]];
  [symbolTable bind:[self internal_intern:@"caar"]       to:[DslBuiltinFunction withTarget:self andSelector:@selector(caar:)]];
  [symbolTable bind:[self internal_intern:@"cadr"]       to:[DslBuiltinFunction withTarget:self andSelector:@selector(cadr:)]];
  [symbolTable bind:[self internal_intern:@"cdar"]       to:[DslBuiltinFunction withTarget:self andSelector:@selector(cdar:)]];
  [symbolTable bind:[self internal_intern:@"cddr"]       to:[DslBuiltinFunction withTarget:self andSelector:@selector(cddr:)]];
  [symbolTable bind:[self internal_intern:@"caaar"]      to:[DslBuiltinFunction withTarget:self andSelector:@selector(caaar:)]];
  [symbolTable bind:[self internal_intern:@"caadr"]      to:[DslBuiltinFunction withTarget:self andSelector:@selector(caadr:)]];
  [symbolTable bind:[self internal_intern:@"cadar"]      to:[DslBuiltinFunction withTarget:self andSelector:@selector(cadar:)]];
  [symbolTable bind:[self internal_intern:@"caddr"]      to:[DslBuiltinFunction withTarget:self andSelector:@selector(caddr:)]];
  [symbolTable bind:[self internal_intern:@"cdaar"]      to:[DslBuiltinFunction withTarget:self andSelector:@selector(cdaar:)]];
  [symbolTable bind:[self internal_intern:@"cdadr"]      to:[DslBuiltinFunction withTarget:self andSelector:@selector(cdadr:)]];
  [symbolTable bind:[self internal_intern:@"cddar"]      to:[DslBuiltinFunction withTarget:self andSelector:@selector(cddar:)]];
  [symbolTable bind:[self internal_intern:@"cdddr"]      to:[DslBuiltinFunction withTarget:self andSelector:@selector(cdddr:)]];
  [symbolTable bind:[self internal_intern:@"length"]     to:[DslBuiltinFunction withTarget:self andSelector:@selector(length:)]];
  [symbolTable bind:[self internal_intern:@"map"]        to:[DslBuiltinFunction withTarget:self andSelector:@selector(map:)]];
  [symbolTable bind:[self internal_intern:@"select"]     to:[DslBuiltinFunction withTarget:self andSelector:@selector(select:)]];
  [symbolTable bind:[self internal_intern:@"any?"]       to:[DslBuiltinFunction withTarget:self andSelector:@selector(any:)]];
  [symbolTable bind:[self internal_intern:@"cond"]       to:[DslBuiltinFunction withTarget:self andSelector:@selector(cond:)]];
  [symbolTable bind:[self internal_intern:@"or"]         to:[DslBuiltinFunction withTarget:self andSelector:@selector(logicalOr:)]];
  [symbolTable bind:[self internal_intern:@"and"]        to:[DslBuiltinFunction withTarget:self andSelector:@selector(logicalAnd:)]];
  [symbolTable bind:[self internal_intern:@"not"]        to:[DslBuiltinFunction withTarget:self andSelector:@selector(logicalNot:)]];
  [symbolTable bind:[self internal_intern:@"+"]          to:[DslBuiltinFunction withTarget:self andSelector:@selector(add:)]];
  [symbolTable bind:[self internal_intern:@"-"]          to:[DslBuiltinFunction withTarget:self andSelector:@selector(subtract:)]];
  [symbolTable bind:[self internal_intern:@"*"]          to:[DslBuiltinFunction withTarget:self andSelector:@selector(multiply:)]];
  [symbolTable bind:[self internal_intern:@"/"]          to:[DslBuiltinFunction withTarget:self andSelector:@selector(divide:)]];
  [symbolTable bind:[self internal_intern:@"%"]          to:[DslBuiltinFunction withTarget:self andSelector:@selector(modulus:)]];
  [symbolTable bind:[self internal_intern:@"<"]          to:[DslBuiltinFunction withTarget:self andSelector:@selector(lessThan:)]];
  [symbolTable bind:[self internal_intern:@"="]          to:[DslBuiltinFunction withTarget:self andSelector:@selector(equalTo:)]];
  [symbolTable bind:[self internal_intern:@">"]          to:[DslBuiltinFunction withTarget:self andSelector:@selector(greaterThan:)]];
  [symbolTable bind:[self internal_intern:@"getString"]  to:[DslBuiltinFunction withTarget:self andSelector:@selector(getString:)]];
  [symbolTable bind:[self internal_intern:@"getInteger"] to:[DslBuiltinFunction withTarget:self andSelector:@selector(getInteger:)]];
  [symbolTable bind:[self internal_intern:@"getBoolean"] to:[DslBuiltinFunction withTarget:self andSelector:@selector(getBoolean:)]];
  [symbolTable bind:[self internal_intern:@"quote"]      to:[DslBuiltinFunction withTarget:self andSelector:@selector(quote:)]];
  [symbolTable bind:[self internal_intern:@"'"]          to:[DslBuiltinFunction withTarget:self andSelector:@selector(quote:)]];
  
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


- (DslExpression*) begin:(DslCons*)args
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
  while (![pairs isNil]) {
    if ([[self eval:pairs.head.head] booleanValue]) {
      return [self evalEach:(DslCons*)pairs.head.tail];
    }
    pairs = (DslCons*)pairs.tail;
  }
  return NIL_CONS;
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
