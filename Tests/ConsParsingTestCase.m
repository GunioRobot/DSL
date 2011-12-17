//
//  SexprParsingTestCase.m
//  DSL
//
//  Created by David Astels on 4/12/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "ConsParsingTestCase.h"


@implementation ConsParsingTestCase


- (void) setUp
{
  p = [[DslParser alloc] init];
}


- (void) testGetsACons
{
  DslExpression *e = [p parseCons:[InputStream withString:@")"]];
  STAssertTrue([e isMemberOfClass:[DslCons class]], @"expected a DslCons");
}

- (void) testGetsAnEmptyListCons
{
  DslExpression *e = [p parseCons:[InputStream withString:@")"]];
  STAssertNil(e.head, nil);
  STAssertNil(e.tail, nil);
}



- (void) testGetsAListOfOneNumber
{
  DslExpression *e = [p parseCons:[InputStream withString:@"1)"]];
  STAssertNotNil([e head], nil);
  STAssertTrue([e.head isMemberOfClass:[DslNumber class]], @"expected a DslNumber");
  STAssertEquals([e.head intValue], 1, nil);
  STAssertNil(e.tail, nil);
}


- (void) testGetsAListOfOneString
{
  DslExpression *e = [p parseCons:[InputStream withString:@"\"a\")"]];
  STAssertNotNil([e head], nil);
  STAssertTrue([e.head isMemberOfClass:[DslString class]], @"expected a DslString");
  STAssertEqualObjects([e.head stringValue], @"a", nil);
  STAssertNil(e.tail, nil);
}


- (void) testGetsAListOfOneIdentifier
{
  DslExpression *e = [p parseCons:[InputStream withString:@"a)"]];
  STAssertNotNil([e head], nil);
  STAssertTrue([e.head isMemberOfClass:[DslIdentifier class]], @"expected a DslIdentifier");
  STAssertEqualObjects([e.head identifierValue], @"a", nil);
  STAssertNil(e.tail, nil);
}


- (void) testGetsAListOfTwo
{
  DslExpression *e = [p parseCons:[InputStream withString:@"a 2)"]];
  STAssertNotNil(e.head, nil);
  STAssertTrue([e.head isMemberOfClass:[DslIdentifier class]], @"expected a DslIdentifier");
  STAssertEqualObjects([e.head identifierValue], @"a", nil);
  STAssertNotNil(e.tail, nil);
  STAssertNotNil(e.tail.head, nil);
  STAssertTrue([e.tail.head isMemberOfClass:[DslNumber class]], @"expected a DslNumber");
  STAssertEquals([e.tail.head intValue], 2, nil);
}


- (void) testGetsALongList
{
  DslExpression *e = [p parseCons:[InputStream withString:@"a 2 b 3 \"hello\")"]];
  STAssertNotNil(e.head, nil);
  STAssertTrue([e.head isMemberOfClass:[DslIdentifier class]], @"expected a DslIdentifier");
  STAssertEqualObjects([e.head identifierValue], @"a", nil);

  STAssertNotNil(e.tail, nil);
  STAssertNotNil(e.tail.head, nil);
  STAssertTrue([e.tail.head isMemberOfClass:[DslNumber class]], @"expected a DslNumber");
  STAssertEquals([e.tail.head intValue], 2, nil);

  STAssertNotNil(e.tail.tail, nil);
  STAssertNotNil(e.tail.tail.head, nil);
  STAssertTrue([e.tail.tail.head isMemberOfClass:[DslIdentifier class]], @"expected a DslIdentifier");
  STAssertEqualObjects([e.tail.tail.head identifierValue], @"b", nil);

  STAssertNotNil(e.tail.tail.tail, nil);
  STAssertNotNil(e.tail.tail.tail.head, nil);
  STAssertTrue([e.tail.tail.tail.head isMemberOfClass:[DslNumber class]], @"expected a DslNumber");
  STAssertEquals([e.tail.tail.tail.head intValue], 3, nil);

  STAssertNotNil(e.tail.tail.tail.tail, nil);
  STAssertNotNil(e.tail.tail.tail.tail.head, nil);
  STAssertTrue([e.tail.tail.tail.tail.head isMemberOfClass:[DslString class]], @"expected a DslString");
  STAssertEqualObjects([e.tail.tail.tail.tail.head stringValue], @"hello", nil);
}


- (void) testANestedList
{
  DslExpression *e = [p parseCons:[InputStream withString:@"a (2) b)"]];
  STAssertNotNil(e.head, nil);
  STAssertTrue([e.head isMemberOfClass:[DslIdentifier class]], @"expected a DslIdentifier");
  STAssertEqualObjects([e.head identifierValue], @"a", nil);

  STAssertNotNil(e.tail, nil);
  STAssertNotNil(e.tail.head, nil);
  STAssertTrue([e.tail.head isMemberOfClass:[DslCons class]], @"expected a DslCons");

  STAssertNotNil(e.tail.tail, nil);
  STAssertNotNil(e.tail.tail.head, nil);
  STAssertTrue([e.tail.tail.head isMemberOfClass:[DslIdentifier class]], @"expected a DslIdentifier");
  STAssertEqualObjects([e.tail.tail.head identifierValue], @"b", nil);
}


- (void) testADeeplyNestedList
{
  DslExpression *e = [p parseCons:[InputStream withString:@"((((2)))))"]];
  STAssertNotNil(e.head, nil);
  STAssertTrue([e.head isMemberOfClass:[DslCons class]], @"expected a DslCons");

  STAssertNotNil(e.head.head, nil);
  STAssertTrue([e.head.head isMemberOfClass:[DslCons class]], @"expected a DslCons");

  STAssertNotNil(e.head.head.head, nil);
  STAssertTrue([e.head.head.head isMemberOfClass:[DslCons class]], @"expected a DslCons");

  STAssertNotNil(e.head.head.head.head, nil);
  STAssertTrue([e.head.head.head.head isMemberOfClass:[DslCons class]], @"expected a DslCons");

  STAssertNotNil(e.head.head.head.head.head, nil);
  STAssertTrue([e.head.head.head.head.head isMemberOfClass:[DslNumber class]], @"expected a DslNumber");
  STAssertEquals([e.head.head.head.head.head intValue], 2, nil);
  STAssertNil(e.head.head.head.head.tail, nil);
}


- (void) testADottedPair
{
  DslExpression *e = [p parseCons:[InputStream withString:@"1.2)"]];
  STAssertNotNil([e head], nil);
  STAssertTrue([e.head isMemberOfClass:[DslNumber class]], @"expected a DslNumber");
  STAssertEquals([e.head intValue], 1, nil);
  STAssertNotNil(e.tail, nil);
  STAssertTrue([e.tail isMemberOfClass:[DslNumber class]], @"expected a DslNumber");
  STAssertEquals([e.tail intValue], 2, nil);
}


- (void) testADottedTail
{
  DslExpression *e = [p parseCons:[InputStream withString:@"1 2 . 3)"]];
  STAssertNotNil([e head], nil);
  STAssertTrue([e.head isMemberOfClass:[DslNumber class]], @"expected a DslNumber");
  STAssertEquals([e.head intValue], 1, nil);
  STAssertNotNil(e.tail.head, nil);
  STAssertTrue([e.tail.head isMemberOfClass:[DslNumber class]], @"expected a DslNumber");
  STAssertEquals([e.tail.head intValue], 2, nil);
  STAssertNotNil(e.tail.tail, nil);
  STAssertTrue([e.tail.tail isMemberOfClass:[DslNumber class]], @"expected a DslNumber");
  STAssertEquals([e.tail.tail intValue], 3, nil);
}


@end
