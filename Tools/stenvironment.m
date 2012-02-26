/**
    stenvironment.m
    Scripting environment process
 
    Copyright (c) 2005 Free Software Foundation
 
    Written by: Stefan Urbanek <urbanek@host.sk>
    Date: 2005-08
   
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
#import "STEnvironmentProcess.h"

#import <StepTalk/StepTalk.h>

#import <Foundation/NSAutoreleasePool.h>
#import <Foundation/NSConnection.h>
#import <Foundation/NSDistributedNotificationCenter.h>
#import <Foundation/NSException.h>
#import <Foundation/NSProcessInfo.h>
#import <Foundation/NSUserDefaults.h>

#include <stdio.h>

const int MAX_SEQUENCES = 100; /* Maximal number of environment sequence numbers */

void print_help(void)
{
    printf(
"stenvironment - create StepTalk environment process\n"
"Usage: stenvironment [options]\n"
"   Options:\n"
"   -name name          set name of environment\n"
"   -type env           use scripting environment description with name 'env'\n"
"   -observer name      observer 'name' will receive notification\n"
"\n"
"Notes:\n"
"- DO server will be created with name 'STEnvironment:name'\n"
"- if no name is given then 'UnnamedNN' will be created, where NN is sequence\n"
"- observer is a distributed notification observer\n"
"\n"
    );
}

int main(int argc, const char **argv)
{	
    NSNotificationCenter *dnc;
    STEnvironmentProcess *envprocess;
    NSAutoreleasePool  *pool;
    NSUserDefaults     *defs;
    NSString           *envIdentifier;
    NSString           *observerIdentifier;
    BOOL                isRegistered = NO;
    int                 sequence = 0;
    NSConnection       *connection;
    NSDictionary       *dict;
    NSString           *serverName;
    NSArray            *args;
    NSString           *str;
    NSString           *descriptionName;
    
    pool = [NSAutoreleasePool new];

    args = [[NSProcessInfo processInfo] arguments];
    
    if([args count] >= 2)
    {
        str = [args objectAtIndex:1];
        if([str isEqualToString:@"-h"]
            || [str isEqualToString:@"--h"]
            || [str isEqualToString:@"-help"]
            || [str isEqualToString:@"--help"])
        {
            print_help();
            RELEASE(pool);
            exit(0);
        }
    }
//    [NSAutoreleasePool enableDoubleReleaseCheck:YES];

    defs = [NSUserDefaults standardUserDefaults];

    observerIdentifier = [defs objectForKey:@"observer"];
    envIdentifier   = [defs objectForKey:@"name"];
    descriptionName   = [defs objectForKey:@"type"];

    /* FIXME: use environment description name */
    envprocess = [[STEnvironmentProcess alloc] 
                            initWithDescriptionName:descriptionName];

    /* Register environment */
    
    connection = RETAIN([NSConnection defaultConnection]);
    [connection setRootObject:envprocess];

    if(!envIdentifier)
    {
        for(sequence = 0; sequence < MAX_SEQUENCES; sequence++)
        {
            envIdentifier = [NSString stringWithFormat:@"Unnamed%i", sequence];
            serverName = [NSString stringWithFormat:@"STEnvironment:%@", envIdentifier];
            NSLog(@"Trying to register environment with name '%@'", envIdentifier);

            if([connection registerName:serverName])
            {
                isRegistered = YES;
            }
 
            if(isRegistered)
            {
                break;
            }              
        }
    }
    else
    {
        serverName = [NSString stringWithFormat:@"STEnvironment:%@", envIdentifier];
        if([connection registerName:serverName])
        {
            isRegistered = YES;
        }
        else
        {
            NSLog(@"Unable to register '%@'", serverName);
        }
    }
    
    /* Finish */
    
    if(isRegistered)
    {
        NSLog(@"Environment : '%@'", envIdentifier);
        NSLog(@"DO Server   : '%@'", serverName);
        
        if(observerIdentifier)
        {
            NSLog(@"Notifying   : '%@'", observerIdentifier);
            dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                        envIdentifier, @"STDistantEnvironmentName",
                                        nil, nil];

            dnc = [NSDistributedNotificationCenter defaultCenter];
            [dnc postNotificationName:@"STDistantEnvironmentConnectNotification"
                               object:observerIdentifier
                             userInfo:dict];
                         
        }
        [[NSRunLoop currentRunLoop] run];
                                        
        NSLog(@"Terminating environment process %@", envIdentifier);
    }
    else
    {
        NSLog(@"Unable to register environment '%@'.", envIdentifier);
    }
    
    RELEASE(pool);

    return 0;
}
