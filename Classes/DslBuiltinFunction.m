//
//  DslBuiltinFunction.m
//  DSL
//
//  Created by David Astels on 9/29/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "DslBuiltinFunction.h"


@implementation DslBuiltinFunction

+ (DslBuiltinFunction*)withTarget:(id)pTarget andSelector:(SEL)pSelector
{
  return [[DslBuiltinFunction alloc] initWithTarget:pTarget andSelector:pSelector];
}


- (DslBuiltinFunction*)initWithTarget:(id)pTarget andSelector:(SEL)pSelector
{
  target = pTarget;
  selector = pSelector;
  return self;
}


- (DslExpression*) evalWithArguments:(DslCons*)args
{
  return [target performSelector:selector withObject:args];
}

@end
