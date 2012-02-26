/**
    STContext
    Scripting context
  
    Copyright (c) 2004 Free Software Foundation
  
    Written by: Stefan Urbanek <urbanek@host.sk>
    Date: 2004
   
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

#import "STContext.h"

#import "STScripting.h"
#import "STClassInfo.h"
#import "STEnvironmentDescription.h"
#import "STExterns.h"
#import "STFunctions.h"
#import "STBundleInfo.h"
#import "STObjCRuntime.h"
#import "STObjectReference.h"
#import "STUndefinedObject.h"

#import <Foundation/NSArray.h>
#import <Foundation/NSBundle.h>
#import <Foundation/NSDebug.h>
#import <Foundation/NSDictionary.h>
#import <Foundation/NSException.h>
#import <Foundation/NSSet.h>
#import <Foundation/NSString.h>
#import <Foundation/NSInvocation.h>

@implementation STContext
-init
{
    self = [super init];
    
    objectDictionary = [[NSMutableDictionary alloc] init];
    
    return self;
}

- (void)dealloc
{
    RELEASE(objectDictionary);
    RELEASE(parentContext);
    [super dealloc];
}

- (void)setParentContext:(STContext *)context
{
    ASSIGN(parentContext, context);
}
- (STContext *)parentContext
{
    return parentContext;
}

/**
   Enable or disable full scripting. When full scripting is enabled, 
   you may send any message to any object.
 */
- (void)setFullScriptingEnabled:(BOOL)flag
{
    fullScripting = flag;
}

/**
   Returns YES if full scripting is enabled.
 */
- (BOOL)fullScriptingEnabled
{
    return fullScripting;
}

/**
   <p>
   Enable or disable creation of unknown objects. Normally you get nil if you
   request for non-existant object. If <var>flag</var> is YES
   then by requesting non-existant object, name for that object is created
   and it is set no STNil.
    </p>
   <p>
  Note: This method will be probably removed (moved to Smalltalk language bundle).
   </p>
 */
-(void)setCreatesUnknownObjects:(BOOL)flag
{
    createsUnknownObjects = flag;
}

/**
   Returns YES if unknown objects are being created.
 */
-(BOOL)createsUnknownObjects
{
    return createsUnknownObjects;
}

/**
    Returns a dictionary of all named objects in the environment.
*/
- (NSMutableDictionary *)objectDictionary
{
    return objectDictionary;
}

/* ----------------------------------------------------------------------- 
   Objects
   ----------------------------------------------------------------------- */

/**
    Register object <var>anObject</var> with name <var>objName</var>.
 */

- (void)setObject:(id)anObject
          forName:(NSString *)objName
{
    if(anObject)
    {
        [objectDictionary setObject:anObject forKey:objName];
    }
    else
    {
        [objectDictionary setObject:STNil forKey:objName];
    }
}

/**
    Remove object named <var>objName</var>.
  */
- (void)removeObjectWithName:(NSString *)objName
{
    [objectDictionary removeObjectForKey:objName];
}

/**
    
  */
- (void)addNamedObjectsFromDictionary:(NSDictionary *)dict
{
    [objectDictionary addEntriesFromDictionary:dict];
}

/**
    Return object with name <var>objName</var>. If object is not found int the
    object dictionary, then object finders are used to try to find the object.
    If object is found by an object finder, then it is put into the object
    dicitonary. If there is no object with given name, <var>nil</var> is 
    returned.
  */

- (id)objectWithName:(NSString *)objName
{
    id obj;
    
    obj = [objectDictionary objectForKey:objName];

    if(!obj)
    {
        return [parentContext objectWithName:objName];
    }

    return obj;
}

- (STObjectReference *)objectReferenceForObjectWithName:(NSString *)name
{
    STObjectReference *ref;
    id                 target = objectDictionary;
        
    if( ![self objectWithName:name] )
    {
        if([[self knownObjectNames] containsObject:name])
        {
            /* FIXME: What I meant by this? */
            target = nil;
        }
        else if(createsUnknownObjects)
        {
            [objectDictionary setObject:STNil forKey:name];
        }
    }

    ref = [[STObjectReference alloc] initWithIdentifier:name
                                                 target:target];
    
    return AUTORELEASE(ref);
}

- (NSArray *)knownObjectNames
{
    NSMutableArray *array = [NSMutableArray array];
    
    [array addObjectsFromArray:[objectDictionary allKeys]];
    
    return [NSArray arrayWithArray:array];
}
@end
