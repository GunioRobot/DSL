//
//  Tester.h
//  DSL
//
//  Created by David Astels on 9/28/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "dsl.h"
#import "TestReporter.h"

@interface Tester : NSObject {
  DslParser *p;
  TestReporter *reporter;
}


- (Tester*) init;
- (void) runTests;
@end
