"List all available printers"

| printers |

Environment loadModule:'AppKit'.

printers := NSPrinter printerTypes.
printers do: 
[ :printer |
    Transcript showLine: printer.
]
