//
//  ListFunctionsTestCase.m
//  DSL
//
//  Created by David Astels on 4/15/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "ListFunctionsTestCase.h"


@implementation ListFunctionsTestCase


- (void) setUp
{
  p = [[DslParser alloc] init];  
}


- (void) testLengthOfSimpleLists
{
  STAssertEquals([[[p parseExpression:[InputStream withString:@"(length '())"]] eval:nil] intValue], 0, nil);
  STAssertEquals([[[p parseExpression:[InputStream withString:@"(length '(a))"]] eval:nil] intValue], 1, nil);
  STAssertEquals([[[p parseExpression:[InputStream withString:@"(length '(a b))"]] eval:nil] intValue], 2, nil);
  STAssertEquals([[[p parseExpression:[InputStream withString:@"(length '(a b c))"]] eval:nil] intValue], 3, nil);
  STAssertEquals([[[p parseExpression:[InputStream withString:@"(length '(a b c d))"]] eval:nil] intValue], 4, nil);
  STAssertEquals([[[p parseExpression:[InputStream withString:@"(length '(a a a a a a a a a a a a a a a a))"]] eval:nil] intValue], 16, nil);
}
- (void) testLengthOfNestedLists
{
  STAssertEquals([[[p parseExpression:[InputStream withString:@"(length '((a) b))"]] eval:nil] intValue], 2, nil);
  STAssertEquals([[[p parseExpression:[InputStream withString:@"(length '(a (b) c))"]] eval:nil] intValue], 3, nil);
  STAssertEquals([[[p parseExpression:[InputStream withString:@"(length '(a (b c) d))"]] eval:nil] intValue], 3, nil);
  STAssertEquals([[[p parseExpression:[InputStream withString:@"(length '(a (a a) a (a) a (a ((a) a) a a) a (a a) a a))"]] eval:nil] intValue], 10, nil);
}


- (void) testCarCdr
{
  STAssertEquals([[[p parseExpression:[InputStream withString:@"(1 2 3 4 5)"]] car] intValue], 1, nil);
  STAssertEquals([[[p parseExpression:[InputStream withString:@"(1 2 3 4 5)"]] cadr] intValue], 2, nil);
  STAssertEquals([[[p parseExpression:[InputStream withString:@"(1 2 3 4 5)"]] caddr] intValue], 3, nil);
  STAssertEquals([[[p parseExpression:[InputStream withString:@"(1 2 3 4 5)"]] cadddr] intValue], 4, nil);
}


- (void) testDegenerateMap
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(map (lambda (l) 42) '((1) (2 2) (3 3 3)) )"]] eval:nil];
  STAssertTrue([result isMemberOfClass:[DslCons class]], nil);
  STAssertTrue([[result car] isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([[result car] intValue], 42, nil);
  STAssertTrue([[result cadr] isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([[result cadr] intValue], 42, nil);
  STAssertTrue([[result caddr] isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([[result caddr] intValue], 42, nil);
  STAssertNil([result cdddr], nil);
}


- (void) testMapOverSingletonList
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(map (lambda (l) (length l)) '((1)) )"]] eval:nil];
  STAssertTrue([[result car] isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([[result car] intValue], 1, nil);
  STAssertNil([result cdr], nil);
}



- (void) testAnIdentityMap
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(map (lambda (l) l) '(1) )"]] eval:nil];
  STAssertTrue([[result car] isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([[result car] intValue], 1, nil);
  STAssertNil([result cdr], nil);
}



- (void) testMap
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(map (lambda (l) (length l)) '((1) (2 2) (3 3 3)) )"]] eval:nil];
  STAssertTrue([[result car] isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([[result car] intValue], 1, nil);
  STAssertTrue([[result cadr] isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([[result cadr] intValue], 2, nil);
  STAssertTrue([[result caddr] isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([[result caddr] intValue], 3, nil);
  STAssertNil([result cdddr], nil);
}


- (void) testMap2
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(map (lambda (l) (+ 1 l)) '(0 1 2) )"]] eval:nil];
  STAssertTrue([[result car] isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([[result car] intValue], 1, nil);
  STAssertTrue([[result cadr] isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([[result cadr] intValue], 2, nil);
  STAssertTrue([[result caddr] isMemberOfClass:[DslNumber class]], nil);
  STAssertEquals([[result caddr] intValue], 3, nil);
  STAssertNil([result cdddr], nil);
}


- (void) testCopyReturnValue
{
  DslExpression *list = [p parseExpression:[InputStream withString:@"()"]];
  STAssertNotNil([list copy], nil);
  STAssertTrue([[list copy] isKindOfClass:[DslCons class]], nil);
}


- (void) testCopyEmptyList
{
  DslExpression *list = [p parseExpression:[InputStream withString:@"()"]];
  STAssertEquals([[list length] intValue], 0, nil);
  STAssertNil([list car], nil);
  STAssertNil([list cdr], nil);
}


- (void) testCopySingletonList
{
  DslExpression *list = [p parseExpression:[InputStream withString:@"(a)"]];
  STAssertEquals([[list length] intValue], 1, nil);
  STAssertNotNil([list car], nil);
  STAssertNil([list cdr], nil);
  STAssertEqualObjects([[list car] identifierValue], @"a", nil);
}


- (void) testCopyNontrivialList
{
  DslExpression *list = [p parseExpression:[InputStream withString:@"(a 2)"]];
  STAssertEquals([[list length] intValue], 2, nil);
  STAssertNotNil([list car], nil);
  STAssertNotNil([list cdr], nil);
  STAssertEqualObjects([[list car] identifierValue], @"a", nil);
  STAssertNotNil([list cadr], nil);
  STAssertNil([list cddr], nil);
  STAssertEquals([[list cadr] intValue], 2, nil);
}



- (void) testSelect
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(select (lambda (l) (< (length l) 3)) '((1) (2 2) (3 3 3) (4 4 4 4) (5 5 5 5 5)) )"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isKindOfClass:[DslCons class]], nil);
  STAssertEquals([[result length] intValue], 2, nil);
}


- (void) testAnyWithNone
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(any? (lambda (i) (< i 3)) '(3 4 5)"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isKindOfClass:[DslBoolean class]], nil);
  STAssertFalse([result booleanValue], nil);
}


- (void) testAnyWithOne
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(any? (lambda (i) (< i 3)) '(1 4 5)"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isKindOfClass:[DslBoolean class]], nil);
  STAssertTrue([result booleanValue], nil);
}


- (void) testAnyWithMultiple
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(any? (lambda (i) (< i 3)) '(1 4 2)"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isKindOfClass:[DslBoolean class]], nil);
  STAssertTrue([result booleanValue], nil);
}


@end
