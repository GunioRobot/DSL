//
//  DslCons.h
//  DSL
//
//  Created by David Astels on 4/12/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DslExpression.h"
#import "DslSymbol.h"
#import "DslNumber.h"
#import "DslString.h"

@class DslFunction;

@class DslFunction;


@interface DslCons : DslExpression {
  DslExpression *head;
  DslExpression *tail;
}

@property (assign, nonatomic) DslExpression *head;
@property (assign, nonatomic) DslExpression *tail;

+ (DslCons*) quote:(DslExpression*)sexpr;
+ (DslCons*) withHead:(DslExpression*)h;
+ (DslCons*) withHead:(DslExpression*)h andTail:(DslExpression*)t;

- (DslCons*) init;
- (DslCons*) initWithHead:(DslExpression*)h;
- (DslCons*) initWithHead:(DslExpression*)h andTail:(DslExpression*)t;

- (void) setHead:(DslExpression*)h;
- (void) setTail:(DslExpression*)t;

- (DslCons*) append:(DslExpression*)cell;
- (DslCons*) copyList;
- (DslCons*) last;
- (DslExpression*) find:(DslSymbol*)variableName;
- (DslCons*) evalMap:(DslCons*)bindings;
- (DslCons*) applyFunction:(DslFunction*)func withBindings:(DslCons*)bindings;
- (DslCons*) quote:(DslExpression*)sexpr;
- (DslExpression*) evalLet:(DslCons*)bindings;
- (DslExpression*) evalCond:(DslCons*)bindings;

- (int) subtractPrim2:(int)start withBindings:(DslCons*)bindings;
- (int) addPrim:(int)start withBindings:(DslCons*)bindings;
- (int) subtractPrimWithBindings:(DslCons*)bindings;

- (DslCons*) copy;
- (DslCons*) makeList:(DslCons*)bindings;
- (DslNumber*) fetchInteger:(DslCons*)bindings;
- (DslString*) fetchString:(DslCons*)bindings;
- (DslCons*) filterWith:(DslCons*)mask;

@end
