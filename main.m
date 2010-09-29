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
    Tester *t = [[Tester alloc]init];
    [t for:@"test pass" checkThat:@"(map (lambda (l) (length l)) '((1) (2 2)) )" evalsTo:@"'(1 2)"];
    [t for:@"test fail" checkThat:@"(+ 2 2)" evalsTo:@"5"];
    [pool release];
  }
  @catch (NSException *ex) {
    int x = 5;
  }
}
