/**
    STBundleInfo.h
    Bundle scripting information
  
    Copyright (c) 2002 Free Software Foundation
  
    Written by: Stefan Urbanek <urbanek@host.sk>
    Date: 2003 Jan 22
  
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

#import "STBundleInfo.h"

#import "STFunctions.h"
#import "STExterns.h"

#import <Foundation/NSArray.h>
#import <Foundation/NSBundle.h>
#import <Foundation/NSDebug.h>
#import <Foundation/NSException.h>
#import <Foundation/NSFileManager.h>
#import <Foundation/NSNotification.h>
#import <Foundation/NSPathUtilities.h>
#import <Foundation/NSString.h>

static NSMutableDictionary *bundleInfoDict;

@protocol STScriptingInfoClass
+ (NSDictionary *)namedObjectsForScripting;
@end

@interface STBundleInfo(STPrivateMethods)
- (void) _bundleDidLoad:(NSNotification *)notif;
- (void)_initializeScriptingInfoClass;
@end

@implementation NSBundle(STAdditions)
/** Get list of all StepTalk bundles from Library/StepTalk/Bundles */
+ (NSArray *)stepTalkBundleNames
{
    NSArray        *bundles;
    NSEnumerator   *enumerator;
    NSString       *path;
    NSMutableArray *names = [NSMutableArray array];
    NSString       *name;
    
    bundles = STFindAllResources(@"Bundles", STModuleExtension);

    enumerator = [bundles objectEnumerator];    
    
    while( (path = [enumerator nextObject]) )
    {
        name = [path lastPathComponent];
        name = [name stringByDeletingPathExtension];
        [names addObject:name];        
    }
    
    bundles = STFindAllResources(@"Modules", STModuleExtension);

    enumerator = [bundles objectEnumerator];    
    
    while( (path = [enumerator nextObject]) )
    {
        name = [path lastPathComponent];
        name = [name stringByDeletingPathExtension];
        [names addObject:name];        
    }

    return AUTORELEASE([NSArray arrayWithArray:names]);
}

+ stepTalkBundleWithName:(NSString *)moduleName
{
    NSString *file = STFindResource(moduleName, @"Bundles",
                                                @"bundle");
    if(!file)
    {
        file = STFindResource(moduleName, STModulesDirectory,
                                          STModuleExtension);
        
        if(!file)
        {
            NSLog(@"Could not find bundle with name '%@'", moduleName);
            return nil;
        }
    }

    return AUTORELEASE([[self alloc] initWithPath:file]);
}
- (NSDictionary *)scriptingInfoDictionary
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString      *file;

    file = [self pathForResource:@"ScriptingInfo" ofType:@"plist"];
    
    if([manager fileExistsAtPath:file])
    {
        return [NSDictionary dictionaryWithContentsOfFile:file];
    }
    else
    {
        return nil;
    }
}
/** Return names of all available frameworks in the system. */
+ (NSArray *)allFrameworkNames
{
    NSMutableArray *names = [NSMutableArray array];
    NSFileManager  *manager = [NSFileManager defaultManager];
    NSArray        *paths;
    NSEnumerator   *fenum;
    NSEnumerator   *penum;
    NSString       *path;
    NSString       *file;
    NSString       *name;

    paths = NSStandardLibraryPaths();

    penum = [paths objectEnumerator];
    
    while( (path = [penum nextObject]) )
    {
    
        path = [path stringByAppendingPathComponent:@"Frameworks"];

        fenum = [[manager directoryContentsAtPath:path] objectEnumerator];

        if( ![manager fileExistsAtPath:path isDirectory:NO] )
        {
            continue;
        }

        while( (file = [fenum nextObject]) )
        {
            if( [[file pathExtension] isEqualToString:@"framework"] )
            {
                name = [[file lastPathComponent] stringByDeletingPathExtension];
                [names addObject:name];
            }
        }
    }
    
    return names;
}

/** Return path for framework with name <var>aName</var>. */
+ (NSString *)pathForFrameworkWithName:(NSString *)aName
{
    NSFileManager  *manager = [NSFileManager defaultManager];
    NSArray        *paths;
    NSEnumerator   *fenum;
    NSEnumerator   *penum;
    NSString       *path;
    NSString       *file;
    NSString       *name;

    paths = NSStandardLibraryPaths();

    penum = [paths objectEnumerator];
    
    while( (path = [penum nextObject]) )
    {
    
        path = [path stringByAppendingPathComponent:@"Frameworks"];

        fenum = [[manager directoryContentsAtPath:path] objectEnumerator];

        if( ![manager fileExistsAtPath:path isDirectory:NO] )
        {
            continue;
        }

        while( (file = [fenum nextObject]) )
        {
            if( [[file pathExtension] isEqualToString:@"framework"] )
            {
                name = [[file lastPathComponent] stringByDeletingPathExtension];
                if([name isEqualToString:aName])
                {
                    return [path stringByAppendingPathComponent:file];
                }
            }
        }
    }
    
    return nil;
}

/** Return bundle for framework with name <var>aName</var>. */
+ (NSBundle *)bundleForFrameworkWithName:(NSString *)aName
{
    return [self bundleWithPath:[self pathForFrameworkWithName:aName]];;
}

@end

@implementation STBundleInfo
+ infoForBundle:(NSBundle *)aBundle
{
    return AUTORELEASE([[self alloc] initWithBundle:aBundle]);
}
/** Initialize info with bundle <var>aBundle</var>.

 <init />
*/
- initWithBundle:(NSBundle *)aBundle
{
    STBundleInfo *info;
    NSString     *flagString;
    NSDictionary *dict;
    if(!aBundle)
    {
        [NSException raise:@"STBundleException"
                     format:@"Nil bundle specified"];
        [self dealloc];
        return nil;
    }

    info = [bundleInfoDict objectForKey:[aBundle bundlePath]];

    if(info)
    {
        [self dealloc];
        return RETAIN(info);
    }

    dict = [aBundle scriptingInfoDictionary];

    if(!dict)
    {
        NSLog(@"Warning: Bundle '%@' does not provide scripting capabilities.",
              [aBundle bundlePath]);
        [self dealloc];
        return nil;
    }

    ASSIGN(bundle, aBundle);

#if 0                
    /* FIXME: remove observer somewhere */
    [[NSNotificationCenter defaultCenter] 
             addObserver:self
                selector:@selector(_bundleDidLoad:)
                    name:NSBundleDidLoadNotification
                  object:self];
#endif

    flagString = [dict objectForKey:@"UseAllClasses"];
    flagString = [flagString lowercaseString];

    useAllClasses = [flagString isEqualToString:@"yes"];

    if([dict objectForKey: @"STClasses"])
    {
        NSLog(@"WARNING: Use 'Classes' instead of 'STClasses' in "
              @"ScriptingInfo.plist for bundle '%@'", [aBundle bundlePath]);

        publicClasses = [dict objectForKey:@"STClasses"];
    }
    else
    {
        publicClasses = [dict objectForKey:@"Classes"];
    }
    RETAIN(publicClasses);


    if([dict objectForKey: @"STScriptingInfoClass"])
    {
        NSLog(@"WARNING: Use 'ScriptingInfoClass' instead of 'STScriptingInfoClass' in "
              @"ScriptingInfo.plist for bundle '%@'", [aBundle bundlePath]);

        scriptingInfoClassName = [dict objectForKey:@"STScriptingInfoClass"];
    }
    else
    {
        scriptingInfoClassName = [dict objectForKey:@"ScriptingInfoClass"];
    }
    RETAIN(scriptingInfoClassName);
    
    objectReferenceDictionary = [dict objectForKey:@"Objects"];

    if(!bundleInfoDict)
    {
        bundleInfoDict = [[NSMutableDictionary alloc] init];
    }
    
    [bundleInfoDict setObject:self forKey:[bundle bundlePath]];

    return self;
}

- (void) _bundleDidLoad:(NSNotification *)notif
{
    NSLog(@"Module '%@' loaded", [bundle bundlePath]);

    if([notif object] != self)
    {
        NSLog(@"STBundle: That's not me!");
        return;
    }
    
    allClasses = [[notif userInfo] objectForKey:@"NSLoadedClasses"];
    RETAIN(allClasses);
    
    NSLog(@"All classes are %@");
}

- (NSArray *)publicClassNames
{
    if(useAllClasses)
    {
        if(!allClasses)
        {
            [self _initializeScriptingInfoClass];
        }
        return allClasses;
    }
    else
    {
        return publicClasses;
    }
}

/** Return an array of all class names. */
- (NSArray *)allClassNames
{
    /* FIXME: not implemented; */
    NSLog(@"Warning: All bundle classes requested, using public classes only.");
    return publicClasses;
}

/** Return a dictionary of named objects. Named objects are get from scripting
    info class specified in ScriptingInfo.plist.*/
- (NSDictionary *)namedObjects
{
    if(!scriptingInfoClass)
    {
        [self _initializeScriptingInfoClass];
    }
    
    return [(id)scriptingInfoClass namedObjectsForScripting];
}

- (void)_initializeScriptingInfoClass
{
    scriptingInfoClass = [bundle classNamed:scriptingInfoClassName];

    if(!scriptingInfoClass)
    {
        NSDebugLog(@"No scripting info class for bundle '%@'",[bundle bundlePath]);
#if 0    
        [NSException raise:@"STBundleException"
                     format:@"Unable to get scripting info class '%@' for "
                            @"bundle '%@'", 
                            scriptingInfoClassName, [bundle bundlePath]];
                     
#endif
    }
}

/** This method is for application scripting support. Return dictionary 
    containing object references where a key is name of an object and 
    value is a path to the object relative to application delegate. 
*/
- (NSDictionary *)objectReferenceDictionary
{
    return objectReferenceDictionary;
}

@end
