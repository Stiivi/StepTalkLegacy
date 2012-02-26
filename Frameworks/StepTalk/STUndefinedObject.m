/**
    STUndefinedObject.m
    Wrapper for nil object
 
    Copyright (c) 2002 Free Software Foundation
 
    Written by: Stefan Urbanek <urbanek@host.sk>
    Date: 2000
   
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
#import "STUndefinedObject.h"

#import "STExterns.h"
#import "STObjCRuntime.h"

#import <Foundation/NSString.h>

STUndefinedObject *STNil = nil;

@implementation STUndefinedObject
+ (id) alloc
{
    return STNil;
}

+ (id) allocWithZone: (NSZone*)z
{
    return STNil;
}

+ (id) autorelease
{
    return self;
}

- (void) dealloc
{
    NSLog(@"Warning: Trying to dealloc STNil object");
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    NSMethodSignature *signature = nil;
    
    signature = [super methodSignatureForSelector:sel];

    if(!signature)
    {
        signature = STConstructMethodSignatureForSelector(sel);
    }

    return signature;
}

- (void) forwardInvocation: (NSInvocation*)anInvocation
{
    /* this object is deaf */
}

- (BOOL) isEqual: (id)anObject
{
    return ( (self == anObject) || (anObject == nil) );
}

- (void) release
{
    /* do nothing */
}

- (id) retain
{
    return self;
}

- (BOOL)isNil
{
    return YES;
}

- (BOOL)notNil
{
    return NO;
}
@end

