| foo |


"foo is local variable"

foo := 'Foo'.

Transcript showLine:( 'This is foo : ', foo ).


" bar is created in environment as extern variable "

bar := 'Bar'.

Transcript showLine:( 'And this is bar: ', bar ).

