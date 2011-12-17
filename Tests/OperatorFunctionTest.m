//
//  OperatorFunctionTest.m
//  DSL
//
//  Created by David Astels on 9/18/10.
//  Copyright (c) 2010 Dave Astels. All rights reserved.
//

#import "OperatorFunctionTest.h"


@implementation OperatorFunctionTest

- (void) setUp
{
  p = [[DslParser alloc] init];
}


- (void) testEqTrue
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(= 1 1)"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isMemberOfClass:[DslBoolean class]], nil);
  STAssertTrue([result booleanValue], nil);
}


- (void) testEqFalse
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(= 1 2)"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isMemberOfClass:[DslBoolean class]], nil);
  STAssertFalse([result booleanValue], nil);
}


- (void) testLessThanTrue
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(< 1 2)"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isMemberOfClass:[DslBoolean class]], nil);
  STAssertTrue([result booleanValue], nil);
}


- (void) testLessThanFalse
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(< 2 1)"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isMemberOfClass:[DslBoolean class]], nil);
  STAssertFalse([result booleanValue], nil);
}


- (void) testGreaterThanTrue
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(> 2 1)"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isMemberOfClass:[DslBoolean class]], nil);
  STAssertTrue([result booleanValue], nil);
}


- (void) testGreaterThanFalse
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(> 1 2)"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isMemberOfClass:[DslBoolean class]], nil);
  STAssertFalse([result booleanValue], nil);
}

@end
