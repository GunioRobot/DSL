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

- (DslExpression*) car;
- (DslExpression*) cadr;
- (DslExpression*) caddr;
- (DslExpression*) cadar;
- (DslExpression*) cadddr;
- (DslExpression*) caar;
- (DslExpression*) caadr;
- (DslExpression*) cdr;
- (DslExpression*) cddr;
- (DslExpression*) cdddr;
- (DslExpression*) cddddr;
- (DslExpression*) cdar;
- (DslExpression*) cdadr;

- (NSString*) toString;
- (DslExpression*)logEval:(DslExpression*)sexpr;
- (DslExpression*)logResult:(DslExpression*)val;

- (BOOL) compareTo:(DslExpression*)other;

- (BOOL) isNil;

@end
