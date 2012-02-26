/**
    STCompiler.h
    Bytecode compiler. Generates STExecutableCode from source code.
 
    Copyright (c) 2002 Free Software Foundation
 
    Written by: Stefan Urbanek <urbanek@host.sk>
 
    This file is part of the StepTalk project.
 
    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.
 
    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.
 
    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#import <Foundation/NSObject.h>
#import <Foundation/NSGeometry.h>
#import <Foundation/NSRange.h>

@class STCompiledScript;
@class STCompiledCode;
@class STCompiledMethod;
@class STEnvironment;
@class STSourceReader;

@class STCExpression;
@class STCMethod;
@class STCPrimary;
@class STCStatements;

@class STCompiler;

@class NSMutableData;
@class NSMutableArray;
@protocol STScriptObject;
/*" Parser context information "*/
typedef struct _STParserContext
{
    STCompiler     *compiler;
    STSourceReader *reader;
} STParserContext;


/*" Get compiler from parser context "*/
#define STParserContextGetCompiler(context)\
            (((STParserContext *)context)->compiler)
/*" Get source reader from parser context "*/
#define STParserContextGetReader(context)\
            (((STParserContext *)context)->reader)

/*" Initialize parser context "*/
#define STParserContextInit(context,aCompiler,aReader) \
           do { \
                ((STParserContext *)context)->compiler = aCompiler; \
                ((STParserContext *)context)->reader = aReader; \
           } while(0) 

@interface STCompiler:NSObject
{
    STEnvironment    *environment;

    STSourceReader   *reader;
    STParserContext   context;

    STCompiledScript *resultScript;
    STCompiledMethod *resultMethod;
    
    NSMutableData    *byteCodes;
    NSMutableArray   *tempVars;
    NSMutableArray   *externVars;
    NSMutableArray   *receiverVars;
    NSMutableArray   *namedReferences;
    NSMutableArray   *literals;
    
    id                receiver;

    BOOL              isSingleMethod;
    
    unsigned          stackSize;    /* Required stack size */
    unsigned          stackPos;     /* Current stack pointer */
    unsigned          tempsSize;    /* Required temp space */
    unsigned          tempsCount;   /* Actual temp space */
    unsigned          bcpos;        /* Bytecode position */

    Class           stringLiteralClass; /* default: NSMutableString */
    Class           arrayLiteralClass;  /* default: NSMutableArray */
    Class           characterLiteralClass;  /* default: NSString */
    Class           intNumberLiteralClass; /* default: NSNumber */
    Class           realNumberLiteralClass; /* default: NSNumber */
    Class           symbolLiteralClass; /* default: NSString */
}
+ compilerWithEnvironment:(STEnvironment *)env;
- initWithEnvironment:(STEnvironment *)env;
/*" Environment "*/
- (void)setEnvironment:(STEnvironment *)env;
- (STSourceReader *)sourceReader;

/*" Compilation "*/

- (STCompiledScript *)compileString:(NSString *)aString;
- (STCompiledMethod *)compileMethodFromSource:(NSString *)aString
                                  forReceiver:(id <STScriptObject>)receiver;

/*
- (NSMutableArray *)compileString:(NSString *)string;
- (NSMutableArray *)compileString:(NSString *)string range:(NSRange) range;
*/


/*" Literals "*/
- (Class)intNumberLiteralClass;
- (Class)realNumberLiteralClass;
- (Class)stringLiteralClass;
- (Class)arrayLiteralClass;
- (Class)symbolLiteralClass;
- (void)setStringLiteralClass:(Class)aClass;
- (void)setArrayLiteralClass:(Class)aClass;
- (void)setSymbolLiteralClass:(Class)aClass;
- (void)setIntNumberLiteralClass:(Class)aClass;
- (void)setRealNumberLiteralClass:(Class)aClass;

- (void)setReceiverVariables:(NSArray *)vars;

- (void)addTempVariable:(NSString *)varName;
- (BOOL)beginScript;
@end
