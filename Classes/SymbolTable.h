//
//  SymbolTable.h
//  DSL
//
//  Created by David Astels on 9/29/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DslSymbol.h"


@interface SymbolTable : NSObject {
  NSMutableArray *frames;
}

- (SymbolTable*) init;
- (DslSymbol *) intern:(NSString *)name;
- (DslExpression*) bind:(DslSymbol*)symbol to:(DslExpression*)value;
- (DslExpression*) valueOf:(DslSymbol*)symbol;
- (void) pushLocalBindings;
- (void) popLocalBindings;


@end
