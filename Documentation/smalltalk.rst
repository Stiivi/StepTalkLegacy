Smalltalk language extensions to NSObjects
------------------------------------------

Smalltalk script can be list of methods or just list of statements. List of
statements is like single method without method name.

List of methods
---------------

Source begins with ``[|`` (left square bracket) and is followed by optional
list of script variables. Methods are separated by ``!`` and are encoles by
``]`` (right square bracket).

Example without vars:

.. code-block:: smalltalk

    [| 
        main
            self other.
            ^self
        !
        other
            Transcript showLine:'This is other'.
        !
     ]

Example with vars:

.. code-block:: smalltalk

    [| :var1 :var2

        main
            "Your code here...".
            ^self
        !
        other
            "Your code here...".
            ^self
        !
     ]


Simple script is just list of smalltalk statements. It is like contents of one
method.

Why source begins with '[|' and not just '['? 
---------------------------------------------

Look at this example:

.. code-block:: smalltalk

    [one two three]

It has more meanings. It can be list of methods with one method named 'one'.
'two' is target object and 'three' is a message or simple statement with block.
'one' is target object and 'two' and 'three' are messages.

Symbolic selectors
------------------

In StepTalk symbolic selectors are mapped to normal selectors.

Comparison operators (NSObject):

+----------------+-----------------------+
|  Symb. sel.    | Real sel.             |
+================+=======================+
| =              |isEqual:               |
+----------------+-----------------------+
| ==             |isSame:                |
+----------------+-----------------------+
| ~=             |notEqual:              |
+----------------+-----------------------+
| ~~             |notSame:               |
+----------------+-----------------------+
| <              |isLessThan:            |
+----------------+-----------------------+
| >              |isGreatherThan:        |
+----------------+-----------------------+
| <=             |isLessOrEqualThan:     |
+----------------+-----------------------+
| >=             |isGreatherOrEqualThan: |
+----------------+-----------------------+

+------------------+-----------+-----------------+-----------------------------------+
| Target type      | Selector  | Argument Type   | Real Selector                     |
+==================+===========+=================+===================================+
| NSArray          | @         | NSNumber        | objectAtIndex:                    |
+------------------+-----------+-----------------+-----------------------------------+
| NSArray          | ,         | any             | arrayByAddingObject:              |
+------------------+-----------+-----------------+-----------------------------------+
| NSArray          | \+        | any             | arrayByAddingObject:              |
+------------------+-----------+-----------------+-----------------------------------+
| NSMutableArray   | +=        | any             | addObject:                        |
+------------------+-----------+-----------------+-----------------------------------+
| NSMutableArray   | -=        | any             | removeObject:                     |
+------------------+-----------+-----------------+-----------------------------------+
| NSDictionary     | @         | any             | objectForKey:                     |
+------------------+-----------+-----------------+-----------------------------------+
| NSUserDefaults   | @         | any             | objectForKey:                     |
+------------------+-----------+-----------------+-----------------------------------+
| NSString         | ,         | NSString        | stringByAppendingString:          |
+------------------+-----------+-----------------+-----------------------------------+
| NSString         | /         | NSString        | stringByAppendingPathComponent:   |
+------------------+-----------+-----------------+-----------------------------------+
| NSString         | @         | NSNumber        | characterAtIndex:                 |
+------------------+-----------+-----------------+-----------------------------------+
| NSMutableString  | +=        | NSString        | appendString:                     |
+------------------+-----------+-----------------+-----------------------------------+
| NSSet            | <         | NSSet           | isSubsetOfSet:                    |
+------------------+-----------+-----------------+-----------------------------------+
| NSMutableSet     | +=        | any             | addObject:                        |
+------------------+-----------+-----------------+-----------------------------------+
| NSMutableSet     | -=        | any             | removeObject:                     |
+------------------+-----------+-----------------+-----------------------------------+
| NSDate           | \-        | NSDate          | timeIntervalSinceDate:            |
+------------------+-----------+-----------------+-----------------------------------+
| NSNumber         | \+,-,*,/  | NSNumber        | add:,subtract:,multiply:,divide:  |
+------------------+-----------+-----------------+-----------------------------------+



Special selectors to create objects from two NSNumbers


+-----------+--------------+----------+------------------+
| Symb.sel. | Real sel.    | Result   | Methods          |
+===========+==============+==========+==================+
| <>        | rangeWith:   | range    | location, length |
+-----------+--------------+----------+------------------+
| @         | pointWith:   | point    | x, y             |
+-----------+--------------+----------+------------------+
| @@        | sizeWith:    | size     | width, height    |
+-----------+--------------+----------+------------------+

Examples:

.. code-block:: smalltalk

    str := 'This is string.'.
    substr := str substringWithRange: (8 <> 3)
    range := str rangeOfString: 'str'.
    newRange := ( (range location) <> 6).

Iterator and cycles
-------------------

To create a cycle, you may use `whileTrue:` or `whileFalse:` on NSBlock

.. code-block:: smalltalk

    conditionBlock whileTrue: toDoBlock.
    
To use a sequence of numbers, you may use `to:do:` or `to:step:do:` on NSNumber
    
.. code-block:: smalltalk

    min to: max do: block
    min to: max step: step do: block

Array iterators
---------------

Following methods will iterate through all objects in receiver.

* `do:` – Evaluate block for each object in array and return last evaluated
  expression
* `select:` – Create new array which will contain those objects from receiver,
  for which value of block was true
* `reject:` – Create new array which will contain those objects from receiver,
  for which value of block was false
* `collect:` – Create new array from block return values.
* `detect:` – Return first object for which block evaluation result is true.
  Othervise return nil.


Exception handling
------------------

If you want to handle an exception, you may do so by using blocks. You send
handler: message to guarded block.

.. code-block:: smalltalk

    guardedBlock handler: handlerBlock.
    
If exception happens in guarded block, then handler block is evaluated.
