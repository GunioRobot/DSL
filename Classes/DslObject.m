//
//  DslObject.m
//  Primed
//
//  Created by David Astels on 4/20/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "DslObject.h"


@implementation DslObject

+ (DslObject*) withObject:(id)anObject
{
  return [[DslObject alloc] initWithObject:anObject];
}


- (DslObject*) initWithObject:(id)anObject
{
  obj = anObject;
  return self;
}


- (id) objectValue
{
  return obj;
}


- (DslNumber*) getInteger:(NSString*)selector
{
  int intVal = (int)[obj performSelector:sel_getUid([selector UTF8String])];
  return [DslNumber numberWith:intVal];
}


- (DslString*) getString:(NSString*)selector
{
  NSString *strVal = (NSString*)[obj performSelector:sel_getUid([selector UTF8String])];
  return [DslString stringWith:strVal];
}


- (DslBoolean*) getBoolean:(NSString*)selector
{
  BOOL boolVal = (BOOL)[obj performSelector:sel_getUid([selector UTF8String])];
  return [DslBoolean booleanWith:boolVal];
}


- (NSString*) toString
{
  return [NSString stringWithFormat:@"%@", obj];
}


- (BOOL) compareTo:(DslExpression*)other
{
  return [super compareTo:other] && (obj == [other objectValue]);
}



@end
