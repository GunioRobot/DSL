//
//  Functions.m
//  Primed
//
//  Created by David Astels on 4/20/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "Functions.h"

@implementation Functions



//==========================================================================================
// Standard
//==========================================================================================


- (DslCons*) evalArgs:(DslCons*)args withBindings:(DslCons*)bindings
{
  DslCons *cell = [DslCons withHead:[[args car] eval:bindings]];
  if ([args cdr]) {
    cell.tail = [self evalArgs:(DslCons*)[args cdr] withBindings:bindings];
  }
  return cell;
}


- (int) findLength:(DslCons*)aList
{
  if (aList == nil) return 0;
  return 1 + [self findLength:(DslCons*)[aList cdr]];
}


- (DslExpression*) length:(DslCons*)args withBindings:(DslCons*)bindings
{
  int len = 0;
  DslCons *aList = args.head;
  if (aList.head == nil && aList.tail == nil) {
    return [DslNumber numberWith:0];
  }
  while (aList != nil) {
    len++;
    aList = aList.tail;
  }
  return [DslNumber numberWith:len];
}




- (DslExpression*) eval:(NSString*)name withArgs:(DslCons*)args andBindings:(DslCons*)bindings
{
  DslCons *cookedArgs = [self evalArgs:args withBindings:bindings];
  if ([name isEqualToString:@"length"]) {
    return [self length:cookedArgs withBindings:bindings];
  } else {
    return nil;
  }
}
  
@end
