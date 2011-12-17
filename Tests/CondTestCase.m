//
//  CondTestCase.m
//  DSL
//
//  Created by David Astels on 4/16/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "CondTestCase.h"


@implementation CondTestCase


- (void) setUp
{
  p = [[DslParser alloc] init];
}


- (void) testSingleCondition
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(cond (#t 4))"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 4, nil);
}


- (void) testMultipleConditionsWithFirstPassing
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(cond (#t 3) (#f 15)(#f 25))"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 3, nil);
}

- (void) testMultipleConditionsWithMiddlePassing
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(cond (#f 15) (#t 3) (#f 25))"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 3, nil);
}

- (void) testMultipleConditionsWithLastPassing
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(cond (#f 15) (#f 25) (#t 3))"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 3, nil);
}


- (void) testMultipleCodeBlock
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(cond (#t (+ 1 2) 3) #f 1)"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 3, nil);
}




@end
