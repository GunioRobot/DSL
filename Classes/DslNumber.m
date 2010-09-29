//
//  DslNumber.m
//  DSL
//
//  Created by David Astels on 4/11/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "DslNumber.h"


@implementation DslNumber


+(DslNumber*)numberWith:(int)num;
{
  return [[DslNumber alloc] initWithNumber:num];
}


-(DslNumber*)initWithNumber:(int)num
{
  value = num;
  return self;
}


- (int)intValue
{
  return value;
}


- (BOOL) booleanValue
{
  return value != 0;
}


- (NSString*) toString
{
  return [NSString stringWithFormat:@"%d", value];
}


- (BOOL) compareTo:(DslExpression*)other
{
  return [super compareTo:other] && (value == [other intValue]);
}


@end
