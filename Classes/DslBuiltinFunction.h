//
//  DslBuiltinFunction.h
//  DSL
//
//  Created by David Astels on 9/29/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dsl.h"

@interface DslBuiltinFunction : DslFunction {
  SEL selector;
}

+ (DslBuiltinFunction*)withSelector:(SEL)pSel;
- (DslBuiltinFunction*)initWithSelector:(SEL)pSel;

@end
