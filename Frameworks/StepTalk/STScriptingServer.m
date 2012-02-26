/* FIXME: not used! just an unimplemented idea.  (See NSDistant*)
*/
@implementation STScriptingServer
{
    
}
+ serverWithRegisteredName:(NSString *)name
                      host:(NSString *)host
{
    return [STDistantScriptingServer serverWithRegisteredName:name host:host];
}
- registerLocallyWithName:(NSString *)name
{
    NSLog(@"Not implemented: registerLocallyWithName");
}

- createConversation;
- conversationWithInfo:(NSDictionary*)dict;
@end

@implementation STLocalScriptingServer
{
    
}
+ serverWithRegisteredName:(NSString *)name
                      host:(NSString *)host;
- registerLocallyWithName:(NSString *)name;

- createConversation;
- conversationWithInfo:(NSDictionary*)dict;
@end

@implementation STDistantScriptingServer
{
    
}
+ serverWithRegisteredName:(NSString *)name
                      host:(NSString *)host;
- registerLocallyWithName:(NSString *)name;

- createConversation;
- conversationWithInfo:(NSDictionary*)dict;
@end
