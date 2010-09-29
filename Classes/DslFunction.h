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
  DslCons *parameters;
  DslCons *body;
}

+ (DslFunction*) withParameters:(DslCons*)p andBody:(DslCons*)b;
- (DslFunction*) init;
- (DslFunction*) initWithParameters:(DslCons*)p andBody:(DslCons*)b;
- (DslExpression*) evalWithArguments:(DslCons*)args andBindings:(DslCons*)bindings;

@end
