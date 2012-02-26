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

#import "ScriptPaper.h"

#import <Foundation/NSException.h>
#import <Foundation/NSString.h>

#import <StepTalk/STEnvironment.h>
#import <StepTalk/STEngine.h>
#import <StepTalk/STLanguage.h>

#import "ScriptPaperController.h"

@implementation ScriptPaper
- init
{
    [super init];
    
    environment = [[STEnvironment alloc] initDefault];
    
    return self;
}
- (void)dealloc
{
    [super dealloc];
}

- (void)makeWindowControllers
{
    ScriptPaperController *controller;
    
    controller = [[ScriptPaperController alloc] init];
    [controller setDocument:self];
    
    [self addWindowController:AUTORELEASE(controller)];
}
- (id)executeScriptString:(NSString *)source
{
    STEngine       *engine;
    NSString       *error;
    id             retval = nil;
    
    engine = [STEngine engineForLanguageWithName:
                            [STLanguage defaultLanguageName]];
    if(!engine)
    {
        NSLog(@"Unable to get scripting engine.");
        return nil;
    }

    if(!environment)
    {
        NSLog(@"No scripting environment");
        return nil;
    }

    NS_DURING
        retval = [engine executeCode:source inEnvironment:environment];
    NS_HANDLER
        error = [NSString stringWithFormat:
                            @"Error: "
                            @"Execution of script failed. %@. (%@)",
                            [localException reason],
                            [localException name]];

        // [[STTranscript sharedTranscript] showError:error];

        NSLog(@"Script exception: %@", error);

        retval = nil;
    NS_ENDHANDLER
    
    return retval;
}

- (BOOL)writeToFile:(NSString *)fileName ofType:(NSString *)fileType
{
    NSLog(@"Write to file %@ of type %@. (not implemented)", fileName, fileType);
    return YES;
}
- (BOOL)readFromFile:(NSString *)fileName ofType:(NSString *)fileType
{
    NSLog(@"Read from file %@ of type %@. (not implemented)", fileName, fileType);
    return YES;
}
@end
