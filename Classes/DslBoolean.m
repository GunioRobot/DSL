//
//  DslBoolean.m
//  DSL
//
//  Created by David Astels on 4/12/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "DslBoolean.h"


@implementation DslBoolean

+ (DslBoolean*) withTrue
{
  return [DslBoolean booleanWith:YES];
}

+ (DslBoolean*) withFalse
{
  return [DslBoolean booleanWith:NO];
}


+(DslBoolean*) booleanWith:(BOOL)b;
{
  return [[DslBoolean alloc] initWithBoolean:b];
}


-(DslBoolean*) initWithBoolean:(BOOL)b
{
  value = b;
  return self;
}


- (BOOL)booleanValue
{
  return value;
}


- (NSString*) toString
{
  return (value) ? @"true" : @"false";
}


- (BOOL) compareTo:(DslExpression*)other
{
  return [super compareTo:other] && (value == [other booleanValue]);
}

@end
