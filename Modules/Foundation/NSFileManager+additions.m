/**
    NSFileManager+additions.m
    File manager additions - GNUstep path functions
 
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

#import <Foundation/NSFileManager.h>
#import <Foundation/NSPathUtilities.h>

@implementation NSFileManager(STAdditions)
+ (NSString *)homeDirectory
{
    return NSHomeDirectory();
}
+ (NSString *)homeDirectoryForUser:(NSString *)user
{
    return NSHomeDirectoryForUser(user);
}
+ (NSString *)openStepRootDirectory
{
    return NSOpenStepRootDirectory();
}
+ (NSArray *)searchPathForDirectories:(int)dir 
                            inDomains:(int)domainMask
                          expandTilde:(BOOL)flag
{
    return NSSearchPathForDirectoriesInDomains(dir, domainMask, flag);
}
+ (NSArray *)searchPathForDirectories:(int)dir inDomains:(int)domainMask
{
    return [self searchPathForDirectories:dir 
                                inDomains:domainMask 
                              expandTilde:YES];
}
+ (NSString *)temporaryDirectory
{
    return NSTemporaryDirectory();
}
+ (NSArray *)standardLibraryPaths
{
    return NSStandardLibraryPaths();
}
@end
