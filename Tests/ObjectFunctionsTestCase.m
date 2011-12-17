//
//  ObjectFunctionsTestCase.m
//  DSL
//
//  Created by David Astels on 6/8/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "ObjectFunctionsTestCase.h"


@implementation ObjectFunctionsTestCase


- (void) setUp
{
  p = [[DslParser alloc] init];
}


- (void) testMethodCall
{
  DslObject *obj = [DslObject withObject:[NSNumber numberWithInt:5]];
  DslExpression *result = [obj getInteger:@"intValue"];
  STAssertTrue([result isKindOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 5, nil);
}


- (void) testMethodCallInLisp
{
  DslObject *obj = [DslObject withObject:[NSNumber numberWithInt:5]];
  DslCons *bindings = [DslCons withHead:[DslCons withHead:[DslSymbol withName:@"obj"]
                                                  andTail:[DslObject withObject:[NSNumber numberWithInt:5]]]];
  DslExpression *result = [[p parseExpression:[InputStream withString:@"(get-integer obj 'intValue)"]] eval:bindings];

  STAssertTrue([result isKindOfClass:[DslNumber class]], nil);
  STAssertEquals([result intValue], 5, nil);
}


- (void) testMethodCallInSelect
{
  DslObject *obj = [DslObject withObject:[NSNumber numberWithInt:5]];
  DslCons *bindings = [DslCons withHead:[DslCons withHead:[DslSymbol withName:@"obj1"]
                                                  andTail:[DslObject withObject:[NSNumber numberWithInt:5]]]
                                andTail:[DslCons withHead:[DslCons withHead:[DslSymbol withName:@"obj2"]
                                                                    andTail:[DslObject withObject:[NSNumber numberWithInt:2]]]]];

  DslExpression *result = [[p parseExpression:[InputStream withString:@"(select (lambda (obj) (< (get-integer obj 'intValue) 3)) (list obj1 obj2) )"]] eval:bindings];
  STAssertTrue([result isKindOfClass:[DslCons class]], nil);
  STAssertEquals([[result length] intValue], 1, nil);
}


@end
