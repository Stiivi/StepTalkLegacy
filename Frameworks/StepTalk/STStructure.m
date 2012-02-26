/**
    STStructure.m
    C structure wrapper
 
    Copyright (c) 2002 Free Software Foundation
 
    Written by: Stefan Urbanek <urbanek@host.sk>
    Date: 2000
   
    This file is part of StepTalk.
 
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

#import "STStructure.h"

#import "STExterns.h"
#import <Foundation/NSArray.h>
#import <Foundation/NSException.h>
#import <Foundation/NSString.h>
#import <Foundation/NSValue.h>
#import <Foundation/NSDebug.h>
#import "NSInvocation+additions.h"

#import <objc/objc-api.h>

@implementation STStructure
+ structureWithValue:(void *)value type:(const char*)type
{
    STStructure *str;
    str = [[self alloc] initWithValue:value type:type];
    return AUTORELEASE(str);
}
+ structureWithRange:(NSRange)range
{
    STStructure *str;
    str = [[self alloc] initWithValue:&range type:@encode(NSRange)];
    return AUTORELEASE(str);
}

+ structureWithPoint:(NSPoint)point
{
    STStructure *str;
    str = [[self alloc] initWithValue:&point type:@encode(NSPoint)];
    return AUTORELEASE(str);
}
+ structureWithSize:(NSSize)size
{
    STStructure *str;
    str = [[self alloc] initWithValue:&size type:@encode(NSSize)];
    return AUTORELEASE(str);
}

+ structureWithRect:(NSRect)rect
{
    STStructure *str;
    str = [[self alloc] initWithValue:&rect type:@encode(NSRect)];
    return AUTORELEASE(str);
}

- initWithValue:(void *)value type:(const char*)type
{
    const char *nameBeg;
    int offset = 0;
    int align;
    int rem;
    

    self = [super init];

    NSDebugLLog(@"STStructure",
               @"creating structure of type '%s' value ptr %p",type,value);
    
    structType = [[NSString alloc] initWithCString:type];
    
    fields = [[NSMutableArray alloc] init];

    type++;

    nameBeg = type;
    while (*type != _C_STRUCT_E && *type++ != '=');
    name = [[NSString alloc] initWithCString:nameBeg length:type-nameBeg];
    
    while(*type != _C_STRUCT_E)
    {
        [fields addObject:STObjectFromValueOfType(((char *)value)+offset,type)];

        offset += objc_sizeof_type(type);                                 
        type = objc_skip_typespec(type);

        if(*type == _C_STRUCT_E)
        {
            break;
        }
            
        align = objc_alignof_type(type);
        rem = offset % align;
        if(rem != 0)
        {
            offset += align - rem;
        }
    }

    return self;
}
- (void)dealloc
{
    RELEASE(fields);
    RELEASE(structType);
    RELEASE(name);
    [super dealloc];
}

- (void)getValue:(void *)value
{
    const char *type = [structType cString];
    int offset=0;
    int align;
    int rem;
    int i = 0;
    
    type++;
    while (*type != _C_STRUCT_E && *type++ != '=');

    while(*type != _C_STRUCT_E)
    {
        STGetValueOfTypeFromObject((void *)((char*)value+offset),
                                   type,
                                   [fields objectAtIndex:i++]);

        offset += objc_sizeof_type(type);                                 
        type = objc_skip_typespec(type);

        if(*type == _C_STRUCT_E)
        {
            break;
        }
        align = objc_alignof_type(type);
        rem = offset % align;
        if(rem != 0)
        {
            offset += align - rem;
        }
    }
}

- (const char *)type
{
    return [structType cString];
}
- (NSString *)structureName
{
    return name;
}
- (const char *)typeOfFieldAtIndex:(unsigned)index
{
    const char *type = [structType cString];
    
    for(type += 1; *type != _C_STRUCT_E && index>0; index--)
    {
        type = objc_skip_argspec(type);
    }

    if(*type == _C_STRUCT_E)
    {
        [NSException raise:STInternalInconsistencyException
                    format:@"invalid structure field index"];
        return 0;
    }
    return type;    
}
- (NSRange)rangeValue
{
    /* FIXME: do some checking */
    return NSMakeRange([self intValueAtIndex:0],[self intValueAtIndex:1]);
}

- (NSPoint)pointValue
{
    /* FIXME: do some checking */
    return NSMakePoint([self floatValueAtIndex:0],[self floatValueAtIndex:1]);
}

- (NSSize)sizeValue
{
    /* FIXME: do some checking */
    return NSMakeSize([self floatValueAtIndex:0],[self floatValueAtIndex:1]);
}

- (NSRect)rectValue
{
    NSPoint origin = [[fields objectAtIndex:0] pointValue];
    NSSize size = [[fields objectAtIndex:1] sizeValue];
    NSRect rect;
    
    /* FIXME: do some checking */
    rect.origin = origin;
    rect.size = size;
    return rect;
}

- valueAtIndex:(unsigned)index
{
    return [fields objectAtIndex:index];
}
- (void)setValue:anObject atIndex:(unsigned)index
{
    [fields replaceObjectAtIndex:index withObject:anObject];
}

- (int)intValueAtIndex:(unsigned)index
{
    return (int)[[fields objectAtIndex:index] intValue];
}
- (float)floatValueAtIndex:(unsigned)index
{
    return (float)[[fields objectAtIndex:index] floatValue];
}

/* NSRange */

- (int)location
{
    return [[fields objectAtIndex:0] intValue];
}

- (int)length
{
    return [[fields objectAtIndex:1] intValue];
}

- (void)setLocation:(int)location
{
    [fields replaceObjectAtIndex:0 withObject: [NSNumber numberWithInt:location]];
}

- (void)setLength:(int)length
{
    [fields replaceObjectAtIndex:1 withObject: [NSNumber numberWithInt:length]];
}

/* NSPoint */

- (float)x
{
    return [[fields objectAtIndex:0] floatValue];
}

- (void)setX:(float)x
{
    [fields replaceObjectAtIndex:0 withObject: [NSNumber numberWithFloat:x]];
}

- (float)y
{
    return [[fields objectAtIndex:1] floatValue];
}

- (void)setY:(float)y
{
    [fields replaceObjectAtIndex:1 withObject: [NSNumber numberWithFloat:y]];
}

/* NSSize */

- (float)width
{
    return [[fields objectAtIndex:0] floatValue];
}

- (float)height
{
    return [[fields objectAtIndex:1] floatValue];
}

- (void)setWidth:(float)width
{
    [fields replaceObjectAtIndex:0 withObject: [NSNumber numberWithFloat:width]];
}
- (void)setHeight:(float)height
{
    [fields replaceObjectAtIndex:1 withObject: [NSNumber numberWithFloat:height]];
}

/* NSRect */

- (id)origin
{
    NSLog(@"Origin %@", [fields objectAtIndex:0]);
    return [fields objectAtIndex:0];
}

- (id)size
{
    NSLog(@"Size %@", [fields objectAtIndex:1]);
    return [fields objectAtIndex:1] ;
}

@end
