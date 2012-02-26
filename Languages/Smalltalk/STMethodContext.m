/**
    STMethodContext.m
 
    Copyright (c) 2002 Free Software Foundation
 
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

#import "STMethodContext.h"

#import "STBytecodes.h"
#import "STCompiledMethod.h"
#import "STLiterals.h"
#import "STStack.h"

#import <StepTalk/STEnvironment.h>
#import <StepTalk/STExterns.h>
#import <StepTalk/STObjectReference.h>

#import <Foundation/NSArray.h>
#import <Foundation/NSDebug.h>
#import <Foundation/NSException.h>

@interface STMethodContext(STPrivateMethods)
- (void)_resolveExternReferences:(NSArray *)array
                     environment:(STEnvironment *)env;
@end

@implementation STMethodContext
+ methodContextWithMethod:(STCompiledMethod *)newMethod 
              environment:(STEnvironment *)env
{
    return AUTORELEASE([[self alloc] initWithMethod:newMethod environment:env]);
}

- initWithMethod:(STCompiledMethod *)newMethod 
     environment:(STEnvironment *)env
{
    unsigned int tempCount;
    unsigned int i;

    method = RETAIN(newMethod);

    tempCount = [method temporariesCount];
    temporaries = [[NSMutableArray alloc] initWithCapacity:tempCount];

    for(i=0;i<tempCount;i++)
    {
        [temporaries insertObject:STNil atIndex:i];
    }
    
    return [super initWithStackSize:[method stackSize]];
}

- (void)dealloc
{
    RELEASE(temporaries);
    RELEASE(method);
    [super dealloc];
}
- (BOOL)isBlockContext
{
    return NO;
}
- (STMethodContext *)homeContext
{
    return self;
}
- (void)setHomeContext:(STMethodContext *)context
{
    [NSException raise:STInternalInconsistencyException
                format:@"Should not set home context of method context"];
}

- (void)invalidate
{
    RELEASE(method);
    method = nil;
}
- (BOOL)isValid
{
    return (method != nil);
}

- (STCompiledMethod*)method
{
    return method;
}
- (void)setReceiver:anObject
{
    receiver = anObject;
}
- (id)receiver
{
    return receiver;
}

- (id)temporaryAtIndex:(unsigned)index
{
    return [temporaries objectAtIndex:index];
}

- (void)setTemporary:anObject atIndex:(unsigned)index
{
    if(!anObject)
    {
        anObject = STNil;
    }
    [temporaries replaceObjectAtIndex:index withObject:anObject];
}

- (NSString *)referenceNameAtIndex:(unsigned)index
{
    return [[method namedReferences] objectAtIndex:index];
}

- (STBytecodes *)bytecodes
{
    return [method bytecodes];
}
- (id)literalObjectAtIndex:(unsigned)index
{
    return [method literalObjectAtIndex:index];
}

- (void)setArgumentsFromArray:(NSArray *)args
{
    int i;
    int count;
    
    count = [args count];

    for(i=0;i<count;i++)
    {
        [self setTemporary:[args objectAtIndex:i] atIndex:i];
    }
}
@end
