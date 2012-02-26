/**
    STScripting.m
    Scripting protocol
   
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
  
    <title>STScripting protocol documentation</title>
  
  */

#import "STScripting.h"

@implementation NSObject (STScripting)
/*
- (id)replacementForScriptingInEnvironment:(STEnvironment *)env
{
    return self;
}
*/
- (BOOL)isClass
{
    return NO;
}
+ (BOOL)isClass
{
    return YES;
}

+ (NSString *)className
{
    return NSStringFromClass(self);
}
- (NSString *)className
{
    return [[self class] className];
}

/*Subclasses should override this method to force use of another class */
- (Class) classForScripting
{
    return [self class];
}
+ (Class) classForScripting
{
    return [self class];
}
@end
