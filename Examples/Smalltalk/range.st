" Range example "
|str substr range|

str := 'I like apples and plums.'.

Transcript showLine: ('String is : \'', str, '\'').

substr := str substringWithRange: (7 <> 5).

Transcript showLine: ('Substring at location 7 with length 5 is \'', 
                                                            substr, '\'').

range := str rangeOfString: 'tomato'.

((range location) = NSNotFound) 
ifTrue:
    [ Transcript showLine: 'Tomato not found' .].

range := str rangeOfString: 'plum'.

Transcript showLine: ('Location of \'plum\' is ', ((range location) stringValue), 
                      ' and length is ',  ((range length) stringValue)).

range := ( (range location) <> 5).

Transcript showLine: ('Substring with modified range \'', 
                        (str substringWithRange:range), '\'').
