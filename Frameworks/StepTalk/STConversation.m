/**
    STConversation
 
    Copyright (c) 2002 Free Software Foundation
 
    Written by: Stefan Urbanek
    Date: 2003 Sep 21
   
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

#import "STConversation.h"

#import <Foundation/NSDebug.h>
#import <Foundation/NSException.h>

#import "STEnvironment.h"
#import "STEngine.h"
#import "STLanguageManager.h"

@implementation STConversation
/** Creates a new conversation with environment created using default 
    description and default language. */
+ conversation
{
    STEnvironment *env = [STEnvironment environmentWithDefaultDescription];
    
    NSLog(@"DEPRECATED");
    return AUTORELEASE([[self alloc] initWithContext:env language:nil]);
}

- (bycopy id)resultByCopy
{
    return [self result];
}

- (id)runScriptFromString:(NSString *)aString
{
    NSLog(@"Warning: runScriptFromString: in STConversation is deprecated, use -interpretScript: and -returnVale");
    [self interpretScript:aString];
    return [self result];
}

/** Returns all languages that are known in the receiver. Should be used by
    remote calls instead of NSLanguage query which gives local list of
    languages. */
- (NSArray *)knownLanguages
{
    return [[STLanguageManager defaultManager] availableLanguages];
}

/** Creates a new conversation with environment created using default 
    description and language with name <var>langName</var>. */
+ conversationWithEnvironment:(STEnvironment *)env 
                   language:(NSString *)langName
{
    STConversation *c;
 
    NSLog(@"WARNING: +[STConversaion conversationWithEnvironment:language:] is deprecated, "
          @" use conversationWithContext:language: instead.");
 
    c = [[self alloc] initWithContext:env language:langName];
    return AUTORELEASE(c);
}

- initWithEnvironment:(STEnvironment *)env 
             language:(NSString *)langName
{
    NSLog(@"WARNING: -[STConversaion initWithEnvironment:language:] is deprecated, "
          @" use initWithContext:language: instead.");

    return [self initWithContext:env language:langName];
}

- initWithContext:(STContext *)aContext
         language:(NSString *)aLanguage
{
    STLanguageManager  *manager = [STLanguageManager defaultManager];
    self = [super init];

    NSDebugLLog(@"STConversation",@"Creating conversation %@", self);

    if(!aLanguage || [aLanguage isEqual:@""])
    {
        languageName = RETAIN([manager defaultLanguage]);
    }    
    else
    {
        languageName = RETAIN(aLanguage);
    }
    
    context = RETAIN(aContext);
    return self;
}

- (void)dealloc
{
    NSDebugLLog(@"STConversation",@"Deallocating conversation %@", self);
    RELEASE(languageName);
    RELEASE(context);
    RELEASE(engine);
    RELEASE(returnValue);
    [super dealloc];
}

- (void)_createEngine
{
    ASSIGN(engine,[STEngine engineForLanguage:languageName]);
}

- (void)setLanguage:(NSString *)newLanguage
{
    if(![newLanguage isEqual:languageName])
    {
        RELEASE(engine);
        engine = nil;
        ASSIGN(languageName, newLanguage);
    }
}

/** Return name of the language used in the receiver conversation */
- (NSString *)language
{
    return languageName;
}
- (STEnvironment *)environment
{
    NSLog(@"WARNING: -[STConversaion environment] is deprecated, "
          @" use -context instead.");

    return (STEnvironment *)context;
}
- (STContext *)context
{
    return context;
}

- (void)interpretScript:(NSString *)aString
{
    if(!engine)
    {
        [self _createEngine];
    }
    
    ASSIGN(returnValue, [engine interpretScript: aString 
                                      inContext: context]);
}
- (id)result
{
    return returnValue;
}
@end
