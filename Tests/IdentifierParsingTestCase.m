//
//  IdentifierParsing.m
//  DSL
//
//  Created by David Astels on 4/12/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "IdentifierParsingTestCase.h"


@implementation IdentifierParsingTestCase

- (void) setUp
{
  p = [[DslParser alloc] init];  
}


- (void) testIdentifier
{
  DslExpression *e = [p parseIdentifier:[InputStream withString:@"test"]];
  STAssertTrue([e isMemberOfClass:[DslIdentifier class]], @"expected a Dsldentifier");
  STAssertEqualObjects([e identifierValue], @"test", nil);  
}


- (void) testIdentifierWithEmbeddedDash
{
  DslExpression *e = [p parseIdentifier:[InputStream withString:@"test-dash"]];
  STAssertTrue([e isMemberOfClass:[DslIdentifier class]], @"expected a Dsldentifier");
  STAssertEqualObjects([e identifierValue], @"test-dash", nil);  
}


- (void) testPlusIdentifier
{
  DslExpression *e = [p parseSpecialIdentifier:[InputStream withString:@"+"]];
  STAssertTrue([e isMemberOfClass:[DslIdentifier class]], @"expected a Dsldentifier");
  STAssertEqualObjects([e identifierValue], @"+", nil);  
}


- (void) testMinusIdentifier
{
  DslExpression *e = [p parseSpecialIdentifier:[InputStream withString:@"-"]];
  STAssertTrue([e isMemberOfClass:[DslIdentifier class]], @"expected a Dsldentifier");
  STAssertEqualObjects([e identifierValue], @"-", nil);  
}


- (void) testQuoteIdentifier
{
  DslExpression *e = [p parseExpression:[InputStream withString:@"'"]];
  STAssertTrue([e isMemberOfClass:[DslCons class]], @"expected a DslCons");
  STAssertTrue([e.head isMemberOfClass:[DslIdentifier class]], @"expected a DslIdentifier");
  STAssertEqualObjects([e.head identifierValue], @"quote", nil);  
}


@end
