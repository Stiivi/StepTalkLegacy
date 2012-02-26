#import "STEnvironmentProcess.h"

#import <Foundation/NSString.h>
#import <StepTalk/STEnvironment.h>
#import <StepTalk/STEnvironmentDescription.h>

@implementation STEnvironmentProcess
- initWithDescriptionName:(NSString *)descName
{
    STEnvironmentDescription *desc;
    
    self = [super init];

    if(descName)
    {
        NSLog(@"Creating environment from description '%@'", descName);
        desc = [STEnvironmentDescription descriptionWithName:descName];
        environment = [[STEnvironment alloc] initWithDescription:desc];
    }
    else
    {
        environment = [[STEnvironment alloc] initWithDefaultDescription];
    }
    
    /* FIXME: use some configurable mechanism */
    [environment setObject:environment forName:@"Environment"];
    [environment loadModule:@"SimpleTranscript"];

    return self;
}
- (void)dealloc
{
    RELEASE(environment);
    [super dealloc];
}
- (STConversation *)createConversation
{
    STConversation *conversation;
    
    conversation = [[STConversation alloc] initWithContext:environment
                                                  language:nil];
    /* FIXME: create list of open conversations */
    
    return AUTORELEASE(conversation);
}
@end
