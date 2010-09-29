//
//  OperatorFunctionTest.h
//  DSL
//
//  Created by David Astels on 9/18/10.
//  Copyright (c) 2010 Dave Astels. All rights reserved.
//
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

//  Application unit tests contain unit test code that must be injected into an application to run correctly.
//  Define USE_APPLICATION_UNIT_TEST to 0 if the unit test code is designed to be linked into an independent test executable.

#define USE_APPLICATION_UNIT_TEST 1

#import <SenTestingKit/SenTestingKit.h>
#import "dsl.h"

@interface OperatorFunctionTest : SenTestCase {
  DslParser *p;
}

- (void) testEqTrue;
- (void) testEqFalse;
- (void) testLessThanTrue;
- (void) testLessThanFalse;
- (void) testGreaterThanTrue;
- (void) testGreaterThanFalse;

@end
