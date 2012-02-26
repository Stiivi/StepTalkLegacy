manager := STLanguageManager defaultManager.

Transcript showLine:(manager description).

languages := manager availableLanguages.

Transcript showLine:'Available languages: ', (languages description).

engine := manager createEngineForLanguage:'Smalltalk'.

Transcript showLine:'Engine: ', (engine description).

engine interpretScript:'Transcript showLine:\'Hi\'.' inContext:Environment.
