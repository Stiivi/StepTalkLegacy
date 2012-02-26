/**
    STScriptsPanel
  
    Copyright (c)2002 Stefan Urbanek
  
    Written by: Stefan Urbanek <urbanek@host.sk>
    Date: 2002 Mar 15
 
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

#import <AppKit/NSPanel.h>

@class STScriptsManager;
@class STScript;
@class NSPopUpButton;

@interface STScriptsPanel : NSPanel
{
    id             scriptList;
    id             descriptionText;
    id             runButton;
    NSPopUpButton *commandMenu;
    id             _panel;
    
    id             delegate;

    STScriptsManager *scriptsManager;
    NSArray          *scripts;
}
- (void) run: (id)sender;
- (void) command: (id)sender;
- (void) update: (id)sender;
- (void) browse: (id)sender;
- (void) showHelp: (id)sender;

- (STScript *) selectedScript;

- (void) setDelegate: (id)anObject;
- (id) delegate;
@end
