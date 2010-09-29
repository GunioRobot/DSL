//
//  Tester.h
//  DSL
//
//  Created by David Astels on 9/28/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "dsl.h"

@interface Tester : NSObject {
  DslParser *p;
}


- (Tester*) init;
- (BOOL) for:(NSString*)name checkThat:(NSString*)code evalsTo:(NSString*)result;
- (void) runTestFile:(NSString*)testName;

@end
