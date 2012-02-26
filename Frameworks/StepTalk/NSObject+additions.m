/**
    NSObject-additions.m
    Various methods for NSObject
 
    Copyright (c) 2002 Free Software Foundation
 
    This file is part of the StepTalk project.
 
 */

#import "NSObject+additions.h"

@implementation NSObject (STAdditions)
- (BOOL)isSame:(id)anObject
{
    return self == anObject;
}
- (BOOL)isNil
{
    return NO;
}
- (BOOL)notNil
{
    return YES;
}
@end

