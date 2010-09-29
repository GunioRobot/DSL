//
//  FailureReport.m
//  DSL
//
//  Created by David Astels on 9/29/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "FailureReport.h"


@implementation FailureReport

+ (FailureReport*) for:(NSString *)test code:(NSString *)code actual:(NSString *)actual expected:(NSString *)expected
{
  return [[FailureReport alloc] initFor:test code:code actual:actual expected:expected];
}


- (FailureReport*) initFor:(NSString *)pTest code:(NSString *)pCode actual:(NSString *)pActual expected:(NSString *)pExpected;
{
  test = pTest;
  code = pCode;
  actual = pActual;
  expected = pExpected;
  return self;
}


- (void) report
{
  NSLog(@"----");
  NSLog(@"FAIL: %@", test);
  NSLog(@"%@", code);
  NSLog(@"Expected %@ but got %@\n", expected, actual);
}


@end
