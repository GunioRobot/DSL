//
//  SexprParsingTestCase.h
//  DSL
//
//  Created by David Astels on 4/12/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

//  Application unit tests contain unit test code that must be injected into an application to run correctly.
//  Define USE_APPLICATION_UNIT_TEST to 0 if the unit test code is designed to be linked into an independent test executable.


#import <SenTestingKit/SenTestingKit.h>
#import "dsl.h"

@interface ConsParsingTestCase : SenTestCase {
  DslParser *p;
}

- (void) testGetsACons;
- (void) testGetsAnEmptyListCons;
- (void) testGetsAListOfOneNumber;
- (void) testGetsAListOfOneString;
- (void) testGetsAListOfOneIdentifier;
- (void) testGetsAListOfTwo;
- (void) testGetsALongList;
- (void) testANestedList;
- (void) testADeeplyNestedList;

@end
