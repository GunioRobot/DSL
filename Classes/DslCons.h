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


@interface DslCons : DslExpression {
  DslExpression *head;
  DslExpression *tail;
}

@property (assign, nonatomic) DslExpression *head;
@property (assign, nonatomic) DslExpression *tail;

+ (DslCons*) quote:(DslExpression*)sexpr;
+ (DslCons*) empty;
+ (DslCons*) withHead:(DslExpression*)h;
+ (DslCons*) withHead:(DslExpression*)h andTail:(DslExpression*)t;

- (DslCons*) init;
- (DslCons*) initWithHead:(DslExpression*)h andTail:(DslExpression*)t;

- (void) setHead:(DslExpression*)h;
- (void) setTail:(DslExpression*)t;

- (DslCons*) append:(DslExpression*)cell;
- (DslCons*) copyList;
- (DslCons*) last;
- (DslExpression*) find:(DslSymbol*)variableName;

- (DslCons*) copy;

@end
