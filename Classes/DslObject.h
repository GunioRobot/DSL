//
//  DslObject.h
//  Primed
//
//  Created by David Astels on 4/20/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DslExpression.h"
#import "DslNumber.h"
#import "DslString.h"
#import "DslBoolean.h"

@interface DslObject : DslExpression {
  id obj;
}

+ (DslObject*) withObject:(id)anObject;
- (DslObject*) initWithObject:(id)anObject;

- (id) objectValue;

- (DslNumber*) getInteger:(NSString*)property;
- (DslString*) getString:(NSString*)property;
- (DslBoolean*) getBoolean:(NSString*)property;
- (DslNumber*) setInteger:(NSString*)property to:(DslNumber*)value;
- (DslString*) setString:(NSString*)property to:(DslString*)value;
- (DslBoolean*) setBoolean:(NSString*)property to:(DslBoolean*)value;

@end
