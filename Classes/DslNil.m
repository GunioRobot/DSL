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


- (BOOL) booleanValue
{
  return NO;
}


- (DslExpression*) length
{
  return [DslNumber numberWith:0];
}


- (BOOL) isNil
{
  return YES;
}


@end
