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


- (DslNumber*) getInteger:(NSString*)property
{
  int intVal = (int)[obj performSelector:sel_getUid([property UTF8String])];
  return [DslNumber numberWith:intVal];
}


- (DslString*) getString:(NSString*)property
{
  NSString *strVal = (NSString*)[obj performSelector:sel_getUid([property UTF8String])];
  return [DslString stringWith:strVal];
}


- (DslBoolean*) getBoolean:(NSString*)property
{
  BOOL boolVal = (BOOL)[obj performSelector:sel_getUid([property UTF8String])];
  return [DslBoolean booleanWith:boolVal];
}


- (DslNumber*) setInteger:(NSString*)property to:(DslNumber*)value
{
  NSString *selector = [NSString stringWithFormat:@"%@:", property];
  int intVal = (int)[obj performSelector:sel_getUid([selector UTF8String]) withObject:[value intValue]];
  return value;
}


- (DslString*) setString:(NSString*)property to:(DslString*)value
{
  NSString *selector = [NSString stringWithFormat:@"%@:", property];
  NSString *strVal = (NSString*)[obj performSelector:sel_getUid([selector UTF8String]) withObject:[value stringValue]];
  return value;
}


- (DslBoolean*) setBoolean:(NSString*)property to:(DslBoolean*)value
{
  NSString *selector = [NSString stringWithFormat:@"%@:", property];
  BOOL boolVal = (BOOL)[obj performSelector:sel_getUid([selector UTF8String]) withObject:[value booleanValue]];
  return value;
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
