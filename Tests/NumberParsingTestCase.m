//
//  BasicTypeParsingTestCase.m
//  DSL
//
//  Created by David Astels on 4/11/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "NumberParsingTestCase.h"


@implementation NumberParsingTestCase


- (void) setUp
{
  p = [[DslParser alloc] init];
}


- (void) testZero
{
  DslExpression *e = [p parseNumber:[InputStream withString:@"0"]];
  STAssertTrue([e isMemberOfClass:[DslNumber class]], @"expected a DslNumber");
  STAssertEquals([e intValue], 0, nil);
}


- (void) testUnsignedNumber
{
  DslExpression *e = [p parseNumber:[InputStream withString:@"25"]];
  STAssertEquals([e intValue], 25, nil);
}


//- (void) testPositiveSignedNumber
//{
//  DslExpression *e = [p parseNumber:[InputStream withString:@"+25"]];
//  STAssertEquals([e intValue], 25, nil);
//}
//
//
//- (void) testNegativeSignedNumber
//{
//  DslExpression *e = [p parseNumber:[InputStream withString:@"-25"]];
//  STAssertEquals([e intValue], -25, nil);
//}

@end
