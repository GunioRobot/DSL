//
//  DslNil.h
//  DSL
//
//  Created by David Astels on 9/29/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "DslExpression.h"


@class DslNil;
static DslNil *instance;

@interface DslNil : DslExpression {

}

+ (DslNil*) NIL;

@end
