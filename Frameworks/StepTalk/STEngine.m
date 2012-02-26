/**
    STEngine.m
    Scripting engine
 
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

#import "STEngine.h"

#import "STEnvironment.h"
#import "STExterns.h"
#import "STFunctions.h"
#import "STLanguageManager.h"
#import "STMethod.h"
#import "STUndefinedObject.h"

#import <Foundation/NSDictionary.h>
#import <Foundation/NSException.h>
#import <Foundation/NSString.h>
#import <Foundation/NSZone.h>

NSZone *STMallocZone = (NSZone *)nil;

void _STInitMallocZone(void)
{
    if(!STMallocZone)
    {
        /* FIXME: do some testing whether there should be YES or NO */
        STMallocZone = NSCreateZone(NSPageSize(),NSPageSize(),YES);
    }
}

@implementation STEngine
+ (void)initialize
{
    _STInitMallocZone();

    if(!STNil)
    {
        STNil = (STUndefinedObject *)NSAllocateObject([STUndefinedObject class],
                                                      0, STMallocZone);
    }
}

/**
    Return a scripting engine for language with specified name. The engine
    is get from default language manager.
*/
+ (STEngine *) engineForLanguage:(NSString *)name
{
    STLanguageManager *manager = [STLanguageManager defaultManager];
    
    if(!name)
    {
        [NSException raise:@"STConversationException"
                     format:@"Unspecified language for a new engine."];
        return nil;
    }
    
    return [manager createEngineForLanguage:name];
}

+ (STEngine *) engineForLanguageWithName:(NSString *)name
{
    NSLog(@"%@ %@ is depreciated, use %@ instead",
            [self className], NSStringFromSelector(_cmd), @"engineForLanguage:");

    return [self engineForLanguage:name];
}

/** Interpret source code <var>code</var> in a context <var>context</var>. 
    This is the method, that has to be implemented by those who are writing 
    a language engine. 
    <override-subclass /> 
*/
- (id)interpretScript:(NSString *)script
            inContext:(STContext *)context
{
    [self subclassResponsibility:_cmd];

    return nil;
}

- (BOOL)understandsCode:(NSString *)code 
{
    [self subclassResponsibility:_cmd];

    return NO;
}

- (STMethod *)methodFromSource:(NSString *)sourceString
                   forReceiver:(id)receiver
        inContext:(STContext *)env;
{
    [self subclassResponsibility:_cmd];
    return nil;
}
- (id)  executeMethod:(id <STMethod>)aMethod
          forReceiver:(id)anObject
        withArguments:(NSArray *)args
        inContext:(STContext *)env;
{
    [self subclassResponsibility:_cmd];
    return nil;
}
@end
