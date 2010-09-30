//
//  DslCons.m
//  DSL
//
//  Created by David Astels on 4/12/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "DslCons.h"
#import "DslNumber.h"
#import "DslSymbol.h"
#import "DslString.h"
#import "DslFunction.h"
#import "DslDefinedFunction.h"
#import "Functions.h"


@implementation DslCons


+ (DslCons*) withHead:(DslExpression*)h
{
  return [[DslCons alloc] initWithHead:h];
}


+ (DslCons*) withHead:(DslExpression*)h andTail:(DslExpression*)t
{
  return [[DslCons alloc] initWithHead:h andTail:t];
}

+ (DslCons*) quote:(DslExpression*)expr
{
  return [DslCons withHead:[DslSymbol withName:@"quote"] andTail:[DslCons withHead:expr]];
}


- (DslCons*) init
{
  head = nil;
  tail = nil;
  return self;
}


- (DslCons*) initWithHead:(DslExpression*)h
{
  head = h;
  tail = nil;
  return self;
}


- (DslCons*) initWithHead:(DslExpression*)h andTail:(DslExpression*)t
{
  head = h;
  tail = t;
  return self;
}


- (DslExpression*)head
{
  return head;
}


- (DslExpression*)tail
{
  return tail;
}


- (void) setHead:(DslExpression*)h
{
  head = h;
}


- (void) setTail:(DslExpression*)t
{
  tail = t;
}


//- (DslExpression*) length
//{
//  if ([self cdr]) return [DslNumber numberWith:(1 + [[[self cdr] length] intValue])];
//  if ([self car]) return [DslNumber numberWith:1];
//  return [DslNumber numberWith:0];
//}


- (DslExpression*) evalEach:(DslCons*)bindings
{
  DslExpression *value = [[self car] eval:bindings];
  if ([self cdr]) {
    return [[self cdr] evalEach:bindings];
  } else {
    return value;
  }
}


- (DslExpression*) apply:(DslCons*)args withBindings:(DslCons*)bindings
{
  DslFunction *func = (DslFunction*)[[args car] eval:bindings];
  DslCons *functionArgs = (DslCons*)[args cdr];
  return [func evalWithArguments:functionArgs andBindings:bindings];
}


- (DslCons*) makeList:(DslCons*)bindings
{
  DslCons *cell = [DslCons withHead:[[self car] eval:bindings]];
  if ([self cdr]) {
    cell.tail = [(DslCons*)[self cdr] makeList:bindings];
  }
  return cell;
}


- (DslNumber*) fetchInteger:(DslCons*)bindings
{
  DslObject *obj = (DslObject*)[[self car] eval:bindings];
  DslSymbol *sel = (DslSymbol*)[[self cadr] eval:bindings];
  return [obj getInteger:[sel identifierValue]];
}


- (DslBoolean*) fetchBoolean:(DslCons*)bindings
{
  DslObject *obj = (DslObject*)[[self car] eval:bindings];
  DslSymbol *sel = (DslSymbol*)[[self cadr] eval:bindings];
  return [obj getBoolean:[sel identifierValue]];
}


- (DslString*) fetchString:(DslCons*)bindings
{
  DslObject *obj = (DslObject*)[head eval:bindings];
  DslSymbol *sel = (DslSymbol*)[[self cadr] eval:bindings];
  return [obj getString:[sel identifierValue]];
}


- (DslCons*) evalSelect:(DslCons*)bindings
{
  DslFunction *function = (DslFunction*)[[self cadr] eval:bindings];
  DslCons *data = (DslCons*)[[self caddr] eval:bindings];
  
  DslCons *mask = [data applyFunction:function withBindings:bindings];
  return [data filterWith:mask];

}

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
- (DslCons*) filterWith:(DslCons*)mask
{
  DslCons *rest = nil;
  if (!mask) {
    return rest;
  }
  if (tail) {
    rest = [(DslCons*)tail filterWith:(DslCons*)[mask cdr]];
  }
  if ([[mask car] booleanValue]) {
    return [DslCons withHead:head andTail:rest];
  } else {
    return rest;
  }
}


- (BOOL) findAny:(DslFunction*)predicate withBindings:(DslCons*)bindings
{  
  DslExpression *value = [predicate evalWithArguments:[DslCons withHead:[self car]] andBindings:bindings];
  if ([value booleanValue]) {
    return YES;
  } else if (tail == nil) {
    return NO;
  } else {
    return [(DslCons*)tail findAny:predicate withBindings:bindings];
  }
  
}


- (DslBoolean*) evalAny:(DslCons*)bindings
{
  DslFunction *predicate = (DslFunction*)[[self cadr] eval:bindings];
  DslCons *data = (DslCons*)[[self caddr] eval:bindings];
  
  return [DslBoolean booleanWith:[data findAny:predicate withBindings:bindings]];  
}


- (DslCons*) evalMap:(DslCons*)bindings
{
  DslFunction *function = (DslFunction*)[[self cadr] eval:bindings];
  DslCons *data = (DslCons*)[[self caddr] eval:bindings];
  
  return [data applyFunction:function withBindings:bindings];
}


- (DslCons*) applyFunction:(DslFunction*)func withBindings:(DslCons*)bindings
{
  DslExpression *value = [func evalWithArguments:[DslCons withHead:head] andBindings:bindings];
  DslCons *cell = [DslCons withHead:value];
  if (tail != nil) {
    cell.tail = [(DslCons*)tail applyFunction:func withBindings:bindings];
  }
  return cell;
}


- (DslCons*) quote:(DslExpression*)sexpr
{
  return [DslCons withHead:[DslSymbol withName:@"quote"] andTail:[DslCons withHead:sexpr]];
}


- (DslCons*) buildBindings:(DslCons*)initialBindings
{
  DslCons *newBinding = [DslCons withHead:[self caar] andTail:[[self cadar] eval:initialBindings]];
  [initialBindings append:[DslCons withHead:newBinding]];
  if (tail != nil) {
    [(DslCons*)tail buildBindings:initialBindings];
  }
  return initialBindings;
}



- (DslExpression*) evalLet:(DslCons*)bindings
{
  DslCons *bindingPairs = (DslCons*)[self cadr];
  DslCons *newBindings = (DslCons*)[bindingPairs buildBindings:[bindings copyList]];
  
  DslCons *body = (DslCons*)[self cddr];
  return [body evalEach:newBindings];
}


- (DslExpression*) evalFirstAppropriatePair:(DslCons*)bindings
{
  DslCons *pair = (DslCons*)[self car];
  if ([[[pair car] eval:bindings] booleanValue]) {
    return [[pair cdr] evalEach:bindings];
  } else if ([self cdr]) {
    return [(DslCons*)[self cdr] evalFirstAppropriatePair:bindings];
  } else {
    return nil;
  }
}



- (DslExpression*) evalCond:(DslCons*)bindings;
{
  if ([self cdr]) {
    return [(DslCons*)[self cdr] evalFirstAppropriatePair:bindings];
  } else {
    return nil;
  }
}


- (int) addPrim:(int)start withBindings:(DslCons*)bindings
{
  int val;
  if ([self car]) {
    val = start + [[[self car] eval:bindings] intValue];
  } else {
    val = start;
  }
  if ([self cdr]) {
    return [(DslCons*)[self cdr] addPrim:val withBindings:bindings];
  } else {
    return val;
  }
  
}


- (int) subtractPrimWithBindings:(DslCons*)bindings
{
  if ([self car]) {
    int val = [[[self car] eval:bindings] intValue];
    if ([self cdr]) {
      return [(DslCons*)[self cdr] subtractPrim2:val withBindings:bindings];
    } else {
      return val;
    }
  } else {
    return 0;
  }
}


- (int) subtractPrim2:(int)start withBindings:(DslCons*)bindings
{
  int val;
  if ([self car]) {
    val = start - [[[self car] eval:bindings] intValue];
  } else {
    val = start;
  }
  if ([self cdr]) {
    return [(DslCons*)[self cdr] subtractPrim2:val withBindings:bindings];
  } else {
    return val;
  }
  
}


- (DslCons*) append:(DslExpression*)cell
{
  if ([self cdr]) {
    [(DslCons*)[self cdr] append:cell];
  } else {
    self.tail = cell;
  }
  return self;
}


- (DslCons*) copyList
{
  if ([self cdr]) {
    return [[DslCons withHead:[self car] andTail:[(DslCons*)[self cdr] copyList]] retain];
  } else {
    return [[DslCons withHead:[self car]] retain];
  }
}


- (DslCons*) last
{
  if ([self cdr]) {
    return [(DslCons*)[self cdr] last];
  } else {
    return self;
  }
}
            

- (DslExpression*) find:(DslSymbol*)variableName
{
  if ([self car] && [[[self caar] identifierValue] isEqualToString:[variableName identifierValue]]) {
    return [self cdar];
  } else if ([self cdr]) {
    return [(DslCons*)[self cdr] find:variableName];
  } else {
    return nil;
  }
}


- (DslExpression*) car    { return head; }
- (DslExpression*) cadr   { return tail.head; }
- (DslExpression*) caddr  { return tail.tail.head; }
- (DslExpression*) cadar  { return head.tail.head; }
- (DslExpression*) cadddr { return tail.tail.tail.head; }
- (DslExpression*) caar   { return head.head; }
- (DslExpression*) caadr  { return tail.head.head; }
- (DslExpression*) cdr    { return tail; }
- (DslExpression*) cddr   { return tail.tail; }
- (DslExpression*) cdddr  { return tail.tail.tail; }
- (DslExpression*) cdadr  { return tail.head.tail; }
- (DslExpression*) cddddr { return tail.tail.tail.tail; }
- (DslExpression*) cdar   { return head.tail; }


- (BOOL) booleanValue
{
  return YES;
}


- (DslCons*) copy
{
  DslCons *newNode = [[DslCons withHead:head] retain];

  if (tail) {
    return [newNode append:[[tail copy] retain]];
  } else {
    return newNode;
  }
}


- (NSString*) toString
{
  return [NSString stringWithFormat:@"(%@)", [self toStringHelper]];
}

- (NSString*) toStringHelper
{
  if (tail) {
    return [NSString stringWithFormat:@"%@ %@", [head toString], [(DslCons*)tail toStringHelper]];;
  } else {
    return [head toString];
  }
}


- (DslExpression*) eval:(DslCons*)bindings
{
  
  [self logEval:self];
  
  NSString *procName = [head identifierValue];
  
  if (bindings == nil) {
    bindings = [[DslCons alloc] init];
  }
  if ([procName isEqualToString:@"let"]) {
    return [self logResult:[self evalLet:bindings] ];
  } else if ([procName isEqualToString:@"apply"]) {
    return [self logResult:[self apply:(DslCons*)tail withBindings:bindings]];
  } else if ([procName isEqualToString:@"cond"]) {
    return [self logResult:[self evalCond:bindings] ];
  } else if ([procName isEqualToString:@"map"]) {
    return [self logResult:[self evalMap:bindings] ];
  } else if ([procName isEqualToString:@"select"]) {
    return [self logResult:[self evalSelect:bindings]];
  } else if ([procName isEqualToString:@"any?"]) {
    return [self logResult:[self evalAny:bindings]];
  } else if ([procName isEqualToString:@"+"]) {
    if (tail) {
      return [self logResult:[DslNumber numberWith:[(DslCons*)[self cdr] addPrim:0 withBindings:bindings]] ];
    } else {
      return [self logResult:[DslNumber numberWith:0] ];
    }
  } else if ([procName isEqualToString:@"-"]) {
    if (tail) {
      return [self logResult:[DslNumber numberWith:[(DslCons*)[self cdr] subtractPrimWithBindings:bindings]] ];
    } else {
      return [self logResult:[DslNumber numberWith:0] ];
    }
  } else if ([procName isEqualToString:@"quote"]) {
    if (tail) {
      return [self logResult:[self cadr] ];
    } else {
      return [self logResult:nil ];
    }
  } else if ([procName isEqualToString:@"<"]) {
    int lval = [[[self cadr] eval:bindings] intValue];
    int rval = [[[self caddr] eval:bindings] intValue];
    return [self logResult:[DslBoolean booleanWith:(lval < rval)] ];
  } else if ([procName isEqualToString:@">"]) {
    int lval = [[[self cadr] eval:bindings] intValue];
    int rval = [[[self caddr] eval:bindings] intValue];
    return [self logResult:[DslBoolean booleanWith:(lval > rval)] ];
  } else if ([procName isEqualToString:@"="]) {
    int lval = [[[self cadr] eval:bindings] intValue];
    int rval = [[[self caddr] eval:bindings] intValue];
    return [self logResult:[DslBoolean booleanWith:(lval == rval)] ];
  } else if ([procName isEqualToString:@"str-eq"]){
    NSString *lval = [[[self cadr] eval:bindings] stringValue];
    NSString *rval = [[[self caddr] eval:bindings] stringValue];
    return [self logResult:[DslBoolean booleanWith:[lval isEqualToString:rval]] ];    
  } else if ([procName isEqualToString:@"or"]) {
    BOOL lval = [[[self cadr] eval:bindings] booleanValue];
    BOOL rval = [[[self caddr] eval:bindings] booleanValue];
    return [self logResult:[DslBoolean booleanWith:(lval || rval)] ];    
  } else if ([procName isEqualToString:@"lambda"]) {
    return [self logResult:[DslDefinedFunction withParameters:(DslCons*)[self cadr] andBody:(DslCons*)[self cddr]] ];
  } else if ([procName isEqualToString:@"get-string"]) {
    return [self logResult:[(DslCons*)[self cdr] fetchString:bindings] ];
  } else if ([procName isEqualToString:@"get-integer"]) {
    return [self logResult:[(DslCons*)[self cdr] fetchInteger:bindings] ];
  } else if ([procName isEqualToString:@"get-boolean"]) {
    return [self logResult:[(DslCons*)[self cdr] fetchBoolean:bindings] ];
  } else if ([procName isEqualToString:@"list"]) {
    return [self logResult:[(DslCons*)[self cdr] makeList:bindings] ];
  } else if ([procName isEqualToString:@"car"]) {
    return [(DslCons*)[[self cadr] eval:bindings] car];
  } else if ([procName isEqualToString:@"cadr"]) {
    return [(DslCons*)[[self cadr] eval:bindings] cadr];
  } else if ([procName isEqualToString:@"caddr"]) {
    return [(DslCons*)[[self cadr] eval:bindings] caddr];
  } else if ([procName isEqualToString:@"cadar"]) {
    return [(DslCons*)[[self cadr] eval:bindings] cadar]; 
  } else if ([procName isEqualToString:@"cadddr"]) {
    return [(DslCons*)[[self cadr] eval:bindings] cadddr];
  } else if ([procName isEqualToString:@"caar"]) {
    return [(DslCons*)[[self cadr] eval:bindings] caar];
  } else if ([procName isEqualToString:@"caadr"]) {
    return [(DslCons*)[[self cadr] eval:bindings] caadr];
  } else if ([procName isEqualToString:@"cdr"]) {
    return [(DslCons*)[[self cadr] eval:bindings] cdr];
  } else if ([procName isEqualToString:@"cddr"]) {
    return [(DslCons*)[[self cadr] eval:bindings] cddr];
  } else if ([procName isEqualToString:@"cdddr"]) {
    return [(DslCons*)[[self cadr] eval:bindings] cdddr];
  } else if ([procName isEqualToString:@"cdadr"]) {
    return [(DslCons*)[[self cadr] eval:bindings] cdadr];
  } else if ([procName isEqualToString:@"cddddr"]) {
    return [(DslCons*)[[self cadr] eval:bindings] cddddr];
  } else if ([procName isEqualToString:@"cdar"]) {
    return [(DslCons*)[[self cadr] eval:bindings] cdar];
    
  } else {
    Functions *f = [Functions alloc];
    DslExpression *result = [f eval:procName withArgs:(DslCons*)[self cdr] andBindings:bindings];
    [f release];
    return [self logResult:result ];
  }
  
}


- (BOOL) compareTo:(DslExpression*)other
{
  if (![super compareTo:other]) {
    return NO;
  }
  
  if ((head == nil && other.head != nil) || (head != nil && other.head == nil)) {
    return NO;
  }
  
  if (![head compareTo:other.head]) {
    return NO;
  }
  
  if (tail == nil && other.tail == nil) {
    return YES;
  }
  
  if ((tail == nil && other.tail != nil) || (tail != nil && other.tail == nil)) {
    return NO;
  }
  
  if (![tail compareTo:other.tail]) {
    return NO;
  }
  
  return YES;
}


@end
