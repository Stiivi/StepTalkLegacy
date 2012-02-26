/**
    STLiterals.h
    Literal objects
 
    Copyright (c) 2002 Free Software Foundation
 
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

#import "STLiterals.h"

#import <Foundation/NSString.h>

@implementation STLiteral
@end

@implementation STObjectReferenceLiteral
- initWithObjectName:(NSString *)anObject poolName:(NSString *)aPool
{
    objectName = RETAIN(anObject);
    poolName = RETAIN(aPool);
    return [super init];
}
#if 0
- copyWithZone:(NSZone *)zone
{
    STObjectReferenceLiteral *copy = [super copyWithZone:zone];
    return copy;
}
#endif
- (void)dealloc
{
    RELEASE(objectName);
    RELEASE(poolName);
    [super dealloc];
}
- (NSString *)poolName
{
    return poolName;
}
- (NSString *)objectName
{
    return objectName;
}
- (NSString *)description
{
    return [NSMutableString stringWithFormat:
                @"STObjectReferenceLiteral { object '%@', pool '%@' }",
                objectName,poolName];
}
@end

@implementation STBlockLiteral
- initWithArgumentCount:(unsigned)count
{
    argCount = count;
    return [super init];
}
- (void)setStackSize:(unsigned)size
{
    stackSize = size;
}
- (unsigned)argumentCount
{
    return argCount;
}
- (unsigned)stackSize
{
    return stackSize;
}
@end

