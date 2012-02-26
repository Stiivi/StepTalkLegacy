/**
    STBehaviourInfo.m
 
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

#import "STBehaviourInfo.h"

#import <Foundation/NSArray.h>
#import <Foundation/NSDebug.h>
#import <Foundation/NSDictionary.h>
#import <Foundation/NSEnumerator.h>
#import <Foundation/NSSet.h>
#import <Foundation/NSString.h>
#import <Foundation/NSValue.h>

@implementation STBehaviourInfo
- initWithName:(NSString *)aString
{
    self = [super init];
    selectorMap = [[NSMutableDictionary alloc] init];
    allowMethods = [[NSMutableSet alloc] init];
    denyMethods = [[NSMutableSet alloc] init];
    
    name = RETAIN(aString);
    
    return self;
}

- (void)dealloc
{
    RELEASE(selectorMap);
    RELEASE(allowMethods);
    RELEASE(denyMethods);
    RELEASE(name);
    
    [super dealloc];
}

- (NSString*)behaviourName
{
    return name;
}

- (void)adopt:(STBehaviourInfo *)info
{
    [self addTranslationsFromDictionary:[info selectorMap]];
    [self allowMethods:[info allowedMethods]];
    [self denyMethods:[info deniedMethods]];
}

- (NSDictionary *)selectorMap
{
    return selectorMap;
}

- (void)removeTranslationForSelector:(NSString *)aString
{
    [selectorMap removeObjectForKey:aString];
}

- (void)setTranslation:(NSString *)translation
           forSelector:(NSString *)selector
{
    [selectorMap setObject:translation forKey:selector];
}

- (void)addMethodsFromArray:(NSArray *)methods
{
    NSEnumerator *enumerator;
    NSString     *sel;
    
    enumerator = [methods objectEnumerator];
    while( (sel = [enumerator nextObject]) )
    {
        [self setTranslation:sel forSelector:sel];
    }
}

- (void)addTranslationsFromDictionary:(NSDictionary *)map
{
    [selectorMap addEntriesFromDictionary:map];
}
- (void)allowMethods:(NSSet *)set
{
    [allowMethods unionSet:set];
    [denyMethods minusSet:allowMethods];
}

- (void)denyMethods:(NSSet *)set;
{
    [denyMethods unionSet:set];
    [allowMethods minusSet:denyMethods];
}

- (void)allowMethod:(NSString *)methodName;
{
    [allowMethods addObject:methodName];
    [denyMethods removeObject:methodName];
}

- (void)denyMethod:(NSString *)methodName;
{
    [denyMethods addObject:methodName];
    [allowMethods removeObject:methodName];
}

- (NSSet *)allowedMethods
{
    return AUTORELEASE([allowMethods copy]);
}

- (NSSet *)deniedMethods
{
    return AUTORELEASE([denyMethods copy]);
}
@end
