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


@interface Dsl : NSObject {
  DslParser *parser;
}


- (Dsl *) init;

- (DslExpression *)parse:(NSString*)codeString;

// symbol functions

- (DslSymbol *)intern:(NSString *)name;
- (DslExpression*)bind:(DslSymbol*)symbol to:(DslExpression*)value;
- (DslExpression*)valueOf:(DslSymbol*)symbol;

// function functions

- (DslFunction*)lambdaWithParams:(DslCons*)params andBody:(DslCons*)body;
- (DslFunction*)defun:(DslSymbol*) withParams:(DslCons*)params andBody:(DslCons*)body;
- (DslFunction*)defBuiltin:(DslSymbol *) withParams :(DslCons *)params andSelector:(SEL)selector;
- (DslExpression*)apply:(DslFunction*)function to:(DslCons*)args;

// list functions

- (DslCons*)cons:(DslExpression*)head and:(DslExpression*)tail;

- (DslExpression*)car:(DslCons*)list;
- (DslExpression*)cdr:(DslCons*)list;

- (DslExpression*)caar:(DslCons*)list;
- (DslExpression*)cadr:(DslCons*)list;
- (DslExpression*)cdar:(DslCons*)list;
- (DslExpression*)cddr:(DslCons*)list;

- (DslExpression*)caaar:(DslCons*)list;
- (DslExpression*)caadr:(DslCons*)list;
- (DslExpression*)cadar:(DslCons*)list;
- (DslExpression*)caddr:(DslCons*)list;
- (DslExpression*)cdaar:(DslCons*)list;
- (DslExpression*)cdadr:(DslCons*)list;
- (DslExpression*)cddar:(DslCons*)list;
- (DslExpression*)cdddr:(DslCons*)list;

- (DslNumber*)length:(DslCons*)list;


@end
