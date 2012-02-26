Smalltalk examples
------------------

  Smalltalk examples are included in Smalltalk directory.


  math.st
      Simple example.

      > stexec math.st


  hello.st
      Example to show block closures, symbolic selectors and ussage of arguments.

      > stexec hello.st
      > stexec hello.st World


  createFile.st

      Try to create a file. Example to show how the restricted scriptiong works.

      This will work fine:
      > stexec createFile.st

      This would not:
      > stexec --environment Safe createFile.st


  exception.st

      Same as createFile.st but handles the exception. 

      This will work fine:
      > stexec exception.st

      This will end with handled exception:
      > stexec --environment Safe exception.st

  listDir.st
  
      List content of current directory.
      
      > stexec listDir.st

  plparse.st, pldes.st

      GNUstep tools written in smalltalk

      > stexec plparse.st file1 file2 ...



Scriptable server example
-------------------------

  To compile type

      > make

  Then run server

      > opentool Server

  Then from same directory, but in another terminal try

      > stalk Server talkToServer.st
      > stalk Server talkToServer.st "Hi there!"
