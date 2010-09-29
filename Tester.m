//
//  Tester.m
//  DSL
//
//  Created by David Astels on 9/28/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSFileHandle.h>
#import "Tester.h"


@implementation Tester


- (Tester*) init
{
  p = [[DslParser alloc] init];
  return self;
}


- (BOOL) for:(NSString*)name checkThat:(NSString*)code evalsTo:(NSString*)result
{
  DslExpression *actual = [[p parseExpression:[InputStream withString:code]] eval:nil];
  DslExpression *expected = [[p parseExpression:[InputStream withString:result]] eval:nil];
  BOOL areEqual = [actual compareTo:expected];
  if (areEqual) {
    NSLog(@"PASS: '%@'", name);
  } else {
    NSLog(@"FAIL: '%@' Expected %@ but got %@", name, [expected toString], [actual toString]);
  }
  return areEqual;
}


- (void) runTest:(NSString*)test
{
  NSArray *parts = [test componentsSeparatedByString:@"\n\n"];
  [self for:[parts objectAtIndex:0] checkThat:[parts objectAtIndex:1] evalsTo:[parts objectAtIndex:2]];
}


- (void) process:(NSString*)testString
{
  NSArray *tests = [testString componentsSeparatedByString:@"----\n"];
  for (NSString *test in tests) {
    [self runTest:test];
  }
}


- (void) runTestFile:(NSString*)path
{
  NSFileHandle *readHandle = [NSFileHandle fileHandleForReadingAtPath:path];
  NSString *testString = [[NSString alloc] initWithData: [readHandle readDataToEndOfFile] encoding:NSUTF8StringEncoding];
  [self process:testString];
  [testString release];
  [readHandle closeFile];
}

- (void) runTests
{
  NSArray *testFiles = [[NSBundle mainBundle] pathsForResourcesOfType:@"test" inDirectory:nil];
  for (NSString *test in testFiles) {
    [self runTestFile:test];
  }
}


@end
