GNUstep/Cocoa classes additions
===============================

NSFileManager

.. code-block:: objective-c

    + (NSString *)homeDirectory

    + (NSString *)homeDirectoryForUser:(NSString *)user

    + (NSString *)openStepRootDirectory

    + (NSArray *)searchPathForDirectories:(int)dir 
                                inDomains:(int)domainMask
                              expandTilde:(BOOL)flag

    + (NSArray *)searchPathForDirectories:(int)dir inDomains:(int)domainMask

    + (NSString *)temporaryDirectory

    + (NSArray *)standardLibraryPaths

Example:

.. code-block:: objective-c

    NSFileManager searchPathForDirectories:NSLibraryDirectory 
                inDomains:(NSUserDomainMask or: NSLocalDomainMask)
                
                
