/**
    STSmalltalkScriptObject.m
    Object that represents script 
 
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

#import "STSmalltalkScriptObject.h"

#import "STBytecodeInterpreter.h"
#import "STCompiledScript.h"

#import <Foundation/NSArray.h>
#import <Foundation/NSDebug.h>
#import <Foundation/NSMethodSignature.h>
#import <Foundation/NSString.h>
#import <Foundation/NSAutoreleasePool.h>

#import <StepTalk/NSInvocation+additions.h>
#import <StepTalk/STEnvironment.h>
#import <StepTalk/STObjCRuntime.h>
#import <StepTalk/STExterns.h>

@implementation STSmalltalkScriptObject
- initWithEnvironment:(STEnvironment *)env
       compiledScript:(STCompiledScript *)compiledScript
{
    NSEnumerator *enumerator;
    NSString     *varName;

    [super init];

    NSDebugLLog(@"STEngine",
                @"creating script object %p with ivars %@",compiledScript,
                [compiledScript variableNames]);
                
    environment = RETAIN(env);
    script = RETAIN(compiledScript);
    variables = [[NSMutableDictionary alloc] init];

    enumerator = [[compiledScript variableNames] objectEnumerator];

    while( (varName = [enumerator nextObject]) )
    {
        [variables setObject:STNil forKey:varName];
    }
    
    return self;
}
- (void)dealloc
{
    RELEASE(interpreter);
    RELEASE(script);
    RELEASE(variables);
    RELEASE(environment);
    
    [super dealloc];
}
- (STCompiledScript *)script
{
    return script;
}
- (void)setValue:(id)value forKey:(NSString *)key
{
    if(value == nil)
    {
        value = STNil;
    }

    /* FIXME: check this for potential abuse and for speed improvements */    
    if([variables objectForKey:key])
    {
        [variables setObject:value forKey:key];
    }
    else
    {
        [super setValue:value forKey:key];
    }
}
- (id)valueForKey:(NSString *)key
{
    id value = [variables objectForKey:key];

    if(value)
    {
        return value;
    }
    else
    {
        return [super valueForKey:key];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    NSDebugLLog(@"STSending",
                @"?? script object responds to %@",
                NSStringFromSelector(aSelector));
    
    if( [super respondsToSelector:(SEL)aSelector] )
    {
        return YES;
    }
    
    return ([script methodWithName:NSStringFromSelector(aSelector)] != nil);
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

- (void) forwardInvocation:(NSInvocation *)invocation
{
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    STCompiledMethod  *method;
    NSString          *methodName = NSStringFromSelector([invocation selector]);
    NSMutableArray    *args;
    id                arg;
    int               index;
    int               count;
    id                retval = nil;

    if(!interpreter)
    {
        NSDebugLLog(@"STEngine",
                   @"creating new interpreter for script '%@'",
                   name);
        interpreter = [[STBytecodeInterpreter alloc] initWithEnvironment:environment];

    }
    

    if([methodName isEqualToString:@"exit"])
    {
        [interpreter halt];
        return;
    }

    method = [script methodWithName:methodName];
    
    count = [[invocation methodSignature] numberOfArguments];

    NSDebugLLog(@"STSending",
                @"script object perform: %@ with %i args",
                methodName,count-2);

    args = [[NSMutableArray alloc] init];
    
    for(index = 2; index < count; index++)
    {
        arg = [invocation getArgumentAsObjectAtIndex:index];

        if (arg == nil)
        {
            [args addObject:STNil];
        }
        else 
        {
            [args addObject:arg];
        }
    }

    // NSDebugLLog(@"STSending",
    //            @">> forwarding to self ...");

    retval = [interpreter interpretMethod:method 
                              forReceiver:self
                                arguments:args];
    RELEASE(args);
    
    // NSDebugLLog(@"STSending",
    //            @"<< returned from forwarding");

    [invocation setReturnValue:&retval];
    [pool release];
}
@end
