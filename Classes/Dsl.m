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
  [symbolTable bind:[self internal_intern:@"intern"]     to:[[DslBuiltinFunction withTarget:self andSelector:@selector(intern:)] retain]];
  [symbolTable bind:[self internal_intern:@"lambda"]     to:[[DslBuiltinFunction withTarget:self andSelector:@selector(lambda:)] retain]];
  [symbolTable bind:[self internal_intern:@"defun"]      to:[[DslBuiltinFunction withTarget:self andSelector:@selector(defun:)] retain]];
  [symbolTable bind:[self internal_intern:@"apply"]      to:[[DslBuiltinFunction withTarget:self andSelector:@selector(apply:)] retain]];
  [symbolTable bind:[self internal_intern:@"begin"]      to:[[DslBuiltinFunction withTarget:self andSelector:@selector(begin:)] retain]];
  [symbolTable bind:[self internal_intern:@"let"]        to:[[DslBuiltinFunction withTarget:self andSelector:@selector(let:)] retain]];
  [symbolTable bind:[self internal_intern:@"cons"]       to:[[DslBuiltinFunction withTarget:self andSelector:@selector(cons:)] retain]];
  [symbolTable bind:[self internal_intern:@"list"]       to:[[DslBuiltinFunction withTarget:self andSelector:@selector(list:)] retain]];
  [symbolTable bind:[self internal_intern:@"car"]        to:[[DslBuiltinFunction withTarget:self andSelector:@selector(car:)] retain]];
  [symbolTable bind:[self internal_intern:@"cdr"]        to:[[DslBuiltinFunction withTarget:self andSelector:@selector(cdr:)] retain]];
  [symbolTable bind:[self internal_intern:@"caar"]       to:[[DslBuiltinFunction withTarget:self andSelector:@selector(caar:)] retain]];
  [symbolTable bind:[self internal_intern:@"cadr"]       to:[[DslBuiltinFunction withTarget:self andSelector:@selector(cadr:)] retain]];
  [symbolTable bind:[self internal_intern:@"cdar"]       to:[[DslBuiltinFunction withTarget:self andSelector:@selector(cdar:)] retain]];
  [symbolTable bind:[self internal_intern:@"cddr"]       to:[[DslBuiltinFunction withTarget:self andSelector:@selector(cddr:)] retain]];
  [symbolTable bind:[self internal_intern:@"caaar"]      to:[[DslBuiltinFunction withTarget:self andSelector:@selector(caaar:)] retain]];
  [symbolTable bind:[self internal_intern:@"caadr"]      to:[[DslBuiltinFunction withTarget:self andSelector:@selector(caadr:)] retain]];
  [symbolTable bind:[self internal_intern:@"cadar"]      to:[[DslBuiltinFunction withTarget:self andSelector:@selector(cadar:)] retain]];
  [symbolTable bind:[self internal_intern:@"caddr"]      to:[[DslBuiltinFunction withTarget:self andSelector:@selector(caddr:)] retain]];
  [symbolTable bind:[self internal_intern:@"cdaar"]      to:[[DslBuiltinFunction withTarget:self andSelector:@selector(cdaar:)] retain]];
  [symbolTable bind:[self internal_intern:@"cdadr"]      to:[[DslBuiltinFunction withTarget:self andSelector:@selector(cdadr:)] retain]];
  [symbolTable bind:[self internal_intern:@"cddar"]      to:[[DslBuiltinFunction withTarget:self andSelector:@selector(cddar:)] retain]];
  [symbolTable bind:[self internal_intern:@"cdddr"]      to:[[DslBuiltinFunction withTarget:self andSelector:@selector(cdddr:)] retain]];
  [symbolTable bind:[self internal_intern:@"length"]     to:[[DslBuiltinFunction withTarget:self andSelector:@selector(length:)] retain]];
  [symbolTable bind:[self internal_intern:@"map"]        to:[[DslBuiltinFunction withTarget:self andSelector:@selector(map:)] retain]];
  [symbolTable bind:[self internal_intern:@"select"]     to:[[DslBuiltinFunction withTarget:self andSelector:@selector(select:)] retain]];
  [symbolTable bind:[self internal_intern:@"any?"]       to:[[DslBuiltinFunction withTarget:self andSelector:@selector(any:)] retain]];
  [symbolTable bind:[self internal_intern:@"cond"]       to:[[DslBuiltinFunction withTarget:self andSelector:@selector(cond:)] retain]];
  [symbolTable bind:[self internal_intern:@"or"]         to:[[DslBuiltinFunction withTarget:self andSelector:@selector(logicalOr:)] retain]];
  [symbolTable bind:[self internal_intern:@"and"]        to:[[DslBuiltinFunction withTarget:self andSelector:@selector(logicalAnd:)] retain]];
  [symbolTable bind:[self internal_intern:@"not"]        to:[[DslBuiltinFunction withTarget:self andSelector:@selector(logicalNot:)] retain]];
  [symbolTable bind:[self internal_intern:@"+"]          to:[[DslBuiltinFunction withTarget:self andSelector:@selector(add:)] retain]];
  [symbolTable bind:[self internal_intern:@"-"]          to:[[DslBuiltinFunction withTarget:self andSelector:@selector(subtract:)] retain]];
  [symbolTable bind:[self internal_intern:@"*"]          to:[[DslBuiltinFunction withTarget:self andSelector:@selector(multiply:)] retain]];
  [symbolTable bind:[self internal_intern:@"/"]          to:[[DslBuiltinFunction withTarget:self andSelector:@selector(divide:)] retain]];
  [symbolTable bind:[self internal_intern:@"%"]          to:[[DslBuiltinFunction withTarget:self andSelector:@selector(modulus:)] retain]];
  [symbolTable bind:[self internal_intern:@"<"]          to:[[DslBuiltinFunction withTarget:self andSelector:@selector(lessThan:)] retain]];
  [symbolTable bind:[self internal_intern:@"="]          to:[[DslBuiltinFunction withTarget:self andSelector:@selector(equalTo:)] retain]];
  [symbolTable bind:[self internal_intern:@">"]          to:[[DslBuiltinFunction withTarget:self andSelector:@selector(greaterThan:)] retain]];
  [symbolTable bind:[self internal_intern:@"getString"]  to:[[DslBuiltinFunction withTarget:self andSelector:@selector(getString:)] retain]];
  [symbolTable bind:[self internal_intern:@"getInteger"] to:[[DslBuiltinFunction withTarget:self andSelector:@selector(getInteger:)] retain]];
  [symbolTable bind:[self internal_intern:@"getBoolean"] to:[[DslBuiltinFunction withTarget:self andSelector:@selector(getBoolean:)] retain]];
  [symbolTable bind:[self internal_intern:@"quote"]      to:[[DslBuiltinFunction withTarget:self andSelector:@selector(quote:)] retain]];
  [symbolTable bind:[self internal_intern:@"'"]      to:[[DslBuiltinFunction withTarget:self andSelector:@selector(quote:)] retain]];
  
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
  [result release];
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
  [result release];
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
