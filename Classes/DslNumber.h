//
//  DslNumber.h
//  DSL
//
//  Created by David Astels on 4/11/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DslExpression.h"


@interface DslNumber : DslExpression {
  int value;
}

+(DslNumber*)numberWith:(int)num;
-(DslNumber*)initWithNumber:(int)num;

@end
