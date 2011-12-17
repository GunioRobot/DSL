//
//  AtomicExpressionParsingTest.m
//  DSL
//
//  Created by David Astels on 4/12/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "AtomicExpressionParsingTest.h"


@implementation AtomicExpressionParsingTest


- (void) setUp
{
  p = [[DslParser alloc] init];
}

- (void) testNumber
{
  DslExpression *e = [p parseAtomicExpression:[InputStream withString:@"0"]];
  STAssertTrue([e isMemberOfClass:[DslNumber class]], @"expected a DslNumber");

}


- (void) testString
{
  DslExpression *e = [p parseAtomicExpression:[InputStream withString:@"\"test\""]];
  STAssertTrue([e isMemberOfClass:[DslString class]], @"expected a DslString");
}


- (void) testBoolean
{
  DslExpression *e = [p parseAtomicExpression:[InputStream withString:@"#t"]];
  STAssertTrue([e isMemberOfClass:[DslBoolean class]], @"expected a DslBoolean");
}


- (void) testIdentifier
{
  DslExpression *e = [p parseAtomicExpression:[InputStream withString:@"test"]];
  STAssertTrue([e isMemberOfClass:[DslIdentifier class]], @"expected a Dsldentifier");
}

@end
