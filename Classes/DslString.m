//
//  DslString.m
//  DSL
//
//  Created by David Astels on 4/11/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "DslString.h"


@implementation DslString

+(DslString*)stringWith:(NSString*)str;
{
  return [[DslString alloc] initWithString:str];
}


-(DslString*)initWithString:(NSString*)str
{
  value = str;
  return self;
}


- (NSString*)stringValue
{
  return value;
}


- (BOOL) booleanValue
{
  return [value length] > 0;
}


- (NSString*) toString
{
  return value;
}


- (BOOL) compareTo:(DslExpression*)other
{
  return [super compareTo:other] && [value isEqualToString:[other stringValue]];
}


@end
