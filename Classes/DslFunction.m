//
//  DslFunction.m
//  DSL
//
//  Created by David Astels on 6/7/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "DslFunction.h"
#import "Dsl.h"

@implementation DslFunction

- (DslExpression*) evalWithArguments:(DslCons*)args { return NIL_CONS; }
- (BOOL) preEvalArgs { return NO; }

@end
