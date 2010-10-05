//
//  TestReporter.m
//  DSL
//
//  Created by David Astels on 9/29/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "TestReporter.h"
#import "FailureReport.h"


@implementation TestReporter

- (TestReporter*) init
{
  failures = [NSMutableArray array];
  numberOfPasses = 0;
  numberOfTests = 0;
  return self;
}


- (void) pass:(NSString*)test
{
  NSLog(@"PASS: %@", test);
  numberOfPasses++;
  numberOfTests++;
}


- (void) fail:(NSString*)test for:(NSString*)code actual:(NSString*)actual expected:(NSString*)expected
{
  NSLog(@"FAIL: %@", test);
  [failures addObject:[FailureReport for:test code:code actual:actual expected:expected]];
  numberOfTests++;
}


- (void) startFile:(NSString*)name
{
  NSLog(@"Running: %@", name);
}


- (void) startRun
{
  NSLog(@"Starting test run");
  startTime = [NSDate date];
}


- (void) endRun
{
  NSTimeInterval duration = -[startTime timeIntervalSinceNow];
  
  NSLog(@"------------");
  NSLog(@"Failures");
  for (FailureReport *fail in failures) {
    [fail report];
  }
  
  NSLog(@"------------");
  NSLog(@"Time: %f sec, %d Tests, %d Passes, %d Failures\n", duration, numberOfTests, numberOfPasses, [failures count]);
}


@end
