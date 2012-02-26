/**
    STEnvironmentDescription.h
 
    Copyright (c) 2002 Free Software Foundation
 
    Written by: Stefan Urbanek <urbanek@host.sk>
    Date: 2000 Jun 16
 
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

enum
{
    STUndefinedRestriction,
    STAllowAllRestriction,
    STDenyAllRestriction
};

@class NSDictionary;
@class NSMutableArray;
@class NSMutableDictionary;

@interface STEnvironmentDescription:NSObject
{
    NSMutableArray      *usedDefs;
    NSMutableDictionary *classes;
    NSMutableDictionary *behaviours;
    NSMutableDictionary *aliases;
    NSMutableArray      *modules;
    NSMutableArray      *frameworks;
    NSMutableArray      *finders;

    int                  restriction;
}
+ (NSString *)defaultDescriptionName;

+ descriptionWithName:(NSString *)descriptionName;
+ descriptionFromDictionary:(NSDictionary *)dictionary;

- initWithName:(NSString *)defName;
- initFromDictionary:(NSDictionary *)def;

- (void)updateFromDictionary:(NSDictionary *)def;
- (void)updateClassWithName:(NSString *)className description:(NSDictionary *)def;

- (NSMutableDictionary *)classes;
- (NSArray *)modules;
- (NSArray *)frameworks;
- (NSArray *)objectFinders;
@end

