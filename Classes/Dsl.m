//
//  Dsl.m
//  DSL
//
//  Created by David Astels on 9/29/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "Dsl.h"
#import "SymbolTable.h"

@implementation Dsl

- (Dsl *) init
{
  parser = [[DslParser alloc] init];
  symbolTable = [[SymbolTable alloc] init];
  return self;  
}


- (DslExpression *) parse:(NSString*)codeString
{
  return [parser parseExpression:[InputStream withString:codeString]];
}


- (DslSymbol *) intern:(NSString *)name
{
  return [symbolTable intern:name];
}


- (DslExpression*) bind:(DslSymbol*)symbol to:(DslExpression*)value
{
  return [symbolTable bind:symbol to:value];
}


- (DslExpression*) valueOf:(DslSymbol*)symbol
{
  return [symbolTable valueOf:symbol];
}


- (void) pushLocalBindings
{
  [symbolTable pushLocalBindings];
}


- (void) popLocalBindings
{
  [symbolTable popLocalBindings];
}


- (DslFunction*) lambda:(DslCons*)args
{
}


- (DslFunction*) defun:(DslCons*)args
{
}


- (DslFunction*) defBuiltin:(DslCons*)args
{
}


- (DslExpression*) apply:(DslCons*)args
{
}


- (DslExpression*) let:(DslCons*)args
{
}


- (DslCons*) cons:(DslCons*)args
{
}


- (DslExpression*) car:(DslCons*)args
{
}


- (DslExpression*) cdr:(DslCons*)args
{
}


- (DslExpression*) caar:(DslCons*)args
{
}


- (DslExpression*) cadr:(DslCons*)args
{
}


- (DslExpression*) cdar:(DslCons*)args
{
}


- (DslExpression*) cddr:(DslCons*)args
{
}


- (DslExpression*) caaar:(DslCons*)args
{
}


- (DslExpression*) caadr:(DslCons*)args
{
}


- (DslExpression*) cadar:(DslCons*)args
{
}


- (DslExpression*) caddr:(DslCons*)args
{
}


- (DslExpression*) cdaar:(DslCons*)args
{
}


- (DslExpression*) cdadr:(DslCons*)args
{
}


- (DslExpression*) cddar:(DslCons*)args
{
}


- (DslExpression*) cdddr:(DslCons*)args
{
}


- (DslNumber*) length:(DslCons*)args
{
}


@end
