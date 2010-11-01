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
#import "DslNil.h"


@implementation DslCons


+ (DslCons*) empty
{
  return [[DslCons alloc] initWithHead:NIL_CONS andTail:NIL_CONS];
}


+ (DslCons*) withHead:(DslExpression*)h
{
  return [[DslCons alloc] initWithHead:h andTail:NIL_CONS];
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
  return [DslCons empty];
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


- (DslCons*) makeList:(DslCons*)bindings
{
  DslCons *cell = [DslCons withHead:[[self car] eval:bindings]];
  if ([self cdr]) {
    cell.tail = [(DslCons*)[self cdr] makeList:bindings];
  }
  return cell;
}







- (BOOL) booleanValue
{
  return YES;
}


- (DslCons*) copy
{
  DslCons *newNode = [DslCons withHead:head];

  if (tail) {
    return [newNode append:[tail copy]];
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
  if (tail && [tail notNil]) {
    return [NSString stringWithFormat:@"%@ %@", [head toString], [(DslCons*)tail toStringHelper]];;
  } else if (head && [head notNil]) {
    return [head toString];
  } else {
    return @"";
  }

}


- (DslCons*) evalEach:(DslCons*)args
{
  DslCons *result = [DslCons empty];
  DslCons *lastResult = result;
  while ([args notNil]) {
    lastResult.tail = [DslCons withHead:[args.head eval]];
    lastResult = (DslCons*)lastResult.tail;
    args = (DslCons*)args.tail;
  }
  return result.tail;
}


- (DslExpression*) eval
{
  NSString *funcName = [head stringValue];
  DslSymbol *funcSymbol = [DSL internal_intern:funcName];
  DslFunction *func = (DslFunction*)[DSL valueOf:funcSymbol];
  if ([func isNil]) {
    NSLog(@"Unknown function: %@", funcName);
    return NIL_CONS;
  }
  DslCons *args;
  if ([func preEvalArgs])
    args = [self evalEach:tail];
  else 
    args = tail;
  
  return [func evalWithArguments:(args)];
}


- (BOOL) compareTo:(DslExpression*)other
{
  if (![super compareTo:other]) return NO;
  
  if (([head isNil] && [other.head notNil]) || ([head notNil] && [other.head isNil])) return NO;
  
  if (![head compareTo:other.head]) return NO;
  
  if ([tail isNil] && [other.tail isNil]) return YES;
  
  if (([tail isNil] && [other.tail notNil]) || ([tail notNil] && [other.tail isNil])) return NO;
  
  if (![tail compareTo:other.tail]) return NO;
  
  return YES;
}


- (BOOL) isNil
{
  return ((head == nil) || [head isNil]) && ((tail == nil) || [tail isNil]);
}


- (BOOL) notNil
{
  return ![self isNil];
}


- (BOOL) isList
{
  return YES;
}


@end
