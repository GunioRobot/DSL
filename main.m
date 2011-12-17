//
//  main.m
//  DungeonHunt
//
//  Created by David Astels on 6/14/09.
//  Copyright Dave Astels 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dsl.h"
#import "Tester.h"

int main(int argc, char *argv[]) {

  @try {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    [Dsl initialize];
    Tester *t = [[Tester alloc]init];
    [t runTests];
    [pool release];
  }
  @catch (NSException *ex) {
    int x = 5;
  }
}
