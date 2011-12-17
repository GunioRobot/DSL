//
//  letTestCase.m
//  DSL
//
//  Created by David Astels on 4/15/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "LetTestCase.h"


@implementation LetTestCase


- (void) setUp
{
  p = [[DslParser alloc] init];
}


- (void) testNoBindingsAndSingleExprBody
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(let () (+ 1 2))"]] eval:nil];
  STAssertTrue([result isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 3, nil);
}


- (void) testNoBindingsAndMultipleExprBody
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(let () (+ 1 2) (+ 3 4) (-6 2))"]] eval:nil];
  STAssertTrue([result isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 4, nil);
}


- (void) testSingleBinding
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(let ((a 1)) (+ a 2))"]] eval:nil];
  STAssertTrue([result isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 3, nil);
}


- (void) testMultipleBindings
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(let ((a 1) (b 2)) (+ a b))"]] eval:nil];
  STAssertTrue([result isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 3, nil);
}


- (void) testCascadingBindings
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(let ((a 1) (b (+ a 1))) (+ a b))"]] eval:nil];
  STAssertTrue([result isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 3, nil);
}


- (void) testNestedLets
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(let ((a 1)) (let ((b (+ a 1))) (+ a b)))"]] eval:nil];
  STAssertTrue([result isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 3, nil);
}







@end
