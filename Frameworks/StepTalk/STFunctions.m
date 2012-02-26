/**
    STFunctions.m
    Misc. functions
 
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

#import "STFunctions.h"

#import "STExterns.h"
#import "STContext.h"

#import <Foundation/NSArray.h>
#import <Foundation/NSBundle.h>
#import <Foundation/NSEnumerator.h>
#import <Foundation/NSFileManager.h>
#import <Foundation/NSPathUtilities.h>
#import <Foundation/NSString.h>

@class STContext;

NSString *STFindResource(NSString *name,
                         NSString *resourceDir,
                         NSString *extension)
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray       *paths;
    NSEnumerator  *enumerator;
    NSString      *path;
    NSString      *file;

    paths = NSStandardLibraryPaths();

    enumerator = [paths objectEnumerator];
    
    while( (path = [enumerator nextObject]) )
    {
    
        file = [path stringByAppendingPathComponent:STLibraryDirectory];
        file = [file stringByAppendingPathComponent:resourceDir];
        file = [file stringByAppendingPathComponent:name];

        if( [manager fileExistsAtPath:file] )
        {
            return file;
        }

        file = [file stringByAppendingPathExtension:extension];

        if( [manager fileExistsAtPath:file] )
        {
            return file;
        }
    }

    return [[NSBundle bundleForClass:[STContext class]]
                        pathForResource:name
                                ofType:extension
                                inDirectory:resourceDir];
}

NSArray *STFindAllResources(NSString *resourceDir, NSString *extension)
{
    NSFileManager         *manager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *dirs;
    
    NSArray       *paths;
    NSEnumerator  *enumerator;
    NSString      *path;
    NSString      *file;
    NSMutableArray *resources = [NSMutableArray array];

    paths = NSStandardLibraryPaths();

    enumerator = [paths objectEnumerator];
    
    while( (path = [enumerator nextObject]) )
    {
        path = [path stringByAppendingPathComponent:STLibraryDirectory];
        path = [path stringByAppendingPathComponent:resourceDir];
        
        if( ![manager fileExistsAtPath:path] )
        {
            continue;
        }

        dirs = [manager enumeratorAtPath:path];
        
        while( (file = [dirs nextObject]) )
        {
            if( [[[dirs directoryAttributes] fileType] 
                            isEqualToString:NSFileTypeDirectory]
                && [[file pathExtension] isEqualToString:extension])
            {
                file = [path stringByAppendingPathComponent:file];
                [resources addObject:file];
            }
        }
    }

    return [NSArray arrayWithArray:resources];
}

NSString *STUserConfigPath(void)
{
    NSString *path = nil;
    NSArray  *paths;    

    paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                NSUserDomainMask, YES);
    path = [paths objectAtIndex: 0];

    path = [path stringByAppendingPathComponent:STLibraryDirectory];
    path = [path stringByAppendingPathComponent:@"Configuration"];

    return path;  
}
