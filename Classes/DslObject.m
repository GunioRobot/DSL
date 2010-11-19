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
  int intVal = (int)[obj valueForKey:property];
  return [DslNumber numberWith:intVal];
}


- (DslString*) getString:(NSString*)property
{
  NSString *strVal = (NSString*)[obj valueForKey:property];
  return [DslString stringWith:strVal];
}


- (DslBoolean*) getBoolean:(NSString*)property
{
  BOOL boolVal = (BOOL)[obj valueForKey:property];
  return [DslBoolean booleanWith:boolVal];
}


- (DslNumber*) setInteger:(NSString*)property to:(DslNumber*)value
{
  [obj setValue:[value intValue] forKey:property];
  return value;
}


- (DslString*) setString:(NSString*)property to:(DslString*)value
{
  [obj setValue:[value stringValue] forKey:property];
  return value;
}


- (DslBoolean*) setBoolean:(NSString*)property to:(DslBoolean*)value
{
  [obj setValue:[value booleanValue] forKey:property];
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
