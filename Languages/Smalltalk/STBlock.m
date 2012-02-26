/**
    STBlock.m
    Wrapper for STBlockContext to make it invisible from the user  
 
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


#import "STBlock.h"
#import "STLiterals.h"
#import "STBlockContext.h"
#import "STBytecodeInterpreter.h"
#import "STStack.h"

#import <StepTalk/STExterns.h>

#import <Foundation/NSArray.h>
#import <Foundation/NSDebug.h>
#import <Foundation/NSException.h>

Class STBlockContextClass = nil;

@implementation STBlock
+ (void)initialize
{
    STBlockContextClass = [STBlockContext class];
}
- initWithInterpreter:(STBytecodeInterpreter *)anInterpreter
          homeContext:(STMethodContext *)context
            initialIP:(unsigned)ptr
        argumentCount:(int)count
            stackSize:(int)size
{
    homeContext = context;
    argCount  = count; 
    stackSize = size;
    initialIP = ptr;
    interpreter = anInterpreter;
    
    return [super init];
}

- (unsigned)argumentCount
{
    return argCount;
}

- value
{
    if(argCount != 0)
    {
        [NSException  raise:STScriptingException
                     format:@"Block needs %i arguments", argCount];
        return nil;
    }
    return [self valueWithArgs:(id*)0 count:0];
}

- valueWith:arg
{
    id  args[1] = {arg};
    id  retval;

    retval = [self valueWithArgs:args count:1];
    return retval;
}

- valueWith:arg1 with:arg2
{
    id  args[2] = {arg1,arg2};
    id  retval;

    retval = [self valueWithArgs:args count:2];
    return retval;
}

- valueWith:arg1 with:arg2 with:arg3
{
    id  args[3] = {arg1,arg2,arg3};
    id  retval;

    retval = [self valueWithArgs:args count:3];
    return retval;
}

- valueWith:arg1 with:arg2 with:arg3 with:arg4
{
    id  args[4] = {arg1,arg2,arg3,arg4};
    id  retval;

    retval = [self valueWithArgs:args count:4];
    return retval;
}

- valueWithArgs:(id *)args count:(unsigned)count;
{
    STExecutionContext *parentContext;
    STBlockContext     *context;
    STStack            *stack;
    unsigned int        i;
    id                  retval;

    if(argCount != count)
    {
        [NSException raise:STScriptingException
                    format:@"Invalid block argument count %i, " 
                           @"wants to be %i", count, argCount];
        return nil;
    }

    if(!usingCachedContext)
    {
        /* In case of recursive block nesting */
        usingCachedContext = YES;

        if(!cachedContext)
        {
            cachedContext = [[STBlockContextClass alloc] 
                                    initWithInterpreter:interpreter
                                              initialIP:initialIP
                                              stackSize:stackSize];
        }

        /* Avoid allocation */
        context = cachedContext;
        [[context stack] empty];
        [context resetInstructionPointer];
    }
    else
    {
        /* Create new context */
        context = [[STBlockContextClass alloc] initWithInterpreter:interpreter
                                                         initialIP:initialIP
                                                         stackSize:stackSize];

        AUTORELEASE(context);
    }

    /* push block arguments to the stack */
    
    stack = [context stack];
    for(i = 0; i<count; i++)
    {
        [stack push:args[i]];
    }

    [context setHomeContext:homeContext];

    parentContext = [interpreter context];

    [interpreter setContext:context];
    retval = [interpreter interpret];
    [interpreter setContext:parentContext];

    /* Release cached context */
    if(usingCachedContext)
    {
        usingCachedContext = NO;
    }

    return retval;
}

- handler:(STBlock *)handlerBlock
{
    STExecutionContext *context;
    id                  retval;

    /* save the execution context for the case of exception */
    context = [interpreter context];

    NS_DURING
        retval = [self value];
    NS_HANDLER
        retval = [handlerBlock valueWith:localException];
        /* restore the execution context */
        [interpreter setContext:context];
    NS_ENDHANDLER

    return retval;
}

- whileTrue:(STBlock *)doBlock
{
    id retval = nil;
    
    while([[self value] boolValue])
    {
        retval = [doBlock value];
    }
    return retval;
}

- whileFalse:(STBlock *)doBlock
{
    id retval = nil;
    
    while(! [[self value] boolValue])
    {
        retval = [doBlock value];
    }
    return retval;
}
@end
