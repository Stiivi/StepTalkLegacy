/**
    ReadlineTranscript.m
    StepTalk simple transcript
 
    Copyright (c) 2002 Free Software Foundation
 
    Written by: Stefan Urbanek <urbanek@host.sk>
    Date:   2001 Apr 13
 
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

#import "ReadlineTranscript.h"

#import <Foundation/NSValue.h>
#import <Foundation/NSString.h>

#include <stdio.h>
#include <readline/readline.h>

static Class NSString_class;
static Class NSNumber_class;

static ReadlineTranscript *sharedTranscript;

@implementation ReadlineTranscript:NSObject
+ (void)initialize
{
    NSString_class = [NSString class];
    NSNumber_class = [NSNumber class];
}
+ sharedTranscript
{
    if(!sharedTranscript)
    {
        sharedTranscript = [[ReadlineTranscript alloc] init];
    }
    
    return sharedTranscript;
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

    printf("%s", [string cString]);

    return self;
}

- showLine:(id)anObject
{
    [self show:anObject];
    putchar('\n');
    
    return self;
}
-(NSString*)readLine:(NSString*)prompt
{
	NSString *resret=nil;
	char *res;
	res = readline([prompt cString]);
	if (res)
	{
		resret = [[NSString alloc] initWithCStringNoCopy: res 
                                                  length: strlen(res) 
                                            freeWhenDone: YES];
	}
	return AUTORELEASE(resret);
}
@end
