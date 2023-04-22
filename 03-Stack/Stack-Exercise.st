!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'emptySentenceFinder nonEmptySentenceFinder emptyPrefix prefixWithEmptySpaces lowercasePrefixContainedIn2Sentences uppercasePrefixContainedIn1Sentence sentencesThatBeginWithLowercasePrefix prefixThatNoSentenceBeginsWith sentencesThatBeginWithUppercasePrefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TS 4/22/2023 16:58:06'!
test01CannotSearchAnEmptyPrefix

	self
		assertThatSearchingThePrefix: emptyPrefix
		inSentenceFinder: emptySentenceFinder
		raisesErrorWithDescription: SentenceFinderByPrefix emptyPrefixErrorDescription! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TS 4/22/2023 16:58:06'!
test02CannotSearchAPrefixWithEmptySpaces

	self
		assertThatSearchingThePrefix: prefixWithEmptySpaces
		inSentenceFinder: emptySentenceFinder
		raisesErrorWithDescription: SentenceFinderByPrefix prefixWithSpacesErrorDescription! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TS 4/22/2023 17:00:23'!
test03findsSentencesWithLowercasePrefix

	self
		assertThatSearchingThePrefix: lowercasePrefixContainedIn2Sentences
		inSentenceFinder: nonEmptySentenceFinder
		resultsInSentences: sentencesThatBeginWithLowercasePrefix! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TS 4/22/2023 17:00:40'!
test04findsSentencesWithUppercasePrefix

	self
		assertThatSearchingThePrefix: uppercasePrefixContainedIn1Sentence 
		inSentenceFinder: nonEmptySentenceFinder
		resultsInSentences: sentencesThatBeginWithUppercasePrefix ! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TS 4/22/2023 17:02:48'!
test05emptySentenceFinderShouldNotFindAnySentence

	self assertThatNoSentencesAreFoundWhenSearchingThePrefix: lowercasePrefixContainedIn2Sentences inSentenceFinder: emptySentenceFinder.
	self assertThatNoSentencesAreFoundWhenSearchingThePrefix: uppercasePrefixContainedIn1Sentence inSentenceFinder: emptySentenceFinder.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TS 4/22/2023 17:04:13'!
test06prefixNotContainedInAnySentenceShouldNotBeFound

	self assertThatNoSentencesAreFoundWhenSearchingThePrefix: prefixThatNoSentenceBeginsWith inSentenceFinder: nonEmptySentenceFinder! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'TS 4/22/2023 16:59:17'!
setUp

	emptySentenceFinder := SentenceFinderByPrefix withSentences: OrderedCollection new.
	nonEmptySentenceFinder := SentenceFinderByPrefix withSentences: #('winter is coming' 'winning is everything' 'The winds of Winter' 'Winter is here').
	
	emptyPrefix := ''.
	prefixWithEmptySpaces := 'winter is'.
	
	lowercasePrefixContainedIn2Sentences := 'win'.
	sentencesThatBeginWithLowercasePrefix := #('winter is coming' 'winning is everything').

	uppercasePrefixContainedIn1Sentence := 'Win'.
	sentencesThatBeginWithUppercasePrefix := #('Winter is here').
	
	prefixThatNoSentenceBeginsWith := 'Hola'.! !


!SentenceFinderByPrefixTest methodsFor: 'auxiliary' stamp: 'TS 4/22/2023 17:04:28'!
assertThatNoSentencesAreFoundWhenSearchingThePrefix: aPrefixToSearch inSentenceFinder: aSentenceFinder

	self assertThatSearchingThePrefix: aPrefixToSearch inSentenceFinder: aSentenceFinder resultsInSentences: OrderedCollection new! !

!SentenceFinderByPrefixTest methodsFor: 'auxiliary' stamp: 'TS 4/22/2023 16:58:35'!
assertThatSearchingThePrefix: aPrefixToTrySearching inSentenceFinder: aSentenceFinder raisesErrorWithDescription: anErrorDescription

	self
		should: [ aSentenceFinder selectSentencesWithPrefix: aPrefixToTrySearching ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = anErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'auxiliary' stamp: 'TS 4/22/2023 16:58:28'!
assertThatSearchingThePrefix: aPrefixToSearch inSentenceFinder: aSentenceFinder resultsInSentences: aSentenceCollection

	| foundSentences |
	
	foundSentences := aSentenceFinder selectSentencesWithPrefix: aPrefixToSearch.
	
	self assert: foundSentences size = aSentenceCollection size.
	self assert: (foundSentences includesAllOf: aSentenceCollection)! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'TS 4/21/2023 20:21:09'!
initialize

	state := EmptyStackState new! !


!OOStack methodsFor: 'accessing' stamp: 'TS 4/21/2023 20:24:43'!
isEmpty

	^state isKindOf: EmptyStackState! !

!OOStack methodsFor: 'accessing' stamp: 'TS 4/21/2023 20:25:39'!
size

	^state numberOfElementsAdded! !

!OOStack methodsFor: 'accessing' stamp: 'TS 4/21/2023 20:25:47'!
top

	^state lastElementAdded! !


!OOStack methodsFor: 'modification' stamp: 'TS 4/21/2023 20:33:29'!
pop

	| poppedElement |

	poppedElement := state lastElementAdded.
	state := state previousState.
	^poppedElement
	! !

!OOStack methodsFor: 'modification' stamp: 'TS 4/21/2023 20:30:27'!
push: anElementToBePushed

	state := NonEmptyStackState withPreviousState: state andNewElement: anElementToBePushed ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'sentenceStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'TS 4/22/2023 17:11:33'!
initializeWithSentences: aSentenceOrderedCollection

	sentenceStack := OOStack new.
	self addSentencesToStack: aSentenceOrderedCollection! !


!SentenceFinderByPrefix methodsFor: 'enumerating' stamp: 'TS 4/22/2023 17:09:50'!
selectSentencesWithPrefix: aPrefix
	
	self assertIsValidPrefix: aPrefix.

	sentenceStack isEmpty ifTrue: [ ^OrderedCollection new ] ifFalse: [ ^self selectSentencesFromNonEmptyStackWithPrefix: aPrefix ]! !


!SentenceFinderByPrefix methodsFor: 'validation' stamp: 'TS 4/22/2023 16:20:13'!
assertIsValidPrefix: aPrefix

	aPrefix isEmpty ifTrue: [ self error: self class emptyPrefixErrorDescription ].
	(aPrefix includes: Character space) ifTrue: [ self error: self class prefixWithSpacesErrorDescription ]! !


!SentenceFinderByPrefix methodsFor: 'private methods' stamp: 'TS 4/22/2023 17:11:33'!
addSentencesToStack: aSentenceOrderedCollection

	^ aSentenceOrderedCollection do: [ :aSentence | sentenceStack push: aSentence ]! !

!SentenceFinderByPrefix methodsFor: 'private methods' stamp: 'TS 4/22/2023 17:08:51'!
selectSentencesFromNonEmptyStackWithPrefix: aPrefix

	| lastSentence sentencesWithPrefix |

	lastSentence := sentenceStack pop.
	sentencesWithPrefix := self selectSentencesWithPrefix: aPrefix.
	(lastSentence beginsWith: aPrefix) ifTrue: [ sentencesWithPrefix addLast: lastSentence ].

	^sentencesWithPrefix! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'initialization' stamp: 'TS 4/22/2023 15:56:22'!
withSentences: aSentenceOrderedCollection

	^self new initializeWithSentences: aSentenceOrderedCollection! !


!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'TS 4/22/2023 16:00:55'!
emptyPrefixErrorDescription

	^ 'El prefijo a buscar no puede ser vacío'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'TS 4/22/2023 16:01:34'!
prefixWithSpacesErrorDescription

	^ 'El prefijo a buscar no puede contener espacios vacíos'! !


!classDefinition: #StackState category: 'Stack-Exercise'!
Object subclass: #StackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackState methodsFor: 'accessing' stamp: 'TS 4/22/2023 15:46:52'!
lastElementAdded

	self subclassResponsibility! !

!StackState methodsFor: 'accessing' stamp: 'TS 4/22/2023 15:47:07'!
numberOfElementsAdded

	self subclassResponsibility! !

!StackState methodsFor: 'accessing' stamp: 'TS 4/22/2023 15:47:00'!
previousState

	self subclassResponsibility! !


!classDefinition: #EmptyStackState category: 'Stack-Exercise'!
StackState subclass: #EmptyStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyStackState methodsFor: 'accessing' stamp: 'TS 4/21/2023 20:22:17'!
lastElementAdded

	self error: OOStack stackEmptyErrorDescription! !

!EmptyStackState methodsFor: 'accessing' stamp: 'TS 4/22/2023 15:45:57'!
numberOfElementsAdded

	^0! !

!EmptyStackState methodsFor: 'accessing' stamp: 'TS 4/21/2023 20:23:37'!
previousState

	self error: OOStack stackEmptyErrorDescription! !


!classDefinition: #NonEmptyStackState category: 'Stack-Exercise'!
StackState subclass: #NonEmptyStackState
	instanceVariableNames: 'previousState lastElementAdded'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NonEmptyStackState methodsFor: 'accessing' stamp: 'TS 4/21/2023 20:19:08'!
lastElementAdded

	^lastElementAdded! !

!NonEmptyStackState methodsFor: 'accessing' stamp: 'TS 4/21/2023 20:25:22'!
numberOfElementsAdded

	^1 + previousState numberOfElementsAdded! !

!NonEmptyStackState methodsFor: 'accessing' stamp: 'TS 4/21/2023 20:22:55'!
previousState

	^previousState! !


!NonEmptyStackState methodsFor: 'initialization' stamp: 'TS 4/22/2023 15:45:24'!
initializeWithPreviousState: aPreviousStackState andNewElement: anElementToAdd 

	previousState := aPreviousStackState.
	lastElementAdded := anElementToAdd! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NonEmptyStackState class' category: 'Stack-Exercise'!
NonEmptyStackState class
	instanceVariableNames: ''!

!NonEmptyStackState class methodsFor: 'as yet unclassified' stamp: 'TS 4/21/2023 20:28:31'!
withPreviousState: aPreviousStackState andNewElement: anElementToAdd

	^self new initializeWithPreviousState: aPreviousStackState andNewElement: anElementToAdd! !
