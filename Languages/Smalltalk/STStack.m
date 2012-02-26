/**
    STStack.m
    Temporaries and stack storage.
 
    Copyright (c) 2002 Free Software Foundation
 
    This file is part of the StepTalk project.
 
 */

#import "STStack.h"

#import <StepTalk/STExterns.h>

#import <Foundation/NSException.h>
#import <Foundation/NSDebug.h>

@implementation STStack
+ stackWithSize:(unsigned)newSize
{
    return AUTORELEASE([[self alloc] initWithSize:newSize]);
}

- initWithSize:(unsigned)newSize
{
    size = newSize;
    pointer = 0;
    stack = NSZoneMalloc( NSDefaultMallocZone(), size * sizeof(id) );

    return [super init];
}

- (void)invalidPointer:(unsigned)ptr
{
    [NSException raise:STInternalInconsistencyException
                format:@"%@: invalid pointer %i (sp=%i size=%i)",
                        self,
                        ptr,
                        pointer,
                        size];
}
- (void)dealloc
{
    NSZoneFree(NSDefaultMallocZone(),stack);
    [super dealloc];
}

#define INDEX_IS_VALID(index) \
            ((index >= 0) && (index < size))
            
#define CHECK_POINTER(value) \
            do {\
                if(!INDEX_IS_VALID(value)) \
                {\
                    [self invalidPointer:value];\
                } \
            }\
            while(0) 
/*
- (void)setPointer:(unsigned)newPointer
{
    CHECK_POINTER(newPointer);
    pointer=newPointer;
}
*/

- (int)pointer
{
    return pointer;
}

- (void)push:(id)value
{
    CHECK_POINTER(pointer);

    NSDebugLLog(@"STStack",@"stack:%p %02i push '%@'",self,pointer,value);
    
    stack[pointer++] = value;
}

- (void)duplicateTop
{
    [self push:[self valueAtTop]];
}
#define CONVERT_NIL(obj) ((obj == STNil) ? nil : (obj))
- (id)valueAtTop
{
    CHECK_POINTER(pointer-1);

    return CONVERT_NIL(stack[pointer-1]);
}
- (id)valueFromTop:(unsigned)index
{
    id value;

    CHECK_POINTER(pointer-index-1);

    value = stack[pointer - index - 1];
    NSDebugLLog(@"STStack",@"stack:%p %02i from top %i '%@'",
                  self,pointer,index,value);

    return CONVERT_NIL(value);
}

- (id)pop
{
    CHECK_POINTER(pointer-1);

    NSDebugLLog(@"STStack",@"stack:%p %02i pop '%@'",self,pointer,stack[pointer-1]);

    pointer --;
    return CONVERT_NIL(stack[pointer]);
}

- (void)popCount:(unsigned)count
{
    CHECK_POINTER(pointer-count);

    NSDebugLLog(@"STStack",@"stack:%p %02i pop count %i (%i)",self,
                 pointer,count,pointer-count);
    pointer -= count;
}
- (void)empty
{
    pointer = 0;
}

@end
