//
//  DslIdentifier.h
//  DSL
//
//  Created by David Astels on 4/12/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DslExpression.h"

@interface DslSymbol : DslExpression <NSCopying> {
  NSString *name;
}

@property (readonly) NSString *name;

+ (DslSymbol*)withName:(NSString*)name;
- (DslSymbol*)initWithName:(NSString*)name;
- (BOOL) isNamed:(NSString*)aName;

- (id)copyWithZone:(NSZone *)zone;

@end
