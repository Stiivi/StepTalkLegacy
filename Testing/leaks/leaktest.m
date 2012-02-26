#import <Foundation/NSAutoreleasePool.h>
#import <Foundation/NSString.h>
#import <Foundation/NSDebug.h>
#import <Foundation/NSException.h>

#import <StepTalk/StepTalk.h>

int main(void)
{
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    NSAutoreleasePool *innerPool;
    NSString          *theScript;
    NSString          *fname = @"script.st";
    STEnvironment     *env;
    STEngine          *engine;
    id                 result;
    
    theScript  = [NSString stringWithContentsOfFile:fname];

    GSDebugAllocationActive(YES);

    NSLog(@"allocated objects on starting script\n%s",GSDebugAllocationList(NO));

    env = [STEnvironment defaultScriptingEnvironment];
    engine = [STEngine engineForLanguageWithName:@"Smalltalk"];

    NS_DURING
        //innerPool = [NSAutoreleasePool new];
        result = [engine executeCode:theScript inEnvironment:env];
        //[innerPool release];
    NS_HANDLER
        /* handle the exception */
        NSLog(@"%@",localException);
    NS_ENDHANDLER
    
    //NSLog(@"change of allocated objects\n%s",GSDebugAllocationList(YES));
    printf("%s",GSDebugAllocationList(NO));

    [pool release];
}
