//
//  Functions.h
//  DSL
//
//  Created by David Astels on 4/20/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "dsl.h"


@interface Functions : NSObject {

}

- (DslExpression*) eval:(NSString*)name withArgs:(DslCons*)args andBindings:(DslCons*)bindings;

@end
