/**
    ObjectiveCRuntime.m
 
    Copyright (c) 2002 Free Software Foundation

    Written by: Stefan Urbanek 
    Date: 2002 Jun 10
 
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

#import "ObjectiveCRuntime.h"

#import "NSObject+additions.h"

#import <objc/objc-api.h>

#import <StepTalk/STObjCRuntime.h>
#import <StepTalk/STSelector.h>

#import <Foundation/NSArray.h>
#import <Foundation/NSString.h>

static ObjectiveCRuntime *sharedRuntime=nil;

@implementation ObjectiveCRuntime
+ sharedRuntime
{
    if(!sharedRuntime)
    {
        sharedRuntime = [[ObjectiveCRuntime alloc] init];
    }
    return sharedRuntime;
}

- (NSArray *)allClasses
{
    NSMutableArray *array;
    Class           class;
    void           *state = NULL;

    array = [NSMutableArray array];

    while( (class = objc_next_class(&state)) )
    {
        [array addObject:class];
    }
    
    return [NSArray arrayWithArray:array];
}

- (Class )classWithName:(NSString *)string
{
    return NSClassFromString(string);
}

- (NSString *)nameOfClass:(Class)class
{
    return NSStringFromClass(class);
}
- (NSArray *)selectorsContainingString:(NSString *)string
{
    NSMutableArray *sels = [NSMutableArray array];
    NSEnumerator   *enumerator;
    NSArray        *array = STAllObjectiveCSelectors();
    NSString       *sel;
    NSRange         range;

    enumerator = [array objectEnumerator];
    
    while( (sel = [enumerator nextObject]) )
    {
        range = [sel rangeOfString:string];
        
        if(range.location != NSNotFound)
        {
            [sels addObject:sel];
        }
    }

    return [NSArray arrayWithArray:sels];
}

- (NSArray *)implementorsOfSelector:(id)selector
{
    NSMutableArray *array = [NSMutableArray array];
    NSEnumerator   *enumerator;
    NSDictionary   *classes = STAllObjectiveCClasses();
    NSString       *className;
    NSArray        *methods;
    Class           class;
    
    enumerator = [classes keyEnumerator];
    if([selector isKindOfClass:[STSelector class]])
    {
        selector = [selector stringValue];
    }
    
    while( (className = [enumerator nextObject]) )
    {
        class = [classes objectForKey:className];
        if([class respondsToSelector:@selector(instanceMethodNames)])
        {
            methods = [class instanceMethodNames];
            if([methods containsObject:selector])
            {
                [array addObject:className];
            }
        }
    }
    
    return [NSArray arrayWithArray:array];
}
@end


