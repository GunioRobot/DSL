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
  return [self bind:[self internalIntern:name] to:[DslBuiltinFunction withTarget:target andSelector:selector]];
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
  [self bindName:@"first"      toTarget:self andSelector:@selector(first:)];
  [self bindName:@"second"     toTarget:self andSelector:@selector(second:)];
  [self bindName:@"third"      toTarget:self andSelector:@selector(third:)];
  [self bindName:@"fourth"     toTarget:self andSelector:@selector(fourth:)];
  [self bindName:@"fifth"      toTarget:self andSelector:@selector(fifth:)];
  [self bindName:@"sixth"      toTarget:self andSelector:@selector(sixth:)];
  [self bindName:@"seventh"    toTarget:self andSelector:@selector(seventh:)];
  [self bindName:@"eighth"     toTarget:self andSelector:@selector(eighth:)];
  [self bindName:@"ninth"      toTarget:self andSelector:@selector(ninth:)];
  [self bindName:@"tenth"      toTarget:self andSelector:@selector(tenth:)];
  [self bindName:@"nth"        toTarget:self andSelector:@selector(nth:)];
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
  [self bindName:@"map"        toTarget:self andSelector:@selector(collect:)];
  [self bindName:@"collect"    toTarget:self andSelector:@selector(collect:)];
  [self bindName:@"select"     toTarget:self andSelector:@selector(select:)];
  [self bindName:@"filter"     toTarget:self andSelector:@selector(select:)];
  [self bindName:@"reduce"     toTarget:self andSelector:@selector(inject:)];
  [self bindName:@"inject"     toTarget:self andSelector:@selector(inject:)];
  [self bindName:@"any?"       toTarget:self andSelector:@selector(any:)];
  [self bindName:@"detect"     toTarget:self andSelector:@selector(any:)];
  [self bindName:@"all?"       toTarget:self andSelector:@selector(all:)];
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
  [self bindName:@"setString"  toTarget:self andSelector:@selector(setString:)];
  [self bindName:@"setInteger" toTarget:self andSelector:@selector(setInteger:)];
  [self bindName:@"setBoolean" toTarget:self andSelector:@selector(setBoolean:)];
  [self bindName:@"quote"      toTarget:self andSelector:@selector(quote:)];
  [self bindName:@"acons"      toTarget:self andSelector:@selector(acons:)];
  [self bindName:@"pairlis"    toTarget:self andSelector:@selector(pairlis:)];
  [self bindName:@"zip"        toTarget:self andSelector:@selector(pairlis:)];
  [self bindName:@"assoc"      toTarget:self andSelector:@selector(assoc:)];
  [self bindName:@"rassoc"     toTarget:self andSelector:@selector(rassoc:)];
  [self bindName:@"load"       toTarget:self andSelector:@selector(load:)];
  
  return self;  
}


- (DslExpression*) parse:(NSString*)codeString
{
  return [parser parseExpression:[InputStream withString:codeString]];
}


- (DslSymbol*) internalIntern:(NSString *)name
{
  return [symbolTable intern:name];
}


- (DslCons*) arrayToList:(NSArray*)anArray
{
  DslCons *list = [DslCons withHead:[anArray objectAtIndex:0]];
  DslCons *tail = list;
  int limit = [anArray count];
  
  for (int index = 1; index < limit; index++) {
    tail.tail = [DslCons withHead:[anArray objectAtIndex:index]];
    tail = (DslCons*)tail.tail;
  }
  
  return list;
}


- (DslCons*) makeList:(DslExpression*)firstObject, ...
{
  va_list argumentList;
  DslExpression *eachObject;
  DslCons *list = [DslCons withHead:firstObject];
  DslCons *tail = list;
  
  va_start(argumentList, firstObject);
  while (eachObject = va_arg(argumentList, DslExpression*)) {
    tail.tail = [DslCons withHead:eachObject];
    tail = (DslCons*)tail.tail;
  }
  va_end(argumentList);
  return list;
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
  
  return (DslCons*)result.tail;
}


- (DslExpression*) getNth:(int)n from:(DslCons*)list
{
  DslCons *pointer = list;
  for (int i = 1; i < n; i++) {
    pointer = (DslCons*)pointer.tail;
  }
  return pointer.head;
}


- (DslExpression*) nth:(DslCons*)args
{
  int index = [[args.head eval] intValue];
  DslCons *list = (DslCons*)[args.tail.head eval];
  return [self getNth:index from:list];
}


- (DslExpression*) first:(DslCons*)args
{
  return [self getNth:1 from:(DslCons*)[args.head eval]];
}


- (DslExpression*) second:(DslCons*)args
{
  return [self getNth:2 from:(DslCons*)[args.head eval]];
}


- (DslExpression*) third:(DslCons*)args
{
  return [self getNth:3 from:(DslCons*)[args.head eval]];
}


- (DslExpression*) fourth:(DslCons*)args
{
  return [self getNth:4 from:(DslCons*)[args.head eval]];
}


- (DslExpression*) fifth:(DslCons*)args
{
  return [self getNth:5 from:(DslCons*)[args.head eval]];
}


- (DslExpression*) sixth:(DslCons*)args
{
  return [self getNth:6 from:(DslCons*)[args.head eval]];
}


- (DslExpression*) seventh:(DslCons*)args
{
  return [self getNth:7 from:(DslCons*)[args.head eval]];
}


- (DslExpression*) eighth:(DslCons*)args
{
  return [self getNth:8 from:(DslCons*)[args.head eval]];
}


- (DslExpression*) ninth:(DslCons*)args
{
  return [self getNth:9 from:(DslCons*)[args.head eval]];
}


- (DslExpression*) tenth:(DslCons*)args
{
  return [self getNth:10 from:(DslCons*)[args.head eval]];
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


- (DslCons*) collect:(DslCons*)args
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


- (DslExpression*) inject:(DslCons*)args
{
  if ([args isNil]) return NIL_CONS;
  if ([self internalLength:args] == 1) return NIL_CONS;
  

  DslFunction *function = (DslFunction*)[self eval:args.head];
  DslExpression *seed = [self eval:args.tail.head];
  DslCons *data;
  
  if ([self internalLength:args] == 2) {
    if ([seed isList]) {
      data = seed.tail;
      seed = seed.head;
    } else {
      return seed;
    }
  } else {
    data = (DslCons*)[self eval:(DslCons*)args.tail.tail.head];
  }
  
  DslExpression *result = seed;
  
  while ([data notNil]) {
    result = [self apply:function to:[self makeList:result, data.head, nil]];
    data = (DslCons*)data.tail;
  }
  return result;
}


- (DslBoolean*) any:(DslCons*)args
{
  if ([args isNil]) return [DslBoolean withFalse];
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


- (DslBoolean*) all:(DslCons*)args
{
  if ([args isNil]) return [DslBoolean withTrue];
  if ([self internalLength:args] != 2) return [DslBoolean withFalse];
  
  DslFunction *predicate = (DslFunction*)[args.head eval];
  DslCons *data = (DslCons*)[args.tail.head eval];
  while ([data notNil]) {
    DslBoolean *result = (DslBoolean*)[self apply:predicate to:[DslCons withHead:data.head]];
    if (![result booleanValue]) return result;
    data = (DslCons*)data.tail;
  }
  return [DslBoolean withTrue];    
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
  return [DslBoolean booleanWith:![[args.head eval] booleanValue]];
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


- (DslString*) setString:(DslCons*)args
{
  DslObject *obj = (DslObject*)[args.head eval];
  DslSymbol *sel = (DslSymbol*)[args.tail.head eval];
  return [obj setString:[sel identifierValue]];
}


- (DslNumber*) setInteger:(DslCons*)args
{
  DslObject *obj = (DslObject*)[args.head eval];
  DslSymbol *sel = (DslSymbol*)[args.tail.head eval];
  return [obj setInteger:[sel identifierValue]];
}


- (DslBoolean*) setBoolean:(DslCons*)args
{
  DslObject *obj = (DslObject*)[args.head eval];
  DslSymbol *sel = (DslSymbol*)[args.tail.head eval];
  return [obj setBoolean:[sel identifierValue]];
}


- (DslCons*) acons:(DslCons*)args
{
  DslExpression *key = [args.head eval];
  DslExpression *value = [args.tail.head eval];
  DslCons *list = (DslCons*)[args.tail.tail.head eval];
  DslCons *pair = [DslCons withHead:key andTail:value];
  return [DslCons withHead:pair andTail:list];
}


- (DslCons*) pairlis:(DslCons*)args
{
  DslCons *keys = (DslCons*)[args.head eval];
  DslCons *values = (DslCons*)[args.tail.head eval];
  NSMutableArray *temp = [NSMutableArray arrayWithCapacity:5];
  while ([keys notNil] && [values notNil]) {
    DslCons *pair = [DslCons withHead:keys.head andTail:values.head];
    [temp insertObject:pair atIndex:0];
    keys = (DslCons*)keys.tail;
    values = (DslCons*)values.tail;
  }
  DslCons *result = NIL_CONS;
  for (DslCons *pair in temp) {
    result = [DslCons withHead:pair andTail:result];
  }
  return result;
}


- (DslCons*) assoc:(DslCons*)args
{
  DslExpression *key = [args.head eval];
  DslCons *list = (DslCons*)[args.tail.head eval];
  while ([list notNil]) {
    if ([list.head.head compareTo:key]) {
      return (DslCons*)list.head;
    }
    list = (DslCons*)list.tail;
  }
  return NIL_CONS;
}


- (DslCons*) rassoc:(DslCons*)args
{
  DslExpression *value = [args.head eval];
  DslCons *list = (DslCons*)[args.tail.head eval];
  while ([list notNil]) {
    if ([list.head.tail compareTo:value]) {
      return (DslCons*)list.head;
    }
    list = (DslCons*)list.tail;
  }
  return NIL_CONS;
}


- (DslExpression*) loadFile:(NSString*)filebasename
{
  NSString *pathName = [[NSBundle mainBundle] pathForResource:filebasename ofType:@"lsp" inDirectory:nil];
  InputStream *input = [InputStream withFile:pathName];
  if (input != nil) {
    DslCons *sexprs = [parser parse:input];
    return [self evalEach:sexprs];
  } else {
    return NIL_CONS;
  }
}


- (DslExpression*) load:(DslCons*)args
{
  DslString *filename = [args.head eval];
  return [self loadFile:[filename stringValue]];
}



@end
