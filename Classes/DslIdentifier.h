//
//  DslIdentifier.h
//  DSL
//
//  Created by David Astels on 4/12/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DslExpression.h"

@interface DslIdentifier : DslExpression {
  NSString *name;
}

+ (DslIdentifier*)identifierWithName:(NSString*)name;
- (DslIdentifier*)initWithName:(NSString*)name;

@end
