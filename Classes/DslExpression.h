//
//  DslExpression.h
//  DSL
//
//  Created by David Astels on 4/11/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DslCons;

@interface DslExpression : NSObject {

}

- (int) intValue;
- (NSString*) stringValue;
- (BOOL) booleanValue;
- (NSString*) identifierValue;
- (DslExpression*)head;
- (DslExpression*)tail;
- (DslExpression*) length;
- (DslExpression*) eval;
- (DslExpression*) evalEach:(DslCons*)bindings;

- (NSString*) toString;
- (NSString*) toStringHelper;

- (DslExpression*)logEval:(DslExpression*)sexpr;
- (DslExpression*)logResult:(DslExpression*)val;

- (BOOL) compareTo:(DslExpression*)other;

- (BOOL) isNil;
- (BOOL) notNil;
- (BOOL) isList;

@end
