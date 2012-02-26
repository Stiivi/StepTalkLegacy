/**
    STEnvironment
    Scripting environment
  
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

    <title>STEnvironment class reference</title>
 
   */

#import <StepTalk/STContext.h>

@class NSBundle;
@class NSDictionary;
@class NSMutableDictionary;
@class NSMutableArray;
@class NSMutableSet;

@class STObjectReference;
@class STEnvironmentDescription;

@interface STEnvironment:STContext
{
    STEnvironmentDescription *description;
    NSMutableDictionary      *classes;   /* from description */

    NSMutableDictionary      *infoCache;
    
    NSMutableDictionary      *objectFinders;
    
    NSMutableArray           *loadedBundles;
}
/** Creating environment */
+ sharedEnvironment;
+ (STEnvironment *)environmentWithDefaultDescription;

+ environmentWithDescription:(STEnvironmentDescription *)aDescription;

- initWithDefaultDescription;
- initWithDescription:(bycopy STEnvironmentDescription *)aDescription;

/** Modules */

- (void)loadModule:(NSString *)moduleName;

- (BOOL)includeFramework:(NSString *)frameworkName;
- (BOOL)includeBundle:(NSBundle *)aBundle;

- (void)addClassesWithNames:(NSArray *)names;

/** Distributed objects */
- (void)registerObjectFinder:(id)finder name:(NSString*)name;
- (void)registerObjectFinderNamed:(NSString *)name;
- (void)removeObjectFinderWithName:(NSString *)name;

/** Selector translation */

- (NSString  *)translateSelector:(NSString *)aString forReceiver:(id)anObject;
@end
