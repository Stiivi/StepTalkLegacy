/**
    NSInvocation+additions
    Various NSInvocation additions
 
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
    
    <title>NSInvocation class additions</title>
 
 */

#import "NSInvocation+additions.h"

#import <Foundation/NSDebug.h>
#import <Foundation/NSException.h>
#import <Foundation/NSValue.h>
#import <Foundation/NSString.h>

#import "STExterns.h"
#import "STObjCRuntime.h"
#import "STScripting.h"
#import "STSelector.h"
#import "STStructure.h"

#import <objc/objc-api.h>

#if 0
static Class NSNumber_class = nil;
static Class NSString_class = nil;
static Class NSValue_class = nil;
#endif

#define CASE_NUMBER_TYPE(otype,type,msgtype)\
            case otype: object = [NSNumber numberWith##msgtype:*((type *)value)];\
                        NSDebugLLog(@"STStructure",\
                                   @"    is number value '%@'", object);\
                        break

/** This method is a factory method, that means that you have to release the
    object when you no longer need it. */
id STObjectFromValueOfType(void *value, const char *type)
{
    id object;

    NSDebugLLog(@"STStructure",
               @"object from value %p of of type '%c'",value,*type);

    switch(*type)
    {
    case _C_ID:
    case _C_CLASS:
            object = *((id *)value);
            NSDebugLLog(@"STStructure",
                       @"    is object value %p", object);
            break;
    CASE_NUMBER_TYPE(_C_CHR,char,Char);
    CASE_NUMBER_TYPE(_C_UCHR,unsigned char, UnsignedChar);
    CASE_NUMBER_TYPE(_C_SHT,short,Short);
    CASE_NUMBER_TYPE(_C_USHT,unsigned short,UnsignedShort);
    CASE_NUMBER_TYPE(_C_INT,int,Int);
    CASE_NUMBER_TYPE(_C_UINT,unsigned int,UnsignedInt);
    CASE_NUMBER_TYPE(_C_LNG,long,Long);
    CASE_NUMBER_TYPE(_C_ULNG,unsigned long,UnsignedLong);
#ifdef _C_LNG_LNG
    CASE_NUMBER_TYPE(_C_LNG_LNG,long long,LongLong);
    CASE_NUMBER_TYPE(_C_ULNG_LNG,unsigned long long,UnsignedLongLong);
#endif
    CASE_NUMBER_TYPE(_C_FLT,float,Float);
    CASE_NUMBER_TYPE(_C_DBL,double,Double);
    case _C_PTR: 
                object = [NSValue valueWithPointer:*((void **)value)];
                NSDebugLLog(@"STStructure",
                           @"    is pointer value %p", *((void **)value));
                break;
    case _C_CHARPTR: 
                object = [NSString stringWithCString:*((char **)value)];
                NSDebugLLog(@"STStructure",
                           @"    is string value '%s'", *((char **)value));
                break;
    case _C_VOID:
                object = nil;
                break;
    case _C_STRUCT_B:
                object = [[STStructure alloc] initWithValue:value
                                                       type:type];
                AUTORELEASE(object);
                break;
    case _C_SEL: 
                object = [[STSelector alloc] initWithSelector:*((SEL *)value)];
                AUTORELEASE(object);
                break;
    case _C_BFLD:
    case _C_UNDEF:
    case _C_ARY_B:
    case _C_ARY_E:
    case _C_UNION_B:
    case _C_UNION_E:
    case _C_STRUCT_E:
    default:
        [NSException raise:STInvalidArgumentException
                    format:@"unhandled ObjC type '%s'",
                            type];

    }       
    return object;
}

#define CASE_TYPE(otype,type,msgtype)\
            case otype:(*((type *)value)) = [anObject msgtype##Value];\
                        NSDebugLLog(@"STStructure",\
                                   @"    is number value '%@'", anObject);\
                       break

void STGetValueOfTypeFromObject(void *value, const char *type, id anObject)
{
    NSDebugLLog(@"STStructure",
               @"value at %p from object '%@' of type '%c'",
                value,anObject,*type);

    switch(*type)
    {
    case _C_ID:
    case _C_CLASS:
            NSDebugLLog(@"STStructure",
                        @"    is object value");
            (*(id *)value) = anObject;
            break;
    CASE_TYPE(_C_CHR,char,char);
    CASE_TYPE(_C_UCHR,unsigned char,unsignedChar);
    CASE_TYPE(_C_SHT,short,short);
    CASE_TYPE(_C_USHT,unsigned short,unsignedShort);
    CASE_TYPE(_C_INT,int,int);
    CASE_TYPE(_C_UINT,unsigned int,unsignedInt);
    CASE_TYPE(_C_LNG,long,long);
    CASE_TYPE(_C_ULNG,unsigned long,unsignedLong);
    CASE_TYPE(_C_LNG_LNG,long long,longLong);
    CASE_TYPE(_C_ULNG_LNG,unsigned long long,unsignedLongLong);
    CASE_TYPE(_C_FLT,float,float);
    CASE_TYPE(_C_DBL,double,double);
    CASE_TYPE(_C_PTR,void *,pointer);
    case _C_CHARPTR: /* FIXME: check if this is good (copy/no copy)*/
            (*((const char **)value)) = [[anObject stringValue] cString];
            NSDebugLLog(@"STStructure",
                       @"    is cstring '%@'", [anObject stringValue]);
            break;
    case _C_STRUCT_B:
            /* FIXME: chech for struct compatibility */
            NSDebugLLog(@"STStructure",
                       @"    is structure");
            [(STStructure*)anObject getValue:value];
            break;

    case _C_SEL:
            (*((SEL *)value)) = [anObject selectorValue];
            break;
            
    case _C_BFLD:
    case _C_VOID:
    case _C_UNDEF:
    case _C_ATOM:
    case _C_ARY_B:
    case _C_ARY_E:
    case _C_UNION_B:
    case _C_UNION_E:
    case _C_STRUCT_E:
    default:
        [NSException raise:STInvalidArgumentException
                    format:@"unhandled ObjC type '%s'",
                            type];
    }        
}


@implementation NSInvocation(STAdditions)
#if 0
/* with this method it does not work, it is not posiible to create an 
   invocation*/
+ (void)initialize
{
    NSNumber_class = [NSNumber class];
    NSString_class = [NSString class];
    NSValue_class = [NSValue class];
}
#endif

+ invocationWithTarget:(id)target selectorName:(NSString *)selectorName
{
    NSMethodSignature *signature;
    NSInvocation      *invocation;
    SEL                sel;
    BOOL               requiresRegistration = NO;
    
    // NSLog(@"GETTING SELECTOR %@", selectorName);
    sel = NSSelectorFromString(selectorName);
    
    if(!sel)
    {
        // NSLog(@"REGISTERING SELECTOR");
        const char *name = [selectorName cString];
        
        sel = sel_register_name(name);

        if(!sel)
        {
            [NSException raise:STInternalInconsistencyException
                         format:@"Unable to register selector '%@'",
                                selectorName];
            return nil;
        }
        requiresRegistration = YES;
    }
    
    signature = [target methodSignatureForSelector:sel];

    /* FIXME: this is workaround for gnustep DO bug (hight priority) */

    if(requiresRegistration)
    {
        // NSLog(@"REGISTERING SELECTOR TYPES");
        sel = sel_register_typed_name([selectorName cString], [signature methodReturnType]);
        // NSLog(@"REGISTERED %@", NSStringFromSelector(sel));
        
    }

    if(!signature)
    {
        [NSException raise:STInternalInconsistencyException
                     format:@"No method signature for selector '%@' for "
                            @"receiver of type %@",
                            selectorName,[target className]];
        return nil;
    }
  
    invocation = [NSInvocation invocationWithMethodSignature:signature];

    [invocation setSelector:sel];
    [invocation setTarget:target];

    return invocation;
}

+ invocationWithTarget:(id)target selector:(SEL)selector
{
    NSMethodSignature *signature;
    NSInvocation      *invocation;
    
    signature = [target methodSignatureForSelector:selector];


    if(!signature)
    {
        [NSException raise:STInternalInconsistencyException
                     format:@"No method signature for selector '%@' for "
                            @"receiver of type %@",
                            NSStringFromSelector(selector),[target className]];
        return nil;
    }
  
    invocation = [NSInvocation invocationWithMethodSignature:signature];

    [invocation setSelector:selector];
    [invocation setTarget:target];

    return invocation;
}

- (void)setArgumentAsObject:(id)anObject atIndex:(int)anIndex
{
    const char *type;
    void *value;
    
    type = [[self methodSignature] getArgumentTypeAtIndex:anIndex];
    value = NSZoneMalloc(STMallocZone,objc_sizeof_type(type));

    STGetValueOfTypeFromObject(value, type, anObject);

    [self setArgument:(void *)value atIndex:anIndex];
    NSZoneFree(STMallocZone,value);
}


- (id)getArgumentAsObjectAtIndex:(int)anIndex
{
    const char *type;
    void *value;
    id    object;
    
    type = [[self methodSignature] getArgumentTypeAtIndex:anIndex];

    value = NSZoneMalloc(STMallocZone,objc_sizeof_type(type));
    [self getArgument:value atIndex:anIndex];

    object = STObjectFromValueOfType(value,type);
    
    NSZoneFree(STMallocZone,value);
    
    return object;
}
- (id)returnValueAsObject
{
    const char *type;
    int   returnLength;
    void *value;
    id    returnObject = nil;
    
    NSMethodSignature *signature = [self methodSignature];

    type = [signature methodReturnType];
    returnLength = [signature methodReturnLength];

    NSDebugLLog(@"STSending",
               @"  return type '%s', buffer length %i",type,returnLength);

    if(returnLength!=0)
    {
        value = NSZoneMalloc(STMallocZone,returnLength);
        [self getReturnValue:value];
                           
        if( *type == _C_VOID )
        {
            returnObject = [self target];
        }
        else
        {
            returnObject = STObjectFromValueOfType(value, type);
        }

        NSZoneFree(STMallocZone,value);
        NSDebugLLog(@"STSending",
                    @"  returned object %@",returnObject);
    }
    else
    {
        returnObject = [self target];
    }

    return returnObject;
}
@end

