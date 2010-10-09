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
  reporter = [[TestReporter alloc] init];
  return self;
}


- (BOOL) for:(NSString*)name checkThat:(NSString*)code evalsTo:(NSString*)result
{
  InputStream *codeStream = [InputStream withString:code];
  InputStream *expectedStream = [InputStream withString:result];
  DslExpression *actual = [[p parseExpression:codeStream] eval];
  DslExpression *expected = [[p parseExpression:expectedStream] eval];
  [codeStream release];
  [expectedStream release];

  BOOL areEqual = [actual compareTo:expected];
  if (areEqual) {
    [reporter pass:name];
  } else {
    [reporter fail:name for:code actual:[actual toString] expected:[expected toString]];
  }
  return areEqual;
}


- (void) runTest:(NSString*)test
{
  NSArray *parts = [test componentsSeparatedByString:@"\n\n"];
  int limit = [parts count];
  for (int i = 1; i < limit; i += 2) {
    [self for:[parts objectAtIndex:0] checkThat:[parts objectAtIndex:i]  evalsTo:[parts objectAtIndex:i+1]];
  }
}


- (void) process:(NSString*)testString
{
  NSArray *tests = [testString componentsSeparatedByString:@"----\n"];
  for (NSString *test in tests) {
    [self runTest:test];
  }
}


- (NSString*) testNameFromPath:(NSString*)path
{
  return [[[[path componentsSeparatedByString:@"/"] lastObject] componentsSeparatedByString:@"."] objectAtIndex:0];
}


- (void) runTestFile:(NSString*)path
{
  NSFileHandle *readHandle = [NSFileHandle fileHandleForReadingAtPath:path];
  if (readHandle) {
    NSString *testString = [[NSString alloc] initWithData: [readHandle readDataToEndOfFile] encoding:NSUTF8StringEncoding];
    [reporter startFile:[self testNameFromPath:path]];
    [self process:testString];
    [testString release];
    [readHandle closeFile];
  }
}

- (void) runTests
{

  NSArray *testFiles = [[NSBundle mainBundle] pathsForResourcesOfType:@"test" inDirectory:nil];
  [reporter startRun];
  for (NSString *test in testFiles) {
    [self runTestFile:test];
  }
  [reporter endRun];
}


@end
