//
//  NumberFunctionsTestCase.m
//  DSL
//
//  Created by David Astels on 6/8/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "NumberFunctionsTestCase.h"


@implementation NumberFunctionsTestCase

- (void) setUp
{
  p = [[DslParser alloc] init];  
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


- (void) testEqualToTrue
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(= 1 1)"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isMemberOfClass:[DslBoolean class]], nil);
  STAssertTrue([result booleanValue], nil);
}  


- (void) testEqualToFalse
{
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(= 1 2)"]] eval:nil];
  STAssertNotNil(result, nil);
  STAssertTrue([result isMemberOfClass:[DslBoolean class]], nil);
  STAssertFalse([result booleanValue], nil);
}  


@end
