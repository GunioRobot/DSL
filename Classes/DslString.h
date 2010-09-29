//
//  DslString.h
//  DSL
//
//  Created by David Astels on 4/11/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//


#import "DslExpression.h"


@interface DslString : DslExpression {
  NSString *value;
}

+(DslString*)stringWith:(NSString*)str;
-(DslString*)initWithString:(NSString*)str;

@end
