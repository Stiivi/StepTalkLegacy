/**
    STCompiledCode.h
 
    Copyright (c) 2002 Free Software Foundation
 
    This file is part of the StepTalk.
 
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

@class NSData;
@class NSArray;
@class NSMutableArray;
@class STBytecodes;

@interface STCompiledCode:NSObject<NSCoding>
{
    STBytecodes        *bytecodes;
    NSArray            *literals;
    NSMutableArray     *namedRefs;
    short               tempCount;
    short               stackSize;
}
- initWithBytecodesData:(NSData *)data
               literals:(NSArray *)anArray
       temporariesCount:(unsigned)count
              stackSize:(unsigned)size
        namedReferences:(NSMutableArray *)refs;

- (STBytecodes *)bytecodes;
- (unsigned)temporariesCount;
- (unsigned)stackSize;
- (id)literalObjectAtIndex:(unsigned)index;
- (NSMutableArray *)namedReferences;
- (NSArray *)literals;
@end
