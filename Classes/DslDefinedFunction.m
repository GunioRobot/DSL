//
//  DslDefinedFunction.m
//  DSL
//
//  Created by David Astels on 9/29/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "DslDefinedFunction.h"


@implementation DslDefinedFunction

+ (DslFunction*) withParameters:(DslCons*)p andBody:(DslCons*)b
{
  return [[DslFunction alloc] initWithParameters:(DslCons*)p andBody:(DslCons*)b];
}


- (DslFunction*) init
{
  return [self initWithParameters:[[DslCons alloc] init] andBody:[[DslCons alloc] init]];
}


- (DslFunction*) initWithParameters:(DslCons*)p andBody:(DslCons*)b
{
  parameters = [p retain];
  body = [b retain];
  return self;
}


- (DslExpression*) evalWithArguments:(DslCons*)args andBindings:(DslCons*)bindings
{
  //  NSLog(@"Entering anon function with args: %@ and bindings: %@", [args toString], [bindings toString]);
  // bind arguments
  DslCons *p = parameters;
  DslCons *a = args;
  DslCons *localBindings = [bindings copy];
  while ([p car] && [a car]) {
    DslCons *newBinding = [DslCons withHead:[p car] andTail:[a car]];
    [localBindings append:[DslCons withHead:newBinding]];
    p = (DslCons*)[p cdr];
    a = (DslCons*)[a cdr];
  }
  
  if (body == nil || [body length] == 0) {
    return nil;
  } else {
    //    NSLog(@"Executing anon function with args: %@ and bindings: %@", [args toString], [localBindings toString]);
    return [body evalEach:localBindings];
  }
}


- (NSString*) toString
{
  return [NSString stringWithFormat:@"Anon function with args: %@ and body: %@", [parameters toString], [body toString]];
}

@end
