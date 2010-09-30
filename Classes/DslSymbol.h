//
//  DslIdentifier.h
//  DSL
//
//  Created by David Astels on 4/12/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DslExpression.h"

@interface DslSymbol : DslExpression {
  NSString *name;
}

+ (DslSymbol*)withName:(NSString*)name;
- (DslSymbol*)initWithName:(NSString*)name;
- (BOOL) isNamed:(NSString*)aName;

@end
