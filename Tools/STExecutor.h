/**
    STExecutor.h
    Common class for stalk and stexec tools
 
    Copyright (c) 2002 Free Software Foundation
 
    Written by: Stefan Urbanek <urbanek@host.sk>
    Date: 2001
   
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

#import <Foundation/NSObject.h>

extern NSString *STExecutorException;
extern const char *STExecutorCommonOptions;

extern void STPrintCassStats(void);

enum
{
    STListNone,
    STListObjects,
    STListClasses,
    STListAll
};


@class STConversation;
@class STEnvironment;
@class NSString;
@class NSArray;

@interface STExecutor:NSObject
{
    STConversation *conversation;

    NSString      *langName;
    
    NSArray       *arguments;
    unsigned int   currentArg;
    
    BOOL           contFlag;
    int            listObjects;
}
- (void)createConversation;
- (void)printHelp;
- (int)processOption:(NSString *)option;
- (void)executeScript:(NSString *)fileName withArguments:(NSArray *)args;
- (void)executeScriptFromStandardInputArguments:(NSArray *)args;
- (int)parseOptions;
- (void)executeScripts;
- (NSString *)nextArgument;
- (void)reuseArgument;
- (void)runWithArguments:(NSArray *)argsArray;
@end
