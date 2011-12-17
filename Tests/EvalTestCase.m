//
//  EvalTestCase.m
//  DSL
//
//  Created by David Astels on 4/15/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "EvalTestCase.h"


@implementation EvalTestCase


- (void) setUp
{
  p = [[DslParser alloc] init];
}


- (void) testSimpleAddEvaluation
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(+ 1 2)"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 3, nil);
}


- (void) testInvolvedAddEvaluation
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(+ 1 2 3 4 5)"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 15, nil);
}


- (void) testSimpleSubtractEvaluation
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(- 5 3)"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 2, nil);
}


- (void) testInvolvedSubtractEvaluation
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(- 15 5 4 3 2 1)"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 0, nil);
}


- (void) testQuote
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(quote (a b))"]] eval:nil];
  STAssertTrue([result isMemberOfClass:[DslCons class]], nil);
  STAssertEqualObjects([result.head identifierValue], @"a", nil);
  STAssertEqualObjects([result.tail.head identifierValue], @"b", nil);
  STAssertNil(result.tail.tail, nil);
}

- (void) testShortQuote
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"'(a b)"]] eval:nil];
  STAssertTrue([result isMemberOfClass:[DslCons class]], nil);
  STAssertEqualObjects([result.head identifierValue], @"a", nil);
  STAssertEqualObjects([result.tail.head identifierValue], @"b", nil);
  STAssertNil(result.tail.tail, nil);
}


- (void) testSequenceEvaluation
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(1 2 3)"]] evalEach:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 3, nil);
}


@end
