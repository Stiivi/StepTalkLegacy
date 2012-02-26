/** Controller
 
    Copyright (c) 2003 Stefan Urbanek

    Written by: Stefan Urbanek
    Date: 2003 Apr 26
    
    This file is part of the Farmer application.
 
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

#import "ScriptPaperController.h"

#import <Foundation/NSString.h>

#import <AppKit/NSForm.h>
#import <AppKit/NSTextView.h>
#import <AppKit/NSWindow.h>

#import "NSTextView+additions.h"

#import "ScriptPaper.h"

@implementation ScriptPaperController
- init
{
    return [self initWithWindowNibName:@"Paper"];
}
- (void)windowDidLoad
{
    [sourceView setRichText:NO];
    [sourceView setString:@"This is a paper.\n1 + 1"];
}
- (void)dealloc
{
    [super dealloc];
}

/** Execute selected text as script. */
- (IBAction)doSelection:(id)sender
{
    NSString *selectedString = [sourceView selectedString];

    NSLog(@"Do!");

    [[self document] executeScriptString:selectedString];
}

/** Execute selected text as script and insert result into the paper. */
- (IBAction)doAndShowSelection:(id)sender
{
    NSString  *selectedString = [sourceView selectedString];
    NSRange    range;
    id         string;
    int        length;
    id         retval = nil;
    
    NSLog(@"Do and Show!");

    retval = [[self document] executeScriptString:selectedString];

    if(!retval)
    {
        retval = @"(nil)";
    }

    range = [sourceView selectedRange];
    range = NSMakeRange(NSMaxRange(range), 0);
    [sourceView setSelectedRange:range];

      
    if([retval isKindOfClass:[NSString class]]
        || [retval isKindOfClass:[NSAttributedString class]])
    {
        string = retval;
    }
    else
    {
        string = [retval description];
    }

    [sourceView insertText:@" "];
    [sourceView insertText:string];

    range = NSMakeRange(range.location + 1, [string length]);

}

@end
