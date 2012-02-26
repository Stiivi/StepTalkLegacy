"NSText test"

Environment loadModule:'AppKit'.

tattr := NSMutableDictionary dictionary.
tattr setObject:(NSFont fontWithName:'Times' size:10) 
         forKey:NSFontAttributeName.

hattr := NSMutableDictionary dictionary.
hattr setObject:(NSFont fontWithName:'Helvetica' size:10) 
         forKey:NSFontAttributeName.

text := NSTextView alloc initWithFrame:NSNullRect.
text setRichText:YES.

text setTypingAttributes:tattr.
text insertText:'This is Times\n'.

text setTypingAttributes:hattr.
text insertText:'This is Helvetica\n'.

text writeRTFDToFile:'Test.rtf' atomically:YES.
