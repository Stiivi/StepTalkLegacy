/**
    STStructure.h
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

#import <Foundation/NSObject.h>
#import <Foundation/NSGeometry.h>
#import <Foundation/NSRange.h>

// @class STRange;
// @class STPoint;
// @class STRect;
@class NSString;
@class NSMutableArray;

@interface STStructure:NSObject
{
    NSString *structType;
    NSString *name;
    NSMutableArray  *fields;
}
+ structureWithValue:(void *)value type:(const char*)type;
+ structureWithRange:(NSRange)range;
+ structureWithPoint:(NSPoint)point;
+ structureWithRect:(NSRect)rect;
+ structureWithSize:(NSSize)size;

- initWithValue:(void *)value type:(const char*)type;
- (const char *)type;
- (NSString *)structureName;

- (void)getValue:(void *)value;

- (NSRange)rangeValue;
- (NSPoint)pointValue;
- (NSRect)rectValue;
- (NSSize)sizeValue;

- valueAtIndex:(unsigned)index;
- (void)setValue:anObject atIndex:(unsigned)index;

- (int)intValueAtIndex:(unsigned)index;
- (float)floatValueAtIndex:(unsigned)index;
@end

/*
@interface STRange:STStructure
- rangeWithLocation:(int)loc length:(int)length;
- (int)location;
- (int)length;
@end

@interface STPoint:STStructure
- pointWithX:(float)x y:(float)y;
- (float)x;
- (float)y;
@end

@interface STRect:STStructure
- rectWithX:(float)x y:(float)y width:(float)w heigth:(float)h;
- rectWithOrigin:(NSPoint)origin size:(NSPoint)size;
- (float)x;
- (float)y;
- (float)width;
- (float)height;
- (NSPoint)origin;
- (NSPoint)size;
@end
*/
