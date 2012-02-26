/**
    STDistributedFinder.m
    StepTalk simple transcript
 
    Copyright (c) 2002 Free Software Foundation
 
    Written by: Stefan Urbanek <urbanek@host.sk>
    Date:   2001 Apr 13
 
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

#import "STDistributedFinder.h"

#import <StepTalk/STFunctions.h>

#import <Foundation/NSArray.h>
#import <Foundation/NSConnection.h>
#import <Foundation/NSDebug.h>
#import <Foundation/NSDictionary.h>
#import <Foundation/NSEnumerator.h>
#import <Foundation/NSRunLoop.h>
#import <Foundation/NSString.h>
#import <Foundation/NSTask.h>
#import <Foundation/NSTimer.h>

static NSDictionary *STDOInfo(NSString *name)
{
    NSString     *file;

    file = STFindResource(name, @"DistributedObjects", @"plist");
    
    if(file)
    {
        return [NSDictionary dictionaryWithContentsOfFile:file];
    }
    
    return nil;
}

@implementation STDistributedFinder
- (id)connectDistantObjectWithName:(NSString *)name
{
    NSDictionary *dict = STDOInfo(name);
    NSEnumerator *enumerator;
    NSString     *host;
    id            obj;
    NSString     *distantName;
    
    distantName = [dict objectForKey:@"ObjectName"];

    if(!distantName || [distantName isEqualToString:@""])
    {
        distantName = name;
    }
    
    /* find object on host 'Host' */
    host = [dict objectForKey:@"Host"];

    NSDebugLLog(@"STFinder", @"Looking up '%@' at '%@'", distantName, host);
    obj = [NSConnection rootProxyForConnectionWithRegisteredName:distantName
                                                            host:host];
    if(obj)
    {
        return obj;
    }

    /* Lookup for object at specified hosts */
    enumerator = [[dict objectForKey:@"Hosts"] objectEnumerator];
    
    while( (host = [enumerator nextObject]) )
    {
        NSDebugLLog(@"STFinder", @"Looking up '%@' at '%@'", distantName, host);
        obj = [NSConnection rootProxyForConnectionWithRegisteredName:distantName
                                                                host:host];
        if(obj)
        {
            return obj;
        }
    }
    
    return nil;
}

- (id)objectWithName:(NSString *)name
{
    NSDictionary *dict = STDOInfo(name);
    NSString     *toolName = [dict objectForKey:@"Tool"];
    NSString     *delayStr;
    NSTask       *task;
    int           delay = 5; /* default delay */
    id            obj;

    obj = [self connectDistantObjectWithName:name];

    if(obj || !dict)
    {
        return obj;
    }
    

    if(!toolName || [toolName isEqualToString:@""])
    {
        return nil;
    }
    
    NSDebugLLog(@"STFinder", @"Launching '%@'", toolName);

    task = [NSTask launchedTaskWithLaunchPath:toolName
                                    arguments:[dict objectForKey:@"Arguments"]];
    

    delayStr = [dict objectForKey:@"Wait"];
    if(delayStr && ![delayStr isEqualToString:@""])
    {
        delay = [[dict objectForKey:@"Wait"] intValue];
    }

    if(!task)
    {
        NSLog(@"(StepTalk) Unable to launch task '%@'", toolName);
        return nil;
    }
    
    [NSTimer scheduledTimerWithTimeInterval: delay
                                 invocation: nil
                                    repeats: NO];
    [[NSRunLoop currentRunLoop] runUntilDate: 
                        [NSDate dateWithTimeIntervalSinceNow: delay]];

    
    return [self connectDistantObjectWithName:name];
}

- (NSArray *)knownObjectNames
{
    NSMutableArray *array = [NSMutableArray array];
    NSEnumerator   *enumerator;
    NSString       *name;
    NSString       *file;
    NSArray        *fileArray;
    
    fileArray = STFindAllResources(@"DistributedObjects", @"plist");
    
    enumerator = [fileArray objectEnumerator];
    
    while( (file = [enumerator nextObject]) )
    {
        name = [[file lastPathComponent] stringByDeletingPathExtension];
        [array addObject:name];
    }
    
    return [NSArray arrayWithArray:array];
}
@end
