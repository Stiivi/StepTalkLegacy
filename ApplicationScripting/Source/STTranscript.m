/**
    STTranscript
  
    Copyright (c) 2002 Stefan Urbanek
  
    Written by: Stefan Urbanek <urbanek@host.sk>
    Date: 2002 Mar 20
 
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

#import "STTranscript.h"

#import <AppKit/NSAttributedString.h>
#import <AppKit/NSColor.h>
#import <AppKit/NSTextView.h>
#import <AppKit/NSWindow.h>

#import <Foundation/NSArray.h>
#import <Foundation/NSDictionary.h>
#import <Foundation/NSEnumerator.h>
#import <Foundation/NSFileManager.h>
#import <Foundation/NSUserDefaults.h>
#import <Foundation/NSValue.h>

#import "NSObject+NibLoading.h"

static STTranscript *sharedTranscript;

static Class NSString_class;
static Class NSNumber_class;

static NSDictionary  *errorTextAttributes;
static NSDictionary  *normalTextAttributes;

@implementation STTranscript
+ (void)initialize
{
    NSString_class = [NSString class];
    NSNumber_class = [NSNumber class];

    errorTextAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:
                                [NSColor redColor], NSForegroundColorAttributeName,
                                nil, nil];

    normalTextAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:
                                [NSColor blackColor], NSForegroundColorAttributeName,
                                nil, nil];
}
+ sharedTranscript
{
    if(!sharedTranscript)
    {
        sharedTranscript = [[STTranscript alloc] init];
        [sharedTranscript showLine:@"Shared scripting transcript."];
    }
    
    return sharedTranscript;
}

- init
{
    if(![self loadMyNibNamed:@"TranscriptWindow"])
    {
        [self dealloc];
        return nil;
    }

    [window setTitle:@"Scripting Transcript"];
    [window setFrameUsingName:@"STTranscriptWindow"];
    [window setFrameAutosaveName:@"STTranscriptWindow"];

    /* FIXME: Fix Gorm autoresizing */
    // [textView setAutoresizingMask: NSViewHeightSizable | NSViewWidthSizable];
    
    return self;
}

- show:(id)anObject
{
    NSString *string;
    
    if( [anObject isKindOfClass:NSString_class] )
    {
        string = anObject;
    }
    else if ( [anObject isKindOfClass:NSNumber_class] )
    {
        string = [anObject stringValue];
    }
    else
    {
        string = [anObject description];
    }

    [textView insertText:string];

    return self;
}

- showLine:(id)anObject
{
    [self show:anObject];
    [textView insertText:@"\n"];
    
    return self;
}

- (NSWindow *)window
{
    return window;
}

- showError:(NSString *)errorText
{
    NSAttributedString *astring;
    
    astring = [[NSAttributedString alloc] initWithString:errorText
                                              attributes:errorTextAttributes];
    [textView insertText:astring];

    astring = [[NSAttributedString alloc] initWithString:@"\n"
                                              attributes:normalTextAttributes];
    [textView insertText:astring];

    RELEASE(astring);
    
    return self;
}

@end
