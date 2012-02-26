/**
    stexec.m
    Script executor
 
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
#import "STExecutor.h"

#import <StepTalk/StepTalk.h>

#import <Foundation/NSArray.h>
#import <Foundation/NSAutoreleasePool.h>
#import <Foundation/NSDebug.h>
#import <Foundation/NSDictionary.h>
#import <Foundation/NSException.h>
#import <Foundation/NSProcessInfo.h>
#import <Foundation/NSString.h>

#include <stdio.h>

@interface Executor:STExecutor
{
    NSString       *typeName;
    NSString       *environmentName;
    NSString       *hostName;
    BOOL            enableFull;
}
@end

@implementation Executor
- (void)createConversation
{
    STEnvironmentDescription *desc;
    STEnvironment            *environment;
    
    if(environmentName)
    {
        /* user wants to connect to a distant environment */
        conversation = [[STRemoteConversation alloc]
                                    initWithEnvironmentName:environmentName
                                                       host:hostName
                                                   language:langName];
        if(!conversation)
        {
            NSLog(@"Unable to connect to %@@%@", environmentName, hostName);
            return;
        }
    }
    else
    {
        /* User wants local temporary environment */
        if(!typeName || [typeName isEqualToString:@""])
        {
            environment = [STEnvironment environmentWithDefaultDescription];
        }
        else
        {
            desc = [STEnvironmentDescription descriptionWithName:typeName];
            environment = [STEnvironment environmentWithDescription:desc];
        }

        /* Register basic objects: Environment, Transcript */

        [environment setObject:environment forName:@"Environment"];
        [environment loadModule:@"SimpleTranscript"];
        [environment setCreatesUnknownObjects:YES];

        /* FIXME: remove this or use some command-line flag */
        [environment setFullScriptingEnabled:enableFull];
        conversation = [[STConversation alloc] initWithContext:environment
                                                      language:langName];
    }
}
- (void)dealloc
{
    RELEASE(typeName);
    RELEASE(environmentName);
    RELEASE(hostName);
    
    [super dealloc];
}
- (int)processOption:(NSString *)option
{
    if ([@"type" hasPrefix:option])
    {
        ASSIGN(typeName, [self nextArgument]);
        if(!typeName)
        {
            [NSException raise:STExecutorException
                        format:@"Environment description (type) name expected"];
        }
    }
    else if ([@"environment" hasPrefix:option])
    {
        ASSIGN(environmentName,[self nextArgument]);
        if(!environmentName)
        {
            [NSException raise:STExecutorException
                        format:@"Environment name expected"];
        }
    }
    else if ([@"host" hasPrefix:option])
    {
        ASSIGN(hostName,[self nextArgument]);
        if(!hostName)
        {
            [NSException raise:STExecutorException
                        format:@"Host name expected"];
        }
    }
    else if ([@"full" hasPrefix:option])
    {
        enableFull = YES;
    }
    else
    {
         [NSException raise:STExecutorException
                     format:@"Unknown option -%@", option];
    }
    return 0;
}

- (void)beforeExecuting
{
}

- (void) printHelp
{
    printf(
"stexec - execute StepTalk script (in GNUstep-base environment)\n"
"Usage: stexec [options] [script] [args ...] [ , script ...]\n"
"   Options:\n"
"%s"
"   -full               enable full scripting\n"
"   -environment env    use scripting environment with name env\n"
"   -host host          find environment on host\n"
"   -type desc          use environment description with name 'desc'\n"
"\n"
"Notes:\n"
"- if -environment is used, then -type is ignored"
"- if no script is specified, standard input is used without arguments\n"
"- if script name is '-' then standard input is used and arguments are passed"
" to the script\n",
STExecutorCommonOptions
    );
}
@end

int main(int argc, const char **argv)
{	
    Executor          *executor;
    NSArray           *args;
    NSAutoreleasePool *pool;
    NSProcessInfo     *procInfo;

    pool = [NSAutoreleasePool new];

//    [NSAutoreleasePool enableDoubleReleaseCheck:YES];

    procInfo = [NSProcessInfo processInfo];

    if (procInfo == nil)
    {
        NSLog(@"Unable to get process information");
        RELEASE(pool);
        exit(1);
    }

//GSDebugAllocationActive(YES);
    executor = [[Executor alloc] init];

    args = [procInfo arguments];
    [executor runWithArguments:args];
    
    RELEASE(executor);
//printf("%s\n",GSDebugAllocationList(NO));
    RELEASE(pool);

    return 0;
}
