//
//  BooleanParsingTestCase.m
//  DSL
//
//  Created by David Astels on 4/12/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "BooleanParsingTestCase.h"


@implementation BooleanParsingTestCase


- (void) setUp
{
  p = [[DslParser alloc] init];  
}


- (void) testTrue 
{
  DslExpression *e = [p parseBoolean:[InputStream withString:@"t"]];
  STAssertTrue([e isMemberOfClass:[DslBoolean class]], @"expected a DslBoolean");
  STAssertTrue([e booleanValue], nil);  
}


- (void) testFalse 
{
  DslExpression *e = [p parseBoolean:[InputStream withString:@"f"]];
  STAssertTrue([e isMemberOfClass:[DslBoolean class]], @"expected a DslBoolean");
  STAssertFalse([e booleanValue], nil);  
}


@end
