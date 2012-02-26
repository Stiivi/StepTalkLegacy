#import <Foundation/NSObject.h>

#import <StepTalk/STRemoteConversation.h>

@class STConversation;
@class STEnvironment;

@interface STEnvironmentProcess:NSObject<STEnvironmentProcess>
{
    STEnvironment *environment;
}
- initWithDescriptionName:(NSString *)descName;
@end
