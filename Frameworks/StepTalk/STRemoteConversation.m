/* FIXME: not used! just an unimplemented idea. 
*/
#import "STRemoteConversation.h"

#import <Foundation/NSException.h>
#import <Foundation/NSNotification.h>
#import <Foundation/NSConnection.h>
#import <Foundation/NSDistantObject.h>

#import "STEnvironment.h"

@implementation STRemoteConversation
- initWithEnvironmentName:(NSString *)envName
                     host:(NSString *)host
                 language:(NSString *)langName
{
    self = [super init];

    if(!envName)
    {
        [NSException raise:@"STConversationException"
                     format:@"Unspecified environment name for a distant conversation"];
        [self dealloc];
        return nil;
    }

    environmentName = RETAIN(envName);
    hostName = RETAIN(host);
    
    [self open];
    
    return self;
}
- (void)open
{
    NSString *envProcName;
    
    if(connection)
    {
        [NSException raise:@"STConversationException"
                     format:@"Unable to open conversation: already opened."];
        return;
    }
        
    envProcName = [NSString stringWithFormat:@"STEnvironment:%@", 
                                                environmentName];

    connection = [NSConnection connectionWithRegisteredName:envProcName 
                                                       host:hostName];

    RETAIN(connection);

    if(!connection)
    {
        [NSException raise:@"STConversationException"
                     format:@"Connection failed for environment '%@'",
                                environmentName];
        return;
    }

    environmentProcess = RETAIN([connection rootProxy]);
    proxy = RETAIN([environmentProcess createConversation]);
    [proxy setProtocolForProxy:@protocol(STConversation)];
    
    [[NSNotificationCenter defaultCenter]
                 addObserver: self
                    selector: @selector(connectionDidDie:)
                        name: NSConnectionDidDieNotification 
                      object: connection];
}
- (void)close
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    RELEASE(proxy);
    proxy = nil;
    RELEASE(environmentProcess);
    environmentProcess = nil;
    [connection invalidate];
    RELEASE(connection);
    connection = nil;
    return;
}

- (void)dealloc
{
    /* After this we should not have any connection, environmentProcess 
       nor proxy */
    [self close];
    RELEASE(environmentName);
    RELEASE(hostName);

    [super dealloc];
}

- (void)setLanguage:(NSString *)newLanguage
{
    [proxy setLanguage:newLanguage];
}

/** Return name of the language used in the receiver conversation */
- (NSString *)language
{
    return [proxy language];
}
- (STEnvironment *)environment
{
    /* FIXME: return local description */
    return nil;
}
- (void)interpretScript:(NSString *)aString
{
    [proxy interpretScript:aString];
}
- (id)result
{
    return [proxy result];
}
- (bycopy id)resultByCopy
{
    return [proxy resultByCopy];
}

- (void)connectionDidDie:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    if(proxy)
    {
        NSLog(@"Connection did die for %@ (%@)", self, environmentName);
    }
    else
    {
        NSLog(@"Closing conversation (%@) with %@", self, environmentName);
    }

    proxy = nil;
    environmentProcess = nil;
    RELEASE(connection);
    connection = nil;
}
@end
