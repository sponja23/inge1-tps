!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'TS 4/11/2023 16:05:59'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertThat: [ customerBook addCustomerNamed: 'John Lennon'. ] takesNoMoreThan: (50 * millisecond).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TS 4/11/2023 16:06:03'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self newCustomerBookWithCustomerNamed: paulMcCartney.

	self assertThat: [ customerBook removeCustomerNamed: paulMcCartney. ] takesNoMoreThan: (100 * millisecond).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LMR 4/10/2023 21:33:31'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self assertThat: [ customerBook addCustomerNamed: '']
		 throws: Error 
		 andDo: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TS 4/11/2023 16:10:50'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			

	johnLennon := 'John Lennon'.
	customerBook := self newCustomerBookWithCustomerNamed: johnLennon.
	
	self assertThat: [ customerBook removeCustomerNamed: 'Paul McCartney'. ]
		 throws: NotFound
		 andThat: customerBook
		 hasSingleCustomerNamed: johnLennon! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TS 4/11/2023 16:00:51'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self newCustomerBookWithSuspendedCustomerNamed: paulMcCartney.
	
	self assert: customerBook hasActiveCustomers: 0 andHasSuspendedCustomers: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TS 4/11/2023 16:00:57'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|

	paulMcCartney := 'Paul McCartney'.
	customerBook := self newCustomerBookWithSuspendedCustomerNamed: paulMcCartney.

	customerBook removeCustomerNamed: paulMcCartney.

	self assert: customerBook hasActiveCustomers: 0 andHasSuspendedCustomers: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TS 4/11/2023 16:10:29'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
		
	johnLennon := 'John Lennon'.
	customerBook := self newCustomerBookWithCustomerNamed: johnLennon.
	
	self assertThat: [ customerBook suspendCustomerNamed: 'George Harrison'. ]
		 throws: CantSuspend
		 andThat: customerBook
		 hasSingleCustomerNamed: johnLennon! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TS 4/11/2023 16:10:14'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |

	johnLennon := 'John Lennon'.
	customerBook := self newCustomerBookWithSuspendedCustomerNamed: johnLennon.
	
	self assertThat: [ customerBook suspendCustomerNamed: johnLennon. ]
		 throws: CantSuspend
		 andThat: customerBook
		 hasSingleCustomerNamed: johnLennon! !


!CustomerBookTest methodsFor: 'auxiliary' stamp: 'TS 4/11/2023 16:06:20'!
assert: aCustomerBook
hasActiveCustomers: aNumberOfActiveCustomers
andHasSuspendedCustomers: aNumberOfSuspendedCustomers

	self assert: aNumberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: (aNumberOfActiveCustomers + aNumberOfSuspendedCustomers) equals: aCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'auxiliary' stamp: 'LMR 4/10/2023 21:57:51'!
assert: aCustomerBook hasSingleCustomerNamed: aCustomer

	self assert: aCustomerBook numberOfCustomers = 1.
	self assert: (aCustomerBook includesCustomerNamed: aCustomer)! !

!CustomerBookTest methodsFor: 'auxiliary' stamp: 'TS 4/11/2023 16:06:27'!
assertThat: aClosure takesNoMoreThan: anAmountOfTime

	| millisecondsAfterRunning millisecondsBeforeRunning |
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < anAmountOfTime
! !

!CustomerBookTest methodsFor: 'auxiliary' stamp: 'TS 4/11/2023 16:06:30'!
assertThat: aClosure throws: anError andDo: anotherClosure

	[ aClosure value.
	  self fail ]
		on: anError 
		do: anotherClosure! !

!CustomerBookTest methodsFor: 'auxiliary' stamp: 'TS 4/11/2023 16:12:00'!
assertThat: aClosure throws: anError andThat: aCustomerBook hasSingleCustomerNamed: aCustomer
	"
	En nuestra opinión, esta abstracción presenta un nivel inaceptable de acople, 
	pero nos aclararon que debíamos extraer todo el código repetido posible.
	"

	self assertThat: aClosure
		 throws: anError
		 andDo: [ :err | 
			self assert: aCustomerBook hasSingleCustomerNamed: aCustomer ]! !

!CustomerBookTest methodsFor: 'auxiliary' stamp: 'TS 4/11/2023 16:06:34'!
newCustomerBookWithCustomerNamed: aCustomer

	| customerBook |
	
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aCustomer.
	^customerBook! !

!CustomerBookTest methodsFor: 'auxiliary' stamp: 'TS 4/11/2023 16:06:40'!
newCustomerBookWithSuspendedCustomerNamed: aCustomer

	| customerBook |
	
	customerBook := self newCustomerBookWithCustomerNamed: aCustomer.
	customerBook suspendCustomerNamed: aCustomer.
	^customerBook.! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'LMR 4/10/2023 20:59:16'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'TS 4/11/2023 16:20:15'!
removeCustomerNamed: aName 

	self removeCustomerNamed: aName
		 from: active
		 ifFoundDo: [ ^aName ].

	self removeCustomerNamed: aName
		 from: suspended
		 ifFoundDo: [ ^aName ].

	^ NotFound signal.! !

!CustomerBook methodsFor: 'customer management' stamp: 'TS 4/11/2023 16:19:23'!
removeCustomerNamed: aName from: aList ifFoundDo: aClosure
	1 to: aList size do: 
	[ :index |
		aName = (aList at: index)
			ifTrue: [
				aList removeAt: index.
				aClosure value
			] 
	].! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
