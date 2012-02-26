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

#import "AppController.h"

#import <Foundation/NSArray.h>
#import <Foundation/NSString.h>
#import <Foundation/NSUserDefaults.h>

#import <AppKit/NSApplication.h>
#import <AppKit/NSOpenPanel.h>

#import "ScriptPaper.h"
#import "ScriptPaperController.h"

@interface AppController(Private)
@end

@implementation AppController
- init
{
    [super init];
  
  
    return self;
}
- (void)dealloc
{
    [super dealloc];
}
- (void)applicationDidFinishLaunching:(id)notif
{
    /* Go to known state of application */
   [[NSDocumentController sharedDocumentController] newDocument:nil];
}
@end
