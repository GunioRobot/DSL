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
  [self pushLocalBindings];
  return self;
}


- (DslSymbol*) findSymbol:(NSString*)name
{
  for (NSMutableDictionary *frame in frames) {
    for (NSString *symName in [frame allKeys]) {
      if ([symName isEqualToString:name]) {
        return ((Binding*)[frame objectForKey:symName]).symbol;
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
    Binding *binding = [frame objectForKey:symbol.name];
    if (binding != nil) {
      return binding;
    }
  }
  return nil;
}


- (Binding*)findBindingInLocalFrameFor:(DslSymbol*)symbol
{
  return [[self localFrame] objectForKey:symbol.name];
}


- (DslSymbol *) intern:(NSString *)name
{
  DslSymbol *found = [self findSymbol:name];
  if (found == nil) {
    DslSymbol *sym = [[DslSymbol withName:name] retain];
    [self bind:sym to:NIL_CONS];
    return sym;
  } else {
    return found;
  }
}



- (DslExpression*) bind:(DslSymbol*)symbol to:(DslExpression*)value
{
  Binding *found = [self findBindingInLocalFrameFor:symbol];
  if (found == nil) {
    Binding *binding = [Binding alloc];
    binding.symbol = [symbol retain];
    binding.value = [value retain];
    [[self localFrame] setObject:binding forKey:symbol.name];
  } else {
    found.value = value;
  }
  return value;
}


- (DslExpression*) valueOf:(DslSymbol*)symbol
{
  Binding *found = [self findBindingFor:symbol];
  if (found == nil) {
    return NIL_CONS;
  } else {
    return found.value;
  }

}


- (void) pushLocalBindings
{
  [frames insertObject:[NSMutableDictionary dictionaryWithCapacity:25] atIndex:0];
}


- (void) popLocalBindings
{
  [frames removeObjectAtIndex:0];
}


@end
