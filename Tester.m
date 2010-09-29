//
//  Tester.m
//  DSL
//
//  Created by David Astels on 9/28/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "Tester.h"


@implementation Tester


- (Tester*) init
{
  p = [[DslParser alloc] init];
  return self;
}


- (BOOL) for:(NSString*)name checkThat:(NSString*)code evalsTo:(NSString*)result
{
  DslExpression *actual = [[p parseExpression:[InputStream withString:code]] eval:nil];
  DslExpression *expected = [[p parseExpression:[InputStream withString:result]] eval:nil];
  BOOL areEqual = [actual compareTo:expected];
  if (areEqual) {
    NSLog(@"PASS: '%@'", name);
  } else {
    NSLog(@"FAIL: '%@' Expected %@ but got %@", name, [expected toString], [actual toString]);
  }
  return areEqual;
}


@end
