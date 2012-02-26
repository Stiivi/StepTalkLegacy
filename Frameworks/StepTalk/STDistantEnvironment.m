#import "STDistantEnvironment.h"

#import <Foundation/NSException.h>
#import <Foundation/NSNotification.h>
#import <Foundation/NSConnection.h>
#import <Foundation/NSDistantObject.h>

#import <Foundation/NSString.h>

@implementation STDistantEnvironment
+ environmentWithName:(NSString *)name host:(NSString *)host;
- initWithName:(NSString *)name host:(NSString *)host
{
    self = [super init];

    distantName = RETAIN(name);
    distantHost = RETAIN(host);
    
    [self connect];
    
    return self;
}

- (STConversation *)createConversation;

- (void)connect
{
    environment = (NSDistantObject *)[NSConnection rootProxyForConnectionWithRegisteredName:distantName
                                                                                       host:distantHost];
    if(!environment)
    {
        [NSException  raise:@"STDistantEnvironmentException"
                     format:@"Unable to get distant environment object from server '%@'", distantName];
        return;
    }

    RETAIN(environment);
    // [(NSDistantObject *)simulator setProtocolForProxy:@protocol(AFSimulator)];

    [[NSNotificationCenter defaultCenter]
            addObserver:self
            selector:@selector(_connectionDidDie:)
            name:NSConnectionDidDieNotification
            object:[environment connectionForProxy]];
}

- (STConversation *)createConversationProxy
{
    return [environment createConversation];
}
@end
