//
//  DslFunction.h
//  DSL
//
//  Created by David Astels on 6/7/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DslExpression.h"
#import "DslCons.h"


@interface DslFunction : DslExpression {
}

- (DslExpression*) evalWithArguments:(DslCons*)args;
- (BOOL) preEvalArgs;

@end
