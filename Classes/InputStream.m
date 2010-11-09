//
//  InputStream.m
//  DSL
//
//  Created by David Astels on 4/12/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import "InputStream.h"


@implementation InputStream


+ (InputStream*) withFile:(NSString*)filename
{
  NSFileHandle *readHandle = [NSFileHandle fileHandleForReadingAtPath:path];
  if (readHandle) {
    NSString *testString = [[NSString alloc] initWithData: [readHandle readDataToEndOfFile] encoding:NSUTF8StringEncoding];
    [reporter startFile:[self testNameFromPath:path]];
    [self process:testString];
    [testString release];
    [readHandle closeFile];
  }
  
}

+ (InputStream*) withString:(NSString*)str
{
  return [[InputStream alloc] initWithString:str];
}


- (InputStream*) initWithString:(NSString*)str
{
  contents = [str retain];
  position = 0;
  bookmark = 0;
  return self;
}


- (unichar) nextChar
{
  if ([self atEnd]) {
    return (unichar)0;
  } else {
    return [contents characterAtIndex:position++];
  }
}


- (void) rollback
{
  position--;
}


- (BOOL) isMore
{
  return position < [contents length];
}


- (BOOL) atEnd
{
  return position == [contents length];
}


- (void) savePosition
{
  bookmark = position;
}


- (NSString*)extract
{
  return [contents substringWithRange:(NSMakeRange(bookmark, position - bookmark))];
}


@end
