" listFonts.st

    Example that will create a 'rtf file containing smaples of all available 
    fonts.

"

[| :text

main

    | fontManager |

    Environment loadModule:'AppKit'.

    text := NSTextView alloc initWithFrame:NSNullRect.
    text setRichText:YES.

    fontManager := NSFontManager sharedFontManager.

    (fontManager availableFontFamilies) 
    do: [ :font |
        self addFontSample:font
    ].

    text writeRTFDToFile:'Fonts.rtf' atomically:YES.

    ^nil
!    

addFontSample:fontName
    
    | attr font |

    Transcript showLine:fontName.

    attr := NSMutableDictionary dictionary.
    font := (NSFont fontWithName:fontName size:36).
    
    (font isNil) ifFalse:
    [
    attr setObject:font
    
             forKey:NSFontAttributeName.

    text setTypingAttributes:attr.
    text insertText:(fontName,'\n').
    ].
    ^self


]
