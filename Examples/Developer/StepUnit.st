"
  @file: StepUnit.st
  @author: Mateu Batle mateu.batle@tragnarion.com
  @brief Very simple unit testing framework done in StepTalk
  for testing Objective C applications
  @brief $Id: StepUnit.st 19563 2004-06-20 11:40:54Z stefanu $
  
  StepUnit is released under the terms of the LGPL license.
  (check http://www.gnu.org/licenses/gpl.txt)  

  Help:
  
  Testing framework is executed running stexec StepUnit, or
  directly StepUnit.sh. This script scans the currend diretory recursively 
  and runs every script whose filename matches 'test*.st'. It provides in 
  the environment an object called stepunit which has some useful methods 
  for testing. Here is a list of this methods:
  
  - should: val. Tests result of boolean expression which must be true for 
  test ok.
  - shouldNot: val. Tests result of boolean expression which must be false 
  for test ok.
  - shouldBeEqual: left to: right. Tests objects are the same.
  - shouldRaise: exp. Exp must be a block. Runs the block, which must throw 
  exception for test ok.
  - shouldBeEmpty: object. Object must be nil, or object isEmpty must return 
  true for test ok.
  - shouldNotBeEmpty: object

  All methods can be added a 'desc: string' argument, which is recommended to 
  use to identify the test.
  
  Each test script just has to run the test code and call the testing methods
  specified before (on the object stepunit already present in the environment).
  You should also load modules in the environment to access new classes, etc.
  if needed (with Environment loadModule: 'modulename'). Test example:
  
  res := 2 + 2.
  stepunit should: (res = 4) desc: '2 + 2 works'  
    
"

[| 
   :numTestFilesOK
   :numTestFilesFailed
   :numTestsFailed 
   :numTestsOK 
   :numTotalFailed
   :numTotalOK
   :env
   :conversation
   :fm

main
    "*** Initialize counters ***"
    numTestsFailed := 0.
    numTestsOK := 0.
    numTotalFailed := 0.
    numTotalOK := 0.
    numTestFilesFailed := 0.
    numTestFilesOK := 0.
    
    "*** Add some classes ***"
    classes := (NSMutableArray alloc) init.
    classes += 'STEnvironment'.
    classes += 'STConversation'.
    Environment addClassesWithNames: classes.

    "*** Store object in the environment ***"
    env := Environment.
    env setObject: self forName:'stepunit'.
    env setFullScriptingEnabled: YES.
    
    "*** Create conversation ***"
    conv := STConversation conversationWithEnvironment: env language: 'Smalltalk'.    
    conv setLanguage: 'Smalltalk'.

    "*** Execute all tests here ***"
    fm := NSFileManager defaultManager.
    path := (fm currentDirectoryPath) stringByStandardizingPath.
    self runTests: path.

    "*** Summary of running test ***"    
    self showSummary.
    
    ^ self

!

runTests: path
    | dirent attr |
    (((path lastPathComponent) substringToIndex: 1) = '.')
        ifFalse: 
	[
	    Transcript showLine: '*** Scanning for tests in directory ', (path), ' ***'.
	    dirent := fm directoryContentsAtPath: path.
	    dirent do:
		[ :file |
		    attr := fm fileAttributesAtPath: (path / file) traverseLink: NO.
		    filetype := (attr @ 'NSFileType').
		    (filetype isEqualToString: 'NSFileTypeDirectory')
			ifTrue: 
			[		 
			    fm changeCurrentDirectoryPath: (path / file).
			    self runTests: (path / file).
			    fm changeCurrentDirectoryPath: path.
			]
			ifFalse: 
			[
			    (((file pathExtension) = 'st') and: ((file lowercaseString) hasPrefix: 'test'))
				ifTrue: [self executeTest: (path / file)].
			]
		].
	    ^self
	]

!

executeTest: path
    numTestsFailed := 0.
    numTestsOK := 0.    
    Transcript show: '*** Test Case '.
    Transcript show: (numTestFilesOK + numTestFilesFailed + 1).
    Transcript showLine: ': ', path, ' start ***'.
    code := NSString stringWithContentsOfFile: path.
    res := conv runScriptFromString: code.
    Transcript showLine: '*** Test Case ', path, ' finish ***'.
    (numTestsFailed = 0)
        ifTrue: 
	[
	    numTestFilesOK := numTestFilesOK + 1.
	]
	ifFalse:
	[
	    numTestFilesFailed := numTestFilesFailed + 1.
	].
    ^self


!

showSummary
    Transcript showLine: '***** SUMMARY *****'.
    Transcript showLine: 'Name', '	', 'Failed', '	', 'OK', '	', 'Total'.
    
    Transcript show: 'Files', '	'.
    Transcript show: numTestFilesFailed.
    Transcript show: '	'.
    Transcript show: numTestFilesOK.
    Transcript show: '	'.
    Transcript show: (numTestFilesFailed + numTestFilesOK).
    Transcript showLine: nil.

    Transcript show: 'Tests', '	'.
    Transcript show: numTotalFailed.
    Transcript show: '	'.
    Transcript show: numTotalOK.
    Transcript show: '	'.
    Transcript show: (numTotalFailed + numTotalOK).
    Transcript showLine: ''.

    ^self


""" Methods for unit testing """

!

should:val
    val ifFalse: [self testfail] ifTrue: [self testok].
    ^self

!

should:val desc*esc
    val ifFalse: [self testfail: desc] ifTrue: [self testok: desc].
    ^self
    
!

shouldNot: val
    val ifTrue: [self testfail] ifFalse: [self testok].
    ^self
    
!

shouldNot: val desc: desc
    val ifTrue: [self testfail: desc] ifFalse: [self testok: desc].
    ^self

!

shouldBeEqual: left to: right
    (left = right) ifFalse: [self testfail] ifTrue: [self testok].
    ^self

!

shouldBeEqual: left to: right desc: desc
    (left = right) ifFalse: [self testfail: desc] ifTrue: [self testok: desc].
    ^self

!

shouldRaise: exp
    flag := false.
    desc := 'exception not raised'.
    exp
        handler:
    [ :exception |
        flag := true.
	desc := (exception name), ' ', (exception reason).
    ].
    self should: flag desc: desc.
    ^self

!

shouldRaise: exp desc: desc
    flag := false.
    desc2 := desc, ' exception not raised'.
    exp
        handler:
    [ :exception |
        flag := true.
	desc := desc, ' ', (exception name), ' ', (exception reason).
    ].
    self should: flag desc: desc.
    ^self

!

shouldBeEmpty: object  
    (object = nil) 
        ifFalse: 
	[
	    (object respondsToSelector: #isEmpty)
	        ifFalse: [self testfail: 'object not responds to isEmpty, assumed not empty'.]
		ifTrue:  [self should: (object isEmpty)  desc: 'object empty'.]
	]
	ifTrue: 
	[
	    self testok: 'object empty'
	].
    ^self
    
!

shouldBeEmpty: object desc: desc
    (object = nil) 
        ifFalse: 
	[
	    (object respondsToSelector: #isEmpty)
	        ifFalse: [self testfail: desc]
		ifTrue:  [self should: (object isEmpty)  desc: desc]
	]
	ifTrue: 
	[
	    self testok: desc
	].
    ^self

!

shouldNotBeEmpty: object
    (object = nil) 
        ifFalse: 
	[
	    (object respondsToSelector: #isEmpty)
	        ifFalse: [self testok: 'object not responds to isEmpty, assumed not empty']
		ifTrue:  [self shouldNot: (object isEmpty)  desc: 'object empty']
	]
        ifTrue: 	
	[
	    self testfail: 'object not empty'.
	].
    ^self

!

shouldNotBeEmpty: object desc: desc
    (object = nil) 
        ifFalse: 
	[
	    (object respondsToSelector: #isEmpty)
	        ifFalse: [self testok: desc]
		ifTrue:  [self shouldNot: (object isEmpty)  desc: desc].
	]
        ifTrue: 
	[
	    self testfail: desc.
	].
    ^self

!

testfail  
    ^ self testfail: 'NO DESCRIPTION'

!

testfail: desc
    numTotalFailed := numTotalFailed + 1.
    numTestsFailed := numTestsFailed + 1.
    Transcript showLine: 'TEST FAILED: ', desc.
    ^nil

!

testok
    ^ self testok: 'NO DESCRIPTION'
    
!

testok: desc
    numTotalOK := numTotalOK + 1.
    numTestsOK := numTestsOK + 1.
    Transcript showLine: 'TEST OK: ', desc.
    ^ self

]
