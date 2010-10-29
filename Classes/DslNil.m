//
//  DslNil.m
//  DSL
//
//  Created by David Astels on 9/29/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "DslNil.h"
#import "DslNumber.h"

@implementation DslNil


- (DslNil*) initWithHead:(DslExpression*)h andTail:(DslExpression*)t
{
  head = self;
  tail = self;
  return self;
}


- (BOOL) booleanValue
{
  return NO;
}


- (NSString*) toString
{
  return @"nil";
}


- (DslExpression*) length
{
  return [DslNumber numberWith:0];
}


- (BOOL) isNil
{
  return YES;
}


- (BOOL) notNil
{
  return NO;
}



- (DslExpression*) eval
{
  [self logEval:self];
  return [self logResult:self];
}


- (BOOL) compareTo:(DslExpression*)other
{
  return [other isNil];
}

@end
