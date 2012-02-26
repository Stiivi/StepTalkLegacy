/**
    STBytecodeInterpreter.h
 
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

@class STCompiledMethod;
@class STCompiledCode;
@class STBytecodes;
@class STExecutionContext;
@class STStack;
@class STEnvironment;

@class NSArray;
@class NSMutableArray;
@class NSMutableDictionary;

@interface STBytecodeInterpreter:NSObject
{
    STEnvironment      *environment;    /* scripting environment */

    STExecutionContext *activeContext;       /* current execution context */
    STStack            *stack;               /* from context */
    STBytecodes        *bytecodes;           /* from context */
    unsigned            instructionPointer;  /* IP  */
    id                  receiver;

    int                 entry;

    BOOL                stopRequested;
}

+ interpreterWithEnvrionment:(STEnvironment *)env;
- initWithEnvironment:(STEnvironment *)env;

- (void)setEnvironment:(STEnvironment *)env;

- (id)interpretMethod:(STCompiledMethod *)method 
          forReceiver:(id)anObject
            arguments:(NSArray*)args;

- (void)setContext:(STExecutionContext *)context;
- (STExecutionContext *)context;

- (id)interpret;
- (void)halt;
@end
