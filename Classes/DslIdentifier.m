//
//  DslIdentifier.m
//  DSL
//
//  Created by David Astels on 4/12/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "DslIdentifier.h"
#import "DslCons.h"


@implementation DslIdentifier

+(DslIdentifier*)identifierWithName:(NSString*)n
{
  return [[DslIdentifier alloc] initWithName:n];
}


-(DslIdentifier*)initWithName:(NSString*)n
{
  name = n;
  return self;
}


- (NSString*)identifierValue
{
  return name;
}


- (NSString*)stringValue
{
  return name;
}


- (DslExpression*) eval:(DslCons*)bindings
{
  [self logEval:self];
  return [self logResult:[bindings find:self]];
}


- (NSString*) toString
{
  return name;
}


- (BOOL) compareTo:(DslExpression*)other
{
  return [super compareTo:other] && [name isEqualToString:[other identifierValue]];
}


@end
