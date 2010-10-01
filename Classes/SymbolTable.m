//
//  SymbolTable.m
//  DSL
//
//  Created by David Astels on 9/29/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "SymbolTable.h"
#import "Binding.h"
#import "Dsl.h"


@implementation SymbolTable


- (SymbolTable*) init
{
  frames = [[NSMutableArray array] retain];
  return self;
}


- (DslSymbol*) findSymbol:(NSString*)name
{
  for (NSMutableDictionary *frame in frames) {
    for (DslSymbol *sym in [frame allKeys]) {
      if ([sym isNamed:name]) {
        return sym;
      }
    }
  }
  return nil;
}


- (NSMutableDictionary*) localFrame
{
  return (NSMutableDictionary*)[frames objectAtIndex:0];
}


- (Binding*)findBindingFor:(DslSymbol*)symbol
{
  for (NSMutableDictionary *frame in frames) {
    Binding *binding = [frame objectForKey:symbol];
    if (binding != nil) {
      return binding;
    }
  }
  return nil;
}


- (Binding*)findBindingInLocalFrameFor:(DslSymbol*)symbol
{
  return [[self localFrame] objectForKey:symbol];
}


- (DslSymbol *) intern:(NSString *)name
{
  DslSymbol *found = [self findSymbol:name];
  if (found == nil) {
    DslSymbol *sym = [DslSymbol withName:name];
    [self bind:sym to:NIL];
    return sym;
  } else {
    return found;
  }
}



- (DslExpression*) bind:(DslSymbol*)symbol to:(DslExpression*)value
{
  Binding *found = [self findBindingInLocalFrameFor:symbol];
  if (found == nil) {
    Binding *binding = [[Binding alloc] retain];
    binding.symbol = symbol;
    binding.value = value;
    [[self localFrame] setValue:binding forKey:symbol];
  } else {
    found.value = value;
  }
  return value;
}


- (DslExpression*) valueOf:(DslSymbol*)symbol
{
  Binding *found = [self findBindingFor:symbol];
  if (found == nil) {
    return [DslNil NIL];
  } else {
    return found.value;
  }

}


- (void) pushLocalBindings
{
  [frames insertObject:[NSMutableDictionary dictionary] atIndex:0];
}


- (void) popLocalBindings
{
  [frames removeObjectAtIndex:0];
}


@end
