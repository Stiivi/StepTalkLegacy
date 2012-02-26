/**
    STCompiledMethod.m
 
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

#import "STCompiledMethod.h"

#import "STMessage.h"
#import "STBytecodes.h"

#import <StepTalk/STMethod.h>
#import <StepTalk/STScripting.h>

#import <Foundation/NSArray.h>
#import <Foundation/NSCoder.h>
#import <Foundation/NSData.h>
#import <Foundation/NSString.h>

@implementation STCompiledMethod
+ methodWithCode:(STCompiledCode *)code messagePattern:(STMessage *)pattern
{
    STCompiledMethod *method;
    
    method = [STCompiledMethod alloc];
    
    [method    initWithSelector:[pattern selector]
                  argumentCount:[[pattern arguments] count]
                  bytecodesData:[[code bytecodes] data]
                       literals:[code literals]
               temporariesCount:[code temporariesCount]
                      stackSize:[code stackSize]
                namedReferences:[code namedReferences]];
               

    return AUTORELEASE(method);
}

-   initWithSelector:(NSString *)sel
       argumentCount:(unsigned)aCount
       bytecodesData:(NSData *)data
            literals:(NSArray *)anArray
    temporariesCount:(unsigned)tCount
           stackSize:(unsigned)size
     namedReferences:(NSMutableArray *)refs;
{
    self = [super initWithBytecodesData:data
                               literals:anArray
                       temporariesCount:tCount
                              stackSize:size
                        namedReferences:refs];

    selector = RETAIN(sel);
    argCount = aCount;
    
    return self;
}
- (void)dealloc
{
    RELEASE(selector);
    [super dealloc];
}
- (NSString *)selector
{
    return selector;
}

- (unsigned)argumentCount
{
    return argCount;
}

- (NSString*)description
{
    NSMutableString *desc = [NSMutableString string];

    [desc appendFormat:@"%s:\n"
                       @"Selector = %@\n"
                       @"Literals Count = %i\n"
                       @"Literals = %@\n"
                       @"External References = %@\n"
                       @"Temporaries Count = %i\n"
                       @"Stack Size = %i\n"
                       @"Byte Codes = %@\n",
                       [self className],
                       selector,
                       [literals count],
                       [literals description],
                       [namedRefs description],
                       tempCount,
                       stackSize,
                       [bytecodes description]];

    return desc;
}

/* Script object method info */
- (NSString *)methodName
{
    return selector;
}
- (NSString *)languageName
{
    return @"Smalltalk";
}
- (void)encodeWithCoder:(NSCoder *)coder
{
    [super encodeWithCoder: coder];

    [coder encodeObject:selector];
    [coder encodeValueOfObjCType: @encode(short) at: &argCount];
}

- initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder: decoder];
    
    [decoder decodeValueOfObjCType: @encode(id) at: &selector];
    [decoder decodeValueOfObjCType: @encode(short) at: &argCount];

    return self;
}
- (NSString *)source
{
    return nil;
}
@end
