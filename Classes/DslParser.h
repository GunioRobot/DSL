//
//  DslParser.h
//  DSL
//
//  Created by David Astels on 4/11/10.
//  Copyright 2010 Dave Astels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InputStream.h"
#import "DslExpression.h"
#import "DslNumber.h"
#import "DslString.h"
#import "DslBoolean.h"
#import "DslSymbol.h"
#import "DslCons.h"

@interface DslParser : NSObject {

}

- (void) consumeWhitespace:(InputStream*)input;
- (DslExpression*)parseNumber:(InputStream*)input;
- (DslExpression*)parseString:(InputStream*)input;
- (DslExpression*)parseBoolean:(InputStream*)input;
- (DslExpression*)parseIdentifier:(InputStream*)input;
- (DslExpression*)parseSpecialIdentifier:(InputStream*)input;
- (DslExpression*)parseAtomicExpression:(InputStream*)input;
- (DslExpression*)parseCons:(InputStream*)input;
- (DslExpression*)parseExpression:(InputStream *)input;

@end
