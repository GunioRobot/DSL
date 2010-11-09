//
//  InputStream.h
//  DSL
//
//  Created by David Astels on 4/12/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface InputStream : NSObject {
  NSString *contents;
  int position;
  int bookmark;
}

+ (InputStream*) withFile:(NSString*)filename;
+ (InputStream*) withString:(NSString*)str;
- (InputStream*) initWithString:(NSString*)str;
- (unichar) nextChar;
- (void) rollback;
- (BOOL) isMore;
- (BOOL) atEnd;
- (void) savePosition;
- (NSString*)extract;

@end
