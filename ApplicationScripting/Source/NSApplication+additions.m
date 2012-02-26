/**
    NSApplication additions
  
    Copyright (c) 2000 Stefan Urbanek
  
    Written by: Stefan Urbanek <urbanek@host.sk>
    Date: 2001 Nov 15
 
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

#import "NSApplication+additions.h"

#import "STScriptsPanel.h"
#import "STTranscript.h"
#import "STEnvironment+additions.h"

#import <StepTalk/STBundleInfo.h>

#import <Foundation/NSBundle.h>
#import <Foundation/NSDebug.h>
#import <Foundation/NSDictionary.h>
#import <Foundation/NSNotification.h>
#import <Foundation/NSProcessInfo.h>
#import <Foundation/NSString.h>
#import <Foundation/NSSet.h>

#import <AppKit/NSPanel.h>

#import "STApplicationScriptingController.h"

static STEnvironment        *scriptingEnvironment = nil;
static NSMutableSet         *scannedBundles;

static STApplicationScriptingController *scriptingController = nil;

@interface NSApplication (STPrivateMethods)
- (void)updateScriptingInfoFromBundles;
- (void)_createDefaultScriptingEnvironment;
@end

@implementation NSApplication(STAppScriptingAdditions)

/** Method for preventing multiple initialization. It will show alert panel
    on invocation. You should not invoke this method.*/
- (BOOL)initializeApplicationScripting
{
    /* FIXME: make it more human-readable */
    NSRunAlertPanel(@"Scripting is already initialized",
                    @"[NSApp initializeApplicationScripting] is called more than once.",
                    @"Cancel", nil, nil);

    return YES;
}

/** Do real initialization of application scripting. You should not invoke 
    this method directly. */
- (BOOL)setUpApplicationScripting
{
//    STBundleInfo  *info;

//    info = [STBundleInfo infoForBundle:[NSBundle mainBundle]];

    /* FIXME: use info */
    scriptingController = [[STApplicationScriptingController alloc] init];
    return YES;
}

/** Return shared scripting environment. If there is none, create one. */
- (STEnvironment *)scriptingEnvironment
{
    if(!scriptingEnvironment)
    {
        [self _createDefaultScriptingEnvironment];
    }

    return scriptingEnvironment;
}

/** Create shared scripting environment. */
- (void)_createDefaultScriptingEnvironment
{
    STEnvironment *env = nil;
    STBundleInfo  *info;
    //NSString      *path;
    NSString      *str = nil;
    //NSString      *reference;
    //NSDictionary  *dict;
    //id             object;

    NSDebugLog(@"Creating scripting environment");

    scannedBundles = [[NSMutableSet alloc] init];

    info = [STBundleInfo infoForBundle:[NSBundle mainBundle]];

    if(!info)
    {
        NSRunAlertPanel(@"Application does not provide scripting capabilities",
                        @"This application was designed to support "
                        @"scripting, but something went wrong. "
                        @"Check if the file ScriptingInfo.plist exists "
                        @"in application's bundle directory.",
                        @"Cancel", nil, nil);
        return;
    }
    
    [scannedBundles addObject:[NSBundle mainBundle]];

    /* FIXME: use scripting environment from application bundle */
    /*    str = [info objectForKey:@"STEnvironmentDescription"]; */

    if(str && ![str isEqualToString:@""])
    {
        env = [STEnvironment environmentWithDescriptionName:str];
    }
    if(!env)
    {
        NSDebugLog(@"Using default scripting environment");
        env = [STEnvironment defaultScriptingEnvironment];
    }

    [env loadModule:@"AppKit"];
    [env includeBundle:[NSBundle mainBundle]];
    [env setObject:self forName:@"Application"];
    [env setObject:self forName:[self applcationNameForScripting]];
    [env setObject:[STTranscript sharedTranscript] forName:@"Transcript"];

    scriptingEnvironment = RETAIN(env);

    [self updateScriptingInfoFromBundles];

    [[NSNotificationCenter defaultCenter]
                         addObserver:self
                            selector:@selector(updateScriptingInfoOnBundleLoad:)
                                name:NSBundleDidLoadNotification 
                              object:nil];
}

/** Include information from loaded modules and bundles. */
- (void)updateScriptingInfoFromBundles
{
    STEnvironment *env = [self scriptingEnvironment];
    NSEnumerator *enumerator;
    //NSDictionary *info;
    //NSString     *path;
    NSBundle     *bundle;
    NSMutableSet *bundles;
    
    NSDebugLog(@"Updating scripting info from bundles");
    
    bundles = (id)[NSMutableSet setWithArray:[NSBundle allBundles]];
    [bundles minusSet:scannedBundles];
    
    enumerator = [bundles objectEnumerator];
    
    while( (bundle = [enumerator nextObject]) )
    {

        /* If bundle provides scripting capabilities, try to include it. */
        if([bundle scriptingInfoDictionary])
        {
            if(![env includeBundle:bundle])
            {
                NSLog(@"Failed to include bundle scripting of '%@'.",
                        [bundle bundlePath]);
            }
        }
    }
    
    [scannedBundles unionSet:bundles];
}

/** Called on NSBundleDidLoad notification. You */
- (void)updateScriptingInfoOnBundleLoad:(NSNotification *)notif
{
    [self updateScriptingInfoFromBundles];
}

/** Name of application object */
- (NSString *)applcationNameForScripting
{
    return [[NSProcessInfo processInfo] processName];
}

/** Order the scripts panel into the front. */
- (void)orderFrontScriptsPanel:(id)sender
{
    [scriptingController orderFrontScriptsPanel:nil];
}

/** Return scripting menu. The default menu is provided by 
    STApplicationScriptingController */
- (NSMenu *)scriptingMenu
{
    return [scriptingController scriptingMenu];
}

/** Set application Scripting menu */
- (void)setScriptingMenu:(NSMenu *)menu
{
    [scriptingController setScriptingMenu:menu];
}

/** Order the Transcript window into the front. */
- (void)orderFrontTranscriptWindow:(id)sender
{
    [scriptingController orderFrontTranscriptWindow:nil];
}

/** Return YES if scripting is supported, otherwise returns NO. Because
    this method is called when framework is loaded, allways returns YES. */
- (BOOL)isScriptingSupported
{
    return YES;
}

/** Return object that is responsible for controlling application scriptign 
*/
- (STApplicationScriptingController *)scriptingController
{
    return scriptingController;
}
@end
