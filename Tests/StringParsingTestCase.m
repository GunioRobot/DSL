//
//  StringParsingTestCase.m
//  DSL
//
//  Created by David Astels on 4/11/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "StringParsingTestCase.h"

@implementation StringParsingTestCase


- (void) setUp
{
  p = [[DslParser alloc] init];
}



- (void) testEmptyString {
  DslExpression *e = [p parseString:[InputStream withString:@"\""]];
  STAssertTrue([e isMemberOfClass:[DslString class]], @"expected a DslString");
  STAssertEqualObjects([e stringValue], @"", nil);
}


- (void) testNonEmptyString {
  DslExpression *e = [p parseString:[InputStream withString:@"Testing\""]];
  STAssertEqualObjects([e stringValue], @"Testing", nil);
}


@end
