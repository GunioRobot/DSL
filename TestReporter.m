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
  return self;
}


- (void) pass:(NSString*)test
{
  NSLog(@"PASS: %@", test);
  numberOfPasses++;
}


- (void) fail:(NSString*)test for:(NSString*)code actual:(NSString*)actual expected:(NSString*)expected
{
  NSLog(@"FAIL: %@", test);
  [failures addObject:[FailureReport for:test code:code actual:actual expected:expected]];
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
  
  NSLog(@"----");
  NSLog(@"Time: %f sec, %d Passes, %d Failures\n", duration, numberOfPasses, [failures count]);
  
  for (FailureReport *fail in failures) {
    [fail report];
  }
}


@end
