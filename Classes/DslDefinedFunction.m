//
//  DslDefinedFunction.m
//  DSL
//
//  Created by David Astels on 9/29/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//
// Applying one of these evals all of it's args

#import "DslDefinedFunction.h"


@implementation DslDefinedFunction

+ (DslDefinedFunction*) withParameters:(DslCons*)p andBody:(DslCons*)b
{
  return [[DslDefinedFunction alloc] initWithParameters:(DslCons*)p andBody:(DslCons*)b];
}


- (DslDefinedFunction*) init
{
  return [self initWithParameters:[[DslCons alloc] init] andBody:[[DslCons alloc] init]];
}


- (DslDefinedFunction*) initWithParameters:(DslCons*)p andBody:(DslCons*)b
{
  parameters = [p retain];
  body = [b retain];
  return self;
}


- (DslExpression*) evalWithArguments:(DslCons*)args
{
  [DSL pushLocalBindings];
  
  DslCons *p = parameters;
  DslCons *a = args;
  while ([p car] && [a car]) {
    [DSL bind:(DslSymbol*)p.head to:[DSL eval:a.head]];
    p = (DslCons*)p.tail;
    a = (DslCons*)a.tail;
  }
  
  if (body == nil || [body length] == 0) {
    [DSL popLocalBindings];
    return NIL_CONS;
  } else {
    DslExpression *result = NIL_CONS;
    DslCons *code = body;
    while (![code isNil]) {
      result = [DSL eval:code.head];
      code = (DslCons*)code.tail;
    }
    [DSL popLocalBindings];
    return result;
  }
}


- (NSString*) toString
{
  return [NSString stringWithFormat:@"Anon function with args: %@ and body: %@", [parameters toString], [body toString]];
}

@end
