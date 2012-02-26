/*
    STSelector
  
    Copyright (c) 2002 Free Software Foundation

    Written by: Stefan Urbanek <urbanek@host.sk>
    Date: 2002 Feb 4
  
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

#import "STSelector.h"
#import "STObjCRuntime.h"

#import <Foundation/NSCoder.h>
#import <Foundation/NSString.h>

@implementation STSelector
- initWithName:(NSString *)aString
{
    [super init];
    
    selectorName = RETAIN(aString);
    
    return self;
}

- initWithSelector:(SEL)aSel
{
    [super init];
    sel = aSel;
    return self;
}
- (void)dealloc
{
    RELEASE(selectorName);
    [super dealloc];
}

- (SEL)selectorValue
{
    if(sel == 0)
    {
        sel = STSelectorFromString(selectorName);
    }
    return sel;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"#%@", [self selectorName]];
}

- (NSString *)selectorName
{
    if(!selectorName)
    {
        selectorName = RETAIN(NSStringFromSelector(sel));
    }

    return selectorName;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    // [super encodeWithCoder: coder];

    [coder encodeObject:selectorName];
}

- initWithCoder:(NSCoder *)decoder
{
    self = [super init]; // super initWithCoder: decoder];
    
    [decoder decodeValueOfObjCType: @encode(id) at: &selectorName];

    return self;
}
@end
