//
//  DslParser.m
//  DSL
//
//  Created by David Astels on 4/11/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "DslParser.h"
#import "Dsl.h"

@implementation DslParser

- (DslExpression*)parseNumber:(InputStream*)input
{
  unichar nextChar = 0;
  [input savePosition];
  while ([input isMore] && isdigit(nextChar = [input nextChar]))
    ;
  if (!isdigit(nextChar)) {
    [input rollback];
  }
  int value = [[input extract] intValue];
  return [DslNumber numberWith:value];
}


- (DslExpression*)parseString:(InputStream*)input
{
  [input savePosition];
  while ([input nextChar] != '"') {
    if ([input atEnd]) {
      return nil;
    }
  }
  [input rollback]; // back up over the closing quote so it doesn't get grabbed
  NSString *value = [input extract];
  [input nextChar]; // need to consume the closing quote
  return [DslString stringWith:value];
}


- (DslExpression*)parseBoolean:(InputStream*)input
{
  BOOL value = NO;
  unichar nextChar = [input nextChar];
  
  if (nextChar == 't') {
    value = YES;
  } else {
    value = NO;
  }

  return [DslBoolean booleanWith:value];
}


- (BOOL) isIdentifierCharacter:(unichar)ch
{
  if (isalnum(ch)) return YES;
  if (ch == '-') return YES;
  if (ch == '?') return YES;
  return NO;
}

- (DslExpression*)parseIdentifier:(InputStream*)input
{
  unichar nextChar = 0;
  [input savePosition];
  while ([input isMore] && [self isIdentifierCharacter:(nextChar = [input nextChar])])
    ;
  if (![self isIdentifierCharacter:(nextChar)]) {
    [input rollback];
  }
  NSString *value = [input extract];
  if ([value isEqualToString:@"nil"]) {
    return NIL_CONS;
  } else {
    return [DslSymbol withName:value];
  }
}


- (BOOL) isSpecialIdentifierCharacter:(unichar)nextChar
{
  return nextChar == '+' || nextChar == '-' || nextChar == '*' || nextChar == '/' || nextChar == '%'|| nextChar == '<' || nextChar == '>' || nextChar == '=';
}


- (DslExpression*)parseSpecialIdentifier:(InputStream*)input
{
  unichar nextChar = [input nextChar];
  return [DslSymbol withName:[NSString stringWithFormat:@"%C", nextChar]];
}


- (DslExpression*)parseAtomicExpression:(InputStream*)input
{
  unichar nextChar = [input nextChar];
  if (isdigit(nextChar)) {
    [input rollback];
    return [self parseNumber:input];
  } else if (isalpha(nextChar)) {
    [input rollback];
    return [self parseIdentifier:input];
  } else if ([self isSpecialIdentifierCharacter:nextChar]) {
    [input rollback];
    return [self parseSpecialIdentifier:input];
  } else if (nextChar == '#') {
    return [self parseBoolean:input];
  } else if (nextChar == '"') {
    return [self parseString:input];
  } else {
    return nil;
  }
}


- (DslExpression*)parseExpression:(InputStream*)input
{
  unichar nextChar = [input nextChar];
  if (nextChar == '(') {
    return [self parseCons:input];
  } else if (nextChar == '\'') {
    return [DslCons withHead:[DslSymbol withName:@"quote"] andTail:[DslCons withHead:[self parseExpression:input]]];
  } else {
    [input rollback];
    return [self parseAtomicExpression:input];
  }
}


- (void) consumeWhitespace:(InputStream*)input
{
  unichar nextChar = 0;
  while ([input isMore] && isspace(nextChar = [input nextChar]))
    ;
  if ([input isMore] || !isspace(nextChar)) {
    [input rollback];
  }
}


- (DslExpression*)parseCons:(InputStream*)input
{
  DslCons *head = [DslCons empty];
  DslCons *tail = head;
  
  while ([input nextChar] != ')') {
    if ([input atEnd]) {
      return NIL_CONS;
    }
    [input rollback];
    [self consumeWhitespace:input];
    if ([input nextChar] == '.') {
      if (tail) {
        [self consumeWhitespace:input];
        tail.tail = [self parseExpression:input];
        tail = nil;
        [self consumeWhitespace:input];
      } else {
        return NIL_CONS;
      }
    } else {
      [input rollback];
      DslCons *newCons = [DslCons withHead:[self parseExpression:input]];
      tail.tail = newCons;
      tail = newCons;
      [self consumeWhitespace:input];
    }
  }
  DslExpression *result = head.tail;
  return result;
}

@end
