//
//  LambdaTestCase.m
//  DSL
//
//  Created by David Astels on 6/7/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "LambdaTestCase.h"


@implementation LambdaTestCase

- (void) setUp
{
  p = [[DslParser alloc] init];  
}


- (void) testParsingEmptyLambda
{
  DslExpression *func = [[p parseExpression:[InputStream withString:@"(lambda ())"]] eval:nil];
  STAssertTrue([func isKindOfClass:[DslFunction class]], nil);
}


- (void) testEvalingEmptyLambda
{
  DslFunction *func = (DslFunction*)[[p parseExpression:[InputStream withString:@"(lambda ())"]] eval:nil];
  STAssertNil([func evalWithArguments:[[DslCons alloc] init] andBindings:[[DslCons alloc] init]], nil);
}


- (void) testEvalingSimpleLambda
{
  DslFunction *func = (DslFunction*)[[p parseExpression:[InputStream withString:@"(lambda () 42)"]] eval:nil];
  DslExpression *result = [func evalWithArguments:[[DslCons alloc] init] andBindings:[[DslCons alloc] init]];
  STAssertNotNil(result, nil);
  STAssertTrue([result isKindOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 42, nil);
}



- (void) testEvalingMoreInvolvedLambda
{
  DslFunction *func = (DslFunction*)[[p parseExpression:[InputStream withString:@"(lambda () (+ 40 2))"]] eval:nil];
  DslExpression *result = [func evalWithArguments:[[DslCons alloc] init] andBindings:[[DslCons alloc] init]];
  STAssertNotNil(result, nil);
  STAssertTrue([result isKindOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 42, nil);
}


- (void) testEvalingLambdaWith1Argument
{
  DslFunction *func = (DslFunction*)[[p parseExpression:[InputStream withString:@"(lambda (x) (+ x 2))"]] eval:nil];
  DslExpression *result = [func evalWithArguments:[[DslCons alloc] init] andBindings:(DslCons*)[p parseExpression:[InputStream withString:@"((x . 40))"]]];
  STAssertNotNil(result, nil);
  STAssertTrue([result isKindOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 42, nil);
}


- (void) testEvalingLambdaWithArguments
{
  DslFunction *func = (DslFunction*)[[p parseExpression:[InputStream withString:@"(lambda (x y) (+ x y))"]] eval:nil];
  DslExpression *result = [func evalWithArguments:[[DslCons alloc] init] andBindings:(DslCons*)[p parseExpression:[InputStream withString:@"((x . 40) (y . 2))"]]];
  STAssertNotNil(result, nil);
  STAssertTrue([result isKindOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 42, nil);
}


- (void) testApplyingSingleArgumentLambda
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(apply (lambda (x) (+ x 2)) 40)"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isKindOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 42, nil);
}  


- (void) testApplyingMultipleArgumentLambda
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(apply (lambda (x y) (+ x y)) 40 2)"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isKindOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 42, nil);
}  


@end
