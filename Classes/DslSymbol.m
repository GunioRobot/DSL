//
//  DslIdentifier.m
//  DSL
//
//  Created by David Astels on 4/12/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "DslSymbol.h"
#import "Dsl.h"


@implementation DslSymbol


+(DslSymbol*)withName:(NSString*)n
{
  return [[DslSymbol alloc] initWithName:n];
}


-(DslSymbol*)initWithName:(NSString*)n
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


- (DslExpression*) eval
{
  [self logEval:self];
  return [self logResult:[DSL valueOf:self]];
}


- (NSString*) toString
{
  return name;
}


- (BOOL) compareTo:(DslExpression*)other
{
  return [super compareTo:other] && [name isEqualToString:[other identifierValue]];
}


- (BOOL) isNamed:(NSString*)aName
{
  return [name isEqualToString:aName];
}


- (id)copyWithZone:(NSZone *)zone
{
  return [[DslSymbol allocWithZone: zone] initWithName:name];
}


@end
