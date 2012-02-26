/**
    STCompiledCode.m
 
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

#import "STCompiledCode.h"
#import "STBytecodes.h"

#import <Foundation/NSObject.h>
#import <Foundation/NSData.h>
#import <Foundation/NSArray.h>
#import <Foundation/NSCoder.h>

@implementation STCompiledCode
- initWithBytecodesData:(NSData *)data
               literals:(NSArray *)anArray
       temporariesCount:(unsigned)count
              stackSize:(unsigned)size
        namedReferences:(NSMutableArray *)refs
{
    [super init];

    bytecodes = [[STBytecodes alloc] initWithData:data];
    literals = [[NSArray alloc] initWithArray:anArray];
    tempCount = count;
    stackSize = size;
    namedRefs = [[NSArray alloc] initWithArray:refs];
    return self;
}
- (void)dealloc
{
    RELEASE(bytecodes);
    RELEASE(literals);
    RELEASE(namedRefs);
    [super dealloc];
}
- (STBytecodes *)bytecodes
{
    return bytecodes;
}

- (unsigned)temporariesCount
{
    return tempCount;
}
- (unsigned)stackSize
{
    return stackSize;
}
- (NSArray *)literals
{
    return literals;
}
- (id)literalObjectAtIndex:(unsigned)index
{
    return [literals objectAtIndex:index];
}

- (NSMutableArray *)namedReferences
{
    return namedRefs;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    // [super encodeWithCoder: coder];

    [coder encodeObject:bytecodes];
    [coder encodeObject:literals];
    [coder encodeObject:namedRefs];
    [coder encodeValueOfObjCType: @encode(short) at: &tempCount];
    [coder encodeValueOfObjCType: @encode(short) at: &stackSize];
}

- initWithCoder:(NSCoder *)decoder
{
    self = [super init]; // [super initWithCoder: decoder];
    
    [decoder decodeValueOfObjCType: @encode(id) at: &bytecodes];
    [decoder decodeValueOfObjCType: @encode(id) at: &literals];
    [decoder decodeValueOfObjCType: @encode(id) at: &namedRefs];
    [decoder decodeValueOfObjCType: @encode(short) at: &tempCount];
    [decoder decodeValueOfObjCType: @encode(short) at: &stackSize];

    return self;
}

@end
