/**
    stalk.m
    Program for 'talking' to scriptable objects
 
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
#import <Foundation/NSConnection.h>
#import <Foundation/NSDebug.h>
#import <Foundation/NSDictionary.h>
#import <Foundation/NSEnumerator.h>
#import <Foundation/NSException.h>
#import <Foundation/NSProcessInfo.h>
#import <Foundation/NSString.h>
#import <Foundation/NSFileManager.h>

@interface NSObject (STPrivateMethodDeclarations)
- (STEnvironment *)scriptingEnvironment;
@end

@interface Executor:STExecutor
{
    NSString      *hostName;
    NSString      *objectName;
    
    id             target;
}
- (void)setTargetWithName:(NSString *)name;
@end

@implementation Executor
- (void)dealloc
{
    RELEASE(objectName);
    RELEASE(hostName);
    [super dealloc];
}
- (void)setTargetWithName:(NSString *)targetName
{
    NSDebugLog(@"connecting object '%@' on host '%@'",targetName,hostName);
    
    if(!targetName)
    {
        [NSException raise:STExecutorException
                    format:@"No target specified"];
    }

    target = [NSConnection rootProxyForConnectionWithRegisteredName:targetName
                                                               host:hostName];
/*
    [[NSNotificationCenter defaultCenter] 
            addObserver:self
               selector:@selector(connectionDidDie:)
                   name:NSConnectionDidDieNotification
                 object:object];
*/

    if(!target)
    {
        [NSException raise:STExecutorException
                    format:@"Unable to connect to target named '%@' "
                           @"on host '%@'",
                           targetName, hostName];
        return;
    }
    
    ASSIGN(objectName,targetName);
}

/* FIXME: This definitely needs to be rewritten. It is a quick hack 
    after moving from STEngnie to STConversation */
- (void)createConversation
{
    STEnvironment            *env;

    if([target respondsToSelector:@selector(scriptingEnvironment)])
    {
        env = [target scriptingEnvironment];
    }
    else
    {
        [NSException raise:STExecutorException
                    format:@"Target '%@' on host '%@' "
                           @"does not provide scripting environment.",
                           objectName, hostName];
        return;
    }
          
    RETAIN(env);

    [env setObject:target forName:objectName];

    conversation = [[STConversation alloc] initWithContext:env
                                                      language:nil];
}

- (int)processOption:(NSString *)option
{
    if ([@"host" hasPrefix:option])
    {
        ASSIGN(hostName,[self nextArgument]);
        
        if(!hostName)
        {
            [NSException raise:STExecutorException
                        format:@"Hostname expected"];
        }
    }
    else
    {
        [NSException raise:STExecutorException
                    format:@"Unknown option -%@", option];
    }

    return NO;
}

-(void) beforeExecuting
{
    [self setTargetWithName:[self nextArgument]];
}

- (void)printHelp
{
    printf(
"stalk - 'talk' to objects with StepTalk script\n"
"Usage: stalk [options] target script [args ...] [ , script ...]\n"
"   Options:\n"
"%s"
"   -host hostName    look for target on specified host\n",
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

    procInfo = [NSProcessInfo processInfo];
    if (procInfo == nil)
    {
        NSLog(@"Unable to get process information");
        [pool release];
        exit(1);
    }

    executor = [[Executor alloc] init];

    args = [procInfo arguments];
    NSLog(@"Warning: This tool is obsolete.");
    [executor runWithArguments:args];

    [pool release];

    return 0;
}
