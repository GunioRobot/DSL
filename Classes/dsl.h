//
//  Dsl.h
//  DSL
//
//  Created by David Astels on 4/12/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InputStream.h"
#import "DslParser.h"
#import "DslExpression.h"
#import "DslString.h"
#import "DslNumber.h"
#import "DslBoolean.h"
#import "DslSymbol.h"
#import "DslCons.h"
#import "DslFunction.h"
#import "DslObject.h"
#import "Functions.h"
#import "SymbolTable.h"


@interface Dsl : NSObject {
  DslParser *parser;
  SymbolTable *symbolTable;
}


- (Dsl *) init;

- (DslExpression *) parse:(NSString*)codeString;

// internal symbol functions

- (DslSymbol *) intern:(NSString *)name;
- (DslExpression*) bind:(DslSymbol*)symbol to:(DslExpression*)value;
- (DslExpression*) valueOf:(DslSymbol*)symbol;
- (void) pushLocalBindings;
- (void) popLocalBindings;

// function functions

- (DslFunction*) lambda:(DslCons*)args;
- (DslFunction*) defun:(DslCons*)args;
- (DslFunction*) defBuiltin:(DslCons*)args;
- (DslExpression*) apply:(DslCons*)args;
- (DslExpression*) let:(DslCons*)args;

// list functions

- (DslCons*) cons:(DslCons*)args;

- (DslExpression*) car:(DslCons*)args;
- (DslExpression*) cdr:(DslCons*)args;

- (DslExpression*) caar:(DslCons*)args;
- (DslExpression*) cadr:(DslCons*)args;
- (DslExpression*) cdar:(DslCons*)args;
- (DslExpression*) cddr:(DslCons*)args;

- (DslExpression*) caaar:(DslCons*)args;
- (DslExpression*) caadr:(DslCons*)args;
- (DslExpression*) cadar:(DslCons*)args;
- (DslExpression*) caddr:(DslCons*)args;
- (DslExpression*) cdaar:(DslCons*)args;
- (DslExpression*) cdadr:(DslCons*)args;
- (DslExpression*) cddar:(DslCons*)args;
- (DslExpression*) cdddr:(DslCons*)args;

- (DslNumber*) length:(DslCons*)args;

- (DslCons*) map:(DslCons*)args;
- (DslCons*) select:(DslCons*)args;
- (DslCons*) any:(DslCons*)args;

- (DslCons*) cond:(DslCons*)args;
- (DslCons*) logicalOr:(DslCons*)args;
- (DslCons*) logicalAnd:(DslCons*)args;
- (DslCons*) locicalNot:(DslCons*)args;

- (DslCons*) add:(DslCons*)args;
- (DslCons*) subtract:(DslCons*)args;
- (DslCons*) multiply:(DslCons*)args;
- (DslCons*) divide:(DslCons*)args;
- (DslCons*) modulus:(DslCons*)args;


@end
