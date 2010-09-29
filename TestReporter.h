//
//  TestReporter.h
//  DSL
//
//  Created by David Astels on 9/29/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TestReporter : NSObject {
  NSMutableArray *failures;
  int numberOfPasses;
  NSDate *startTime;
}

- (TestReporter*) init;
- (void) pass:(NSString*)test;
- (void) fail:(NSString*)test for:(NSString*)code actual:(NSString*)actual expected:(NSString*)expected;
- (void) startFile:(NSString*)name;
- (void) startRun;
- (void) endRun;

@end
