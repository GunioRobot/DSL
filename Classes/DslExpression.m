//
//  DslExpression.m
//  DSL
//
//  Created by David Astels on 4/11/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "DslExpression.h"
#import "DslNumber.h"
#import "DslCons.h"


@implementation DslExpression

int indentLevel = 0;

- (int) intValue
{
  return 0;
}


- (NSString*) stringValue
{
  return @"";
}


- (BOOL) booleanValue
{
  return YES;
}


- (NSString*) identifierValue
{
  return @"";
}


- (DslExpression*)head
{
  return nil;
}


- (DslExpression*)tail
{
  return nil;
}


- (DslExpression*) length
{
  return [DslNumber numberWith:1];
}



- (DslExpression*) car    { return nil; }
- (DslExpression*) cadr   { return nil; }
- (DslExpression*) caddr  { return nil; }
- (DslExpression*) cadar  { return nil; }
- (DslExpression*) cadddr { return nil; }
- (DslExpression*) caar   { return nil; }
- (DslExpression*) caadr  { return nil; }
- (DslExpression*) cdr    { return nil; }
- (DslExpression*) cddr   { return nil; }
- (DslExpression*) cdddr  { return nil; }
- (DslExpression*) cddddr { return nil; }
- (DslExpression*) cdar   { return nil; }
- (DslExpression*) cdadr  { return nil; }


- (DslExpression*) eval:(DslCons*)bindings
{
  [self logEval:self];
  return [self logResult:self];
}


- (DslExpression*) evalEach:(DslCons*)bindings
{
  return self;
}



- (NSString*) indentString
{
  NSString *result = @"";
  int i;
  for (i = 0; i < indentLevel; i++) {
    result = [result stringByAppendingString:@"  "];
  }
  return result;
}



- (DslExpression*)logEval:(DslExpression*)sexpr
{
  indentLevel++;
//  NSLog(@"%@Eval: %@", [self indentString], [sexpr toString]);
  return sexpr;
}

- (DslExpression*)logResult:(DslExpression*)val
{
  NSString *valString = val == nil ? @"nil" : [val toString];
//  NSLog(@"%@==> %@", [self indentString], valString);
  indentLevel--;
  return val;
}



- (BOOL) compareTo:(DslExpression*)other
{
  return [self isMemberOfClass:[other class]];
}


@end
