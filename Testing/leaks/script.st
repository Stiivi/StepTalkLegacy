[|

main
        | tval |

        tval := 1.
        tval to: 20000 do: [ :counter |
                self testme: counter.
        ].


!
testme: tval
        | retval |
        retval := tval + 1.
        ^retval

]
