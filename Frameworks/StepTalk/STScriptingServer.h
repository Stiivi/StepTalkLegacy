/* FIXME: not used! just an unimplemented idea.  (See NSDistant*)
*/
@interface STScriptingServer
{
    
}
+ serverWithRegisteredName:(NSString *)name
                      host:(NSString *)host;
- registerLocallyWithName:(NSString *)name;

- createConversation;
- conversationWithInfo:(NSDictionary*)dict;
@end
