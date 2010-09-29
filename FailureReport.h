//
//  FailureReport.h
//  DSL
//
//  Created by David Astels on 9/29/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FailureReport : NSObject {
  NSString *test;
  NSString *code;
  NSString *actual;
  NSString *expected;
}

+ (FailureReport*) for:(NSString *)name code:(NSString *)code actual:(NSString *)actual expected:(NSString *)expected;
- (FailureReport*) initFor:(NSString *)name code:(NSString *)code actual:(NSString *)actual expected:(NSString *)expected;
- (void) report;

@end
