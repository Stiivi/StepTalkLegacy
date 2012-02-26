/**
    STStack.h
    Stack object
 
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

#import <Foundation/NSObject.h>

@interface STStack:NSObject
{
    unsigned  size;
    unsigned  pointer;
    id       *stack;
}
+ stackWithSize:(unsigned)newSize;
- initWithSize:(unsigned)newSize;

- (void)push:anObject;
- (id)  pop;
- (void)popCount:(unsigned)count;
- (id)  valueAtTop;
- (id)  valueFromTop:(unsigned)offset;

- (void)duplicateTop;

- (void)empty;
@end
