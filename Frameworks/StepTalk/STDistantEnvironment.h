/* FIXME: not used! just an unimplemented idea. 
*/

#import <StepTalk/STEnvironment.h>

@interface STDistantEnvironment:NSObject
{
    NSStrnig *distantName;
    NSStrnig *distantHost;
    NSDistantObject *environment;
}
+ environmentWithName:(NSString *)name host:(NSString *)host;
- initWithName:(NSString *)name host:(NSString *)host;

- (STConversation *)createConversation;
@end
