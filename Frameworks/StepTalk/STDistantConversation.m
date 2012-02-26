/* FIXME: not used! just an unimplemented idea. 
*/
#import "STDistantConversation.h"

#import <Foundation/NSException.h>
#import <Foundation/NSNotification.h>
#import <Foundation/NSConnection.h>
#import <Foundation/NSDistantObject.h>


@implementation STDistantConversation
- initWithEnvironment:(STEnvironment *)env 
             language:(NSString *)langName
{
    self = [super init];

    if(!env)
    {
        [NSException raise:@"STConversationException"
                     format:@"Unspecified environment for a distant conversation"];
        [self dealloc];
        return nil;
    }

    if(!langName || [langName isEqual:@""])
    {
        languageName = RETAIN([STLanguage defaultLanguageName]);
    }    
    else
    {
        languageName = RETAIN(langName);
    }
    
    environment = RETAIN(env);
    [self createProxy];
              
    
    return self;
}

- (void)dealloc
{
    RELEASE(languageName);
    RELEASE(environment);
    [super dealloc];
}

- (void)setLanguage:(NSString *)newLanguage
{
    [proxy setLanguage:newLanguage];
}

/** Return name of the language used in the receiver conversation */
- (NSString *)language
{
    return [proxy languageName];
}
- (STEnvironment *)environment
{
    return environment;
}
- (id)runScriptFromString:(NSString *)aString
{
    return [proxy runScriptFromString:aString];
}
- (BOOL)isResumable
{
    return YES;
}

- (void)connectionDidDie:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    proxy = nil;
    NSLog(@"Connection did die");
}

- (BOOL)createProxy
{
    NSConnection *connection;
    
    proxy = [environment createConversationProxy];

    if(!proxy)
    {
        return NO;
    }
    connection = [proxy connectionForProxy];
    
    [[NSNotificationCenter defaultCenter]
                 addObserver: self
                    selector: @selector(connectionDidDie:)
                        name: NSConnectionDidDieNotification 
                      object: connection];
    return YES;
}

- (BOOL)resume
{
    if(proxy)
    {
        NSLog(@"Can not resume: already connected");
        return NO;
    }
    return [self creatProxy];
}
@end
