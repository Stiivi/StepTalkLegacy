/**
    STClassInfo.m
    Objective-C class wrapper
 
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

#import "STClassInfo.h"

#import "STFunctions.h"

#import <Foundation/NSDictionary.h>
#import <Foundation/NSDebug.h>
#import <Foundation/NSSet.h>
#import <Foundation/NSString.h>
#import <Foundation/NSValue.h>

@implementation STClassInfo
- initWithName:(NSString *)aString

{
    [super initWithName:aString];
    
    selectorCache = [[NSMutableDictionary alloc] init];
    
    return self;
}

- (void)dealloc
{
    RELEASE(selectorCache);
    [super dealloc];
}   

- (void)setSuperclassInfo:(STClassInfo *)classInfo
{
    ASSIGN(superclass,classInfo);
}

- (STClassInfo *)superclassInfo
{
    return superclass;
}
- (void) setSuperclassName:(NSString *)aString
{
    ASSIGN(superclassName,aString);
}
- (NSString *)superclassName
{
    return superclassName;
}

- (NSString *)translationForSelector:(NSString *)aString
{

    NSString *sel;
    
    NSDebugLLog(@"STSending",@"Translate '%@' in %@:%@. (%i)", 
                aString, [self behaviourName],superclassName, allowAll);
    
    sel = [selectorCache objectForKey:aString];

    if(sel)
    {
        return sel;
    }

    sel = [selectorMap objectForKey:aString];

    if(!sel)
    {
        /* Lookup for super selector maping */
        if(superclass)
        {
            sel = [superclass translationForSelector:aString];

            if(sel && 
                ([denyMethods containsObject:sel] ||
                (!allowAll && ![allowMethods containsObject:sel])))
            {
                sel = nil;
            }
            else if([allowMethods containsObject:aString])
            {
                sel = aString;
            }
        }
        else if(allowAll || [allowMethods containsObject:aString])
        {
            sel = aString;
        }

        NSDebugLLog(@"STSending",@"   translated '%@' deny %i allow %i all %i",
                   sel, [denyMethods containsObject:sel],
                   [allowMethods containsObject:sel],
                   allowAll);

    }
    
    NSDebugLLog(@"STSending",@"    Return '%@' (%@)", 
                sel, [self behaviourName]);
    if(sel)
    {
        [selectorCache setObject:sel forKey:aString];
    }
    
    return sel;
}

- (void)setAllowAllMethods:(BOOL)flag
{
    allowAll = flag;
}

- (BOOL)allowAllMethods
{
    return allowAll;
}
@end

