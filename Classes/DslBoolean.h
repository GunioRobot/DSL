//
//  DslBoolean.h
//  DSL
//
//  Created by David Astels on 4/12/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "DslExpression.h"


@interface DslBoolean : DslExpression {
  BOOL value;
}

+ (DslBoolean*) withTrue;
+ (DslBoolean*) withFalse;
+ (DslBoolean*) booleanWith:(BOOL)b;
- (DslBoolean*) initWithBoolean:(BOOL)b;

@end
