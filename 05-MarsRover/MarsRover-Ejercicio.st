!classDefinition: #MarsRoverTest category: 'MarsRover-Ejercicio'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!MarsRoverTest methodsFor: 'setUp/tearDown' stamp: 'TS 5/15/2023 07:32:11'!
east

	^ East! !

!MarsRoverTest methodsFor: 'setUp/tearDown' stamp: 'TS 5/15/2023 07:32:15'!
north

	^ North! !

!MarsRoverTest methodsFor: 'setUp/tearDown' stamp: 'TS 5/15/2023 07:24:11'!
setUp

	marsRover := MarsRover at: 0@0 headingTo: self north.! !

!MarsRoverTest methodsFor: 'setUp/tearDown' stamp: 'TS 5/15/2023 07:32:18'!
south

	^ South! !

!MarsRoverTest methodsFor: 'setUp/tearDown' stamp: 'TS 5/15/2023 07:32:20'!
west

	^ West! !


!MarsRoverTest methodsFor: 'testing' stamp: 'TS 5/15/2023 07:24:11'!
test01EmptyCommandStringDoesNothing

	marsRover receiveCommands: ''.
	
	self assert: marsRover isAt: 0@0 andIsHeadingTo: self north! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TS 5/15/2023 07:24:11'!
test02SingleForwardCommandWhileHeadingNorthMoves1UnitOnYAxis

	marsRover receiveCommands: 'f'.

	self assert: marsRover isAt: 0@1 andIsHeadingTo: self north! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TS 5/15/2023 07:24:11'!
test03DoubleForwardCommandWhileHeadingNorthMoves2UnitsOnYAxis
	
	marsRover receiveCommands: 'ff'.
	
	self assert: marsRover isAt: 0@2 andIsHeadingTo: self north! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TS 5/15/2023 07:24:11'!
test04MovingForwardWorksWhenStartingInADifferentPosition
	
	| marsRoverStartingInDifferentPosition |

	marsRoverStartingInDifferentPosition := MarsRover at: 1@1 headingTo: self north.
	
	marsRoverStartingInDifferentPosition receiveCommands: 'f'.
	
	self assert: marsRoverStartingInDifferentPosition isAt: 1@2 andIsHeadingTo: self north! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TS 5/15/2023 07:24:11'!
test05BackwardCommandsWhileHeadingNorthMoveBackwardOnYAxis
	
	marsRover receiveCommands: 'bbb'.
	
	self assert: marsRover isAt: 0@-3 andIsHeadingTo: self north! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TS 5/15/2023 07:24:11'!
test06MixedMovementCommandsWhileHeadingNorthLeaveRoverInCorrectPosition
	
	marsRover receiveCommands: 'fbffbbf'.
	
	self assert: marsRover isAt: 0@1 andIsHeadingTo: self north! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TS 5/15/2023 08:01:21'!
test07InvalidCommandRaisesAnError

	self
		should: [ marsRover receiveCommands: 'hola' ]
		raise: Error - MessageNotUnderstood 
		description: Command invalidCommandErrorDescription! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TS 5/15/2023 07:24:24'!
test08LeftCommandTurns90DegreesLeft
	
	marsRover receiveCommands: 'l'.
	
	self assert: marsRover isAt: 0@0 andIsHeadingTo: self west! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TS 5/15/2023 07:24:30'!
test09RightCommandTurns90DegreesRight
	
	marsRover receiveCommands: 'r'.
	
	self assert: marsRover isAt: 0@0 andIsHeadingTo: self east! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TS 5/15/2023 07:24:36'!
test10DoubleLeftCommandTurns180Degrees
	
	marsRover receiveCommands: 'll'.
	
	self assert: marsRover isAt: 0@0 andIsHeadingTo: self south! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TS 5/15/2023 07:24:30'!
test11TripleLeftCommandTurns270Degrees
	
	marsRover receiveCommands: 'lll'.
	
	self assert: marsRover isAt: 0@0 andIsHeadingTo: self east! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TS 5/15/2023 07:24:11'!
test12LeftCommand4TimesLeavesRoverInTheSameDirection
	
	marsRover receiveCommands: 'llll'.
	
	self assert: marsRover isAt: 0@0 andIsHeadingTo: self north! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TS 5/15/2023 07:24:11'!
test13MixedRotationCommandsLeaveRoverHeadingToCorrectDirection
	
	marsRover receiveCommands: 'lrrlrllr'.
	
	self assert: marsRover isAt: 0@0 andIsHeadingTo: self north! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TS 5/15/2023 07:38:12'!
test14SingleForwardCommandAfterTurning90DegreesMoves1UnitOnXAxis
	
	marsRover receiveCommands: 'lf'.
	
	self assert: marsRover isAt: -1@0 andIsHeadingTo: self west! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TS 5/15/2023 07:38:18'!
test15DoubleForwardCommandAfterTurning90DegreesMoves2UnitsOnXAxis
	
	marsRover receiveCommands: 'lff'.
	
	self assert: marsRover isAt: -2@0 andIsHeadingTo: self west! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TS 5/15/2023 07:39:42'!
test16BackwardCommandAfterTurning90DegreesMovesBackwardOnXAxis
	
	marsRover receiveCommands: 'lbb'.
	
	self assert: marsRover isAt: 2@0 andIsHeadingTo: self west! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TS 5/15/2023 07:42:57'!
test17MovementCommandsAfterTurning180DegreesMoveOnYAxisInAnInvertedDirection
	
	marsRover receiveCommands: 'llfbf'.
	
	self assert: marsRover isAt: 0@-1 andIsHeadingTo: self south! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TS 5/15/2023 07:45:27'!
test18MixedMovementAndRotationCommandsWorkCorrectly
	
	marsRover receiveCommands: 'llblffrblf'.
	
	self assert: marsRover isAt: 3@2 andIsHeadingTo: self east! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'TS 5/15/2023 08:02:30'!
assert: aMarsRover isAt: aPosition andIsHeadingTo: aHeading

	self assert: (aMarsRover isAt: aPosition).
	self assert: (aMarsRover isHeadingTo: aHeading)! !


!classDefinition: #Command category: 'MarsRover-Ejercicio'!
Object subclass: #Command
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!Command methodsFor: 'execution' stamp: 'TS 5/15/2023 07:54:59'!
executeOn: aMarsRover

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Command class' category: 'MarsRover-Ejercicio'!
Command class
	instanceVariableNames: ''!

!Command class methodsFor: 'instance creation' stamp: 'TS 5/15/2023 08:01:08'!
for: aCharacter

	| handlingSubclass |

	handlingSubclass := self subclasses
		detect: [ :aCommandSubclass | aCommandSubclass character = aCharacter ]
		ifNone: [ self error: self invalidCommandErrorDescription ].
	
	^ handlingSubclass new! !


!Command class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:53:48'!
character

	self subclassResponsibility! !


!Command class methodsFor: 'error descriptions' stamp: 'TS 5/15/2023 07:59:55'!
invalidCommandErrorDescription
	
	^ 'Comando inválido'! !


!classDefinition: #MoveBackward category: 'MarsRover-Ejercicio'!
Command subclass: #MoveBackward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!MoveBackward methodsFor: 'execution' stamp: 'TS 5/15/2023 07:55:16'!
executeOn: aMarsRover

	aMarsRover moveBackward! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveBackward class' category: 'MarsRover-Ejercicio'!
MoveBackward class
	instanceVariableNames: ''!

!MoveBackward class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:53:55'!
character

	^ $b! !


!classDefinition: #MoveForward category: 'MarsRover-Ejercicio'!
Command subclass: #MoveForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!MoveForward methodsFor: 'execution' stamp: 'TS 5/15/2023 07:55:28'!
executeOn: aMarsRover

	aMarsRover moveForward! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveForward class' category: 'MarsRover-Ejercicio'!
MoveForward class
	instanceVariableNames: ''!

!MoveForward class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:54:02'!
character

	^ $f! !


!classDefinition: #RotateLeft category: 'MarsRover-Ejercicio'!
Command subclass: #RotateLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!RotateLeft methodsFor: 'execution' stamp: 'TS 5/15/2023 07:55:34'!
executeOn: aMarsRover

	aMarsRover rotateLeft! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateLeft class' category: 'MarsRover-Ejercicio'!
RotateLeft class
	instanceVariableNames: ''!

!RotateLeft class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:54:08'!
character

	^ $l! !


!classDefinition: #RotateRight category: 'MarsRover-Ejercicio'!
Command subclass: #RotateRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!RotateRight methodsFor: 'execution' stamp: 'TS 5/15/2023 07:55:41'!
executeOn: aMarsRover

	aMarsRover rotateRight! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateRight class' category: 'MarsRover-Ejercicio'!
RotateRight class
	instanceVariableNames: ''!

!RotateRight class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:54:12'!
character

	^ $r! !


!classDefinition: #Heading category: 'MarsRover-Ejercicio'!
Object subclass: #Heading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!Heading methodsFor: 'initialization' stamp: 'TS 5/15/2023 07:26:26'!
initializeFor: aMarsRover

	marsRover := aMarsRover! !


!Heading methodsFor: 'rotation' stamp: 'TS 5/15/2023 07:49:28'!
moveBackward

	marsRover moveInDirection: self class backwardUnitVector! !

!Heading methodsFor: 'rotation' stamp: 'TS 5/15/2023 07:49:16'!
moveForward

	marsRover moveInDirection: self class forwardUnitVector! !

!Heading methodsFor: 'rotation' stamp: 'TS 5/15/2023 07:29:59'!
rotateLeft

	marsRover changeHeadingTo: self class headingAtLeft! !

!Heading methodsFor: 'rotation' stamp: 'TS 5/15/2023 07:30:10'!
rotateRight

	marsRover changeHeadingTo: self class headingAtRight! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Heading class' category: 'MarsRover-Ejercicio'!
Heading class
	instanceVariableNames: ''!

!Heading class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:46:40'!
backwardUnitVector

	self subclassResponsibility! !

!Heading class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:46:49'!
forwardUnitVector

	self subclassResponsibility! !

!Heading class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:27:19'!
headingAtLeft

	self subclassResponsibility! !

!Heading class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:28:49'!
headingAtRight

	self subclassResponsibility! !


!Heading class methodsFor: 'instance creation' stamp: 'TS 5/15/2023 07:26:10'!
for: aMarsRover

	^ self new initializeFor: aMarsRover! !


!classDefinition: #East category: 'MarsRover-Ejercicio'!
Heading subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: 'MarsRover-Ejercicio'!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:47:34'!
backwardUnitVector

	^ -1@0! !

!East class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:47:30'!
forwardUnitVector

	^ 1@0! !

!East class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:28:29'!
headingAtLeft

	^ North! !

!East class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:28:57'!
headingAtRight

	^ South! !


!classDefinition: #North category: 'MarsRover-Ejercicio'!
Heading subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: 'MarsRover-Ejercicio'!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:47:25'!
backwardUnitVector

	^ 0@-1! !

!North class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:47:50'!
forwardUnitVector

	^ 0@1! !

!North class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:28:33'!
headingAtLeft

	^ West! !

!North class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:29:07'!
headingAtRight

	^ East! !


!classDefinition: #South category: 'MarsRover-Ejercicio'!
Heading subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: 'MarsRover-Ejercicio'!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:48:04'!
backwardUnitVector

	^ 0@1! !

!South class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:47:59'!
forwardUnitVector

	^ 0@-1! !

!South class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:28:16'!
headingAtLeft

	^ East! !

!South class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:29:15'!
headingAtRight

	^ West! !


!classDefinition: #West category: 'MarsRover-Ejercicio'!
Heading subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: 'MarsRover-Ejercicio'!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:48:19'!
backwardUnitVector

	^ 1@0! !

!West class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:48:27'!
forwardUnitVector

	^ -1@0! !

!West class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:28:23'!
headingAtLeft

	^ South! !

!West class methodsFor: 'properties' stamp: 'TS 5/15/2023 07:29:21'!
headingAtRight

	^ North! !


!classDefinition: #MarsRover category: 'MarsRover-Ejercicio'!
Object subclass: #MarsRover
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!MarsRover methodsFor: 'rotation' stamp: 'TS 5/15/2023 07:57:45'!
rotateLeft

	^ heading rotateLeft! !

!MarsRover methodsFor: 'rotation' stamp: 'TS 5/15/2023 07:57:53'!
rotateRight

	^ heading rotateRight! !


!MarsRover methodsFor: 'command execution' stamp: 'TS 5/15/2023 07:56:23'!
receiveCommands: aCommandString 

	aCommandString do: [ :commandCharacter |
		(Command for: commandCharacter) executeOn: self
	]! !


!MarsRover methodsFor: 'initialization' stamp: 'TS 5/15/2023 07:32:02'!
initializeAt: aPosition headingTo: aHeading

	position := aPosition.
	heading := aHeading for: self! !


!MarsRover methodsFor: 'testing' stamp: 'TS 5/15/2023 08:02:16'!
isAt: aPosition

	^ position = aPosition! !

!MarsRover methodsFor: 'testing' stamp: 'TS 5/15/2023 07:32:55'!
isHeadingTo: aHeading

	^ heading class = aHeading! !


!MarsRover methodsFor: 'rotation-private' stamp: 'TS 5/15/2023 07:30:54'!
changeHeadingTo: aHeading

	heading := aHeading for: self! !


!MarsRover methodsFor: 'movement-private' stamp: 'TS 5/15/2023 07:50:08'!
moveInDirection: aUnitVector

	position := position + aUnitVector! !


!MarsRover methodsFor: 'movement' stamp: 'TS 5/15/2023 07:57:37'!
moveBackward

	^ heading moveBackward! !

!MarsRover methodsFor: 'movement' stamp: 'TS 5/15/2023 07:57:17'!
moveForward
	
	heading moveForward! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-Ejercicio'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'TS 5/15/2023 07:14:44'!
at: aPosition headingTo: aHeading

	^self new initializeAt: aPosition headingTo: aHeading! !
