!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'headings' stamp: 'TS 6/3/2023 18:21:01'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'TS 6/3/2023 18:21:03'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'TS 6/3/2023 18:21:09'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'TS 6/3/2023 18:21:06'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'setUp/tearDown' stamp: 'TS 6/3/2023 19:02:44'!
withRoverStartingAt: aPosition heading: aHeading andCommandString: aCommandString afterProcessingDo: aBlock

	self
		withRoverStartingAt: aPosition
		heading: aHeading
		andCommandString: aCommandString
		beforeProcessingDo: [:marsRover | ]
		afterProcessingDo: aBlock! !

!MarsRoverTest methodsFor: 'setUp/tearDown' stamp: 'TS 6/3/2023 19:01:36'!
withRoverStartingAt: aPosition heading: aHeading andCommandString: aCommandString beforeProcessingDo: preProcessingBlock afterProcessingDo: postProcessingBlock

	| marsRover |

	marsRover := MarsRover at: aPosition heading: aHeading. 

	preProcessingBlock value: marsRover.
	
	marsRover process: aCommandString.
	
	postProcessingBlock value: marsRover! !


!classDefinition: #LoggingTest category: 'MarsRover-WithHeading'!
MarsRoverTest subclass: #LoggingTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!LoggingTest methodsFor: 'tests' stamp: 'TS 6/4/2023 17:32:49'!
test01LogOfMarsRoverThatMovedForwardContainsNewPosition

	self
		withRoverStartingAt: 1@1
		heading: self north
		andCommandString: 'f'
		assertThatLogger: [:marsRover | Logger trackingPositionAndHeadingOf: marsRover ]
		hasLines: {
			'1@2'
		}! !

!LoggingTest methodsFor: 'tests' stamp: 'TS 6/4/2023 17:32:57'!
test02LogOfMarsRoverThatMovedForwardTwiceContainsBothPositions

	self
		withRoverStartingAt: 1@1
		heading: self north
		andCommandString: 'ff'
		assertThatLogger: [:marsRover | Logger trackingPositionAndHeadingOf: marsRover ]
		hasLines: {
			'1@2'.
			'1@3'
		}! !

!LoggingTest methodsFor: 'tests' stamp: 'TS 6/4/2023 17:35:00'!
test03LogOfMarsRoverThatMovesBackwardsContainsPositions

	self
		withRoverStartingAt: 1@1
		heading: self north
		andCommandString: 'ffb'
		assertThatLogger: [:marsRover | Logger trackingPositionAndHeadingOf: marsRover ]
		hasLines: {
			'1@2'.
			'1@3'.
			'1@2'
		}! !

!LoggingTest methodsFor: 'tests' stamp: 'TS 6/4/2023 15:40:04'!
test04LogOfMarsRoverThatRotatesLeftContainsNewHeading

	self
		withRoverStartingAt: 1@1
		heading: self north
		andCommandString: 'l'
		assertThatLogger: [:marsRover | Logger trackingPositionAndHeadingOf: marsRover ]
		hasLines: {
			'West'
		}! !

!LoggingTest methodsFor: 'tests' stamp: 'TS 6/4/2023 15:40:04'!
test05LogOfMarsRoverThatRotatesLeftTwiceContainsBothNewHeadings

	self
		withRoverStartingAt: 1@1
		heading: self north
		andCommandString: 'll'
		assertThatLogger: [:marsRover | Logger trackingPositionAndHeadingOf: marsRover ]
		hasLines: {
			'West'.
			'South'
		}! !

!LoggingTest methodsFor: 'tests' stamp: 'TS 6/4/2023 15:40:04'!
test06LogOfMarsRoverThatDoesAFullTurnContainsAllNewHeading

	self
		withRoverStartingAt: 1@1
		heading: self north
		andCommandString: 'llll'
		assertThatLogger: [:marsRover | Logger trackingPositionAndHeadingOf: marsRover ]
		hasLines: {
			'West'.
			'South'.
			'East'.
			'North'
		}! !

!LoggingTest methodsFor: 'tests' stamp: 'TS 6/4/2023 15:40:04'!
test07LogOfMarsRoverThatRotatesRightMultipleTimesContainsAllNewHeadings

	self
		withRoverStartingAt: 1@1
		heading: self north
		andCommandString: 'rrr'
		assertThatLogger: [:marsRover | Logger trackingPositionAndHeadingOf: marsRover ]
		hasLines: {
			'East'.
			'South'.
			'West'
		}! !

!LoggingTest methodsFor: 'tests' stamp: 'TS 6/4/2023 17:35:14'!
test08MonitoringWindowOfMarsRoverAfterMovingForwardShowsNewPosition

	self 
		withRoverStartingAt: 1@1
		heading: self north
		andCommandString: 'f'
		assertThatWindow: [:marsRover | MonitoringWindow trackingPositionAndHeadingOf: marsRover ]
		hasPositionField: '1@2' andHeadingField: nil! !

!LoggingTest methodsFor: 'tests' stamp: 'TS 6/4/2023 17:35:21'!
test09MonitoringWindowOfMarsRoverAfterMovingForwardTwiceShowsLastPosition

	self 
		withRoverStartingAt: 1@1
		heading: self north
		andCommandString: 'ff'
		assertThatWindow: [:marsRover | MonitoringWindow trackingPositionAndHeadingOf: marsRover ]
		hasPositionField: '1@3' andHeadingField: nil! !

!LoggingTest methodsFor: 'tests' stamp: 'TS 6/4/2023 17:35:25'!
test10MonitoringWindowOfMarsRoverAfterMovingBackwardsShowsLastPosition

	self 
		withRoverStartingAt: 1@1
		heading: self north
		andCommandString: 'ffb'
		assertThatWindow: [:marsRover | MonitoringWindow trackingPositionAndHeadingOf: marsRover ]
		hasPositionField: '1@2' andHeadingField: nil! !

!LoggingTest methodsFor: 'tests' stamp: 'TS 6/4/2023 17:35:30'!
test11MonitoringWindowOfMarsRoverAfterRotatingLeftShowsNewHeading

	self 
		withRoverStartingAt: 1@1
		heading: self north
		andCommandString: 'fl'
		assertThatWindow: [:marsRover | MonitoringWindow trackingPositionAndHeadingOf: marsRover ]
		hasPositionField: '1@2' andHeadingField: 'Apuntando al Oeste'! !

!LoggingTest methodsFor: 'tests' stamp: 'TS 6/4/2023 17:22:52'!
test12MonitoringWindowOfMarsRoverAfterRotatingLeftTwiceShowsLastHeading

	self 
		withRoverStartingAt: 1@1
		heading: self north
		andCommandString: 'll'
		assertThatWindow: [:marsRover | MonitoringWindow trackingPositionAndHeadingOf: marsRover ]
		hasPositionField: nil andHeadingField: 'Apuntando al Sur'! !

!LoggingTest methodsFor: 'tests' stamp: 'TS 6/4/2023 17:22:52'!
test13MonitoringWindowOfMarsRoverAfterDoingAFullTurnShowsLastHeading

	self 
		withRoverStartingAt: 1@1
		heading: self north
		andCommandString: 'llll'
		assertThatWindow: [:marsRover | MonitoringWindow trackingPositionAndHeadingOf: marsRover ]
		hasPositionField: nil andHeadingField: 'Apuntando al Norte'! !

!LoggingTest methodsFor: 'tests' stamp: 'TS 6/4/2023 17:22:52'!
test14MonitoringWindowOfMarsRoverAfterRotatingRightMultipleTimesShowsLastHeading

	self 
		withRoverStartingAt: 1@1
		heading: self north
		andCommandString: 'rrr'
		assertThatWindow: [:marsRover | MonitoringWindow trackingPositionAndHeadingOf: marsRover ]
		hasPositionField: nil andHeadingField: 'Apuntando al Oeste'! !

!LoggingTest methodsFor: 'tests' stamp: 'TS 6/4/2023 17:36:34'!
test15LoggerCanTrackOnlyPositionChanges

	self
		withRoverStartingAt: 1@1
		heading: self north
		andCommandString: 'ffl'
		assertThatLogger: [:marsRover | Logger trackingPositionOf: marsRover ]
		hasLines: {
			'1@2'.
			'1@3'
		}! !

!LoggingTest methodsFor: 'tests' stamp: 'TS 6/4/2023 16:17:22'!
test16LoggerCanTrackOnlyHeadingChanges

	self
		withRoverStartingAt: 1@1
		heading: self north
		andCommandString: 'ffl'
		assertThatLogger: [:marsRover | Logger trackingHeadingOf: marsRover ]
		hasLines: {
			'West'
		}! !

!LoggingTest methodsFor: 'tests' stamp: 'TS 6/4/2023 17:35:45'!
test17WindowCanTrackOnlyPosition

	self 
		withRoverStartingAt: 1@1
		heading: self north
		andCommandString: 'ffl'
		assertThatWindow: [:marsRover | MonitoringWindow trackingPositionOf: marsRover ]
		hasPositionField: '1@3' andHeadingField: nil! !

!LoggingTest methodsFor: 'tests' stamp: 'TS 6/4/2023 17:22:37'!
test18WindowCanTrackOnlyHeading

	self 
		withRoverStartingAt: 1@1
		heading: self north
		andCommandString: 'ffl'
		assertThatWindow: [:marsRover | MonitoringWindow trackingHeadingOf: marsRover ]
		hasPositionField: nil andHeadingField: 'Apuntando al Oeste'! !

!LoggingTest methodsFor: 'tests' stamp: 'TS 6/4/2023 17:35:55'!
test19CanUseBothLoggerAndWindowAtTheSameTime
	"
	Este test no fue parte del TDD: lo armamos al final (y corrió de una) porque se nos olvidó.
	"

	| logger marsRover window |
	marsRover := MarsRover at: 1@1 heading: self north.
	logger := Logger trackingPositionAndHeadingOf: marsRover.
	window := MonitoringWindow trackingPositionAndHeadingOf: marsRover.
	
	marsRover process: 'fl'.
	
	self assert: { '1@2'. 'West' } asOrderedCollection equals: logger lines.
	self assert: '1@2' equals: window positionField.
	self assert: 'Apuntando al Oeste' equals: window headingField.! !


!LoggingTest methodsFor: 'assertions' stamp: 'TS 6/4/2023 15:38:03'!
withRoverStartingAt: aPosition heading: aHeading andCommandString: aCommandString assertThatLogger: aLoggerCreatingBlock hasLines: aCollectionOfLines

	| logger |

	self
		withRoverStartingAt: aPosition
		heading: aHeading
		andCommandString: aCommandString
		beforeProcessingDo: [:marsRover |
			logger := aLoggerCreatingBlock value: marsRover
		]
		afterProcessingDo: [:marsRover |
			self
				assert: aCollectionOfLines asOrderedCollection
				equals: logger lines
			]! !

!LoggingTest methodsFor: 'assertions' stamp: 'TS 6/4/2023 15:41:42'!
withRoverStartingAt: aPosition heading: aHeading andCommandString: aCommandString assertThatWindow: aWindowCreatingBlock hasPositionField: aValueForPositionField andHeadingField: aValueForHeadingField

	| window |

	self
		withRoverStartingAt: aPosition
		heading: aHeading
		andCommandString: aCommandString
		beforeProcessingDo: [:marsRover |
			window := aWindowCreatingBlock value: marsRover
		]
		afterProcessingDo: [:marsRover |
			self assert: aValueForPositionField equals: window positionField.
			self assert: aValueForHeadingField equals: window headingField
		]! !


!classDefinition: #MovementTest category: 'MarsRover-WithHeading'!
MarsRoverTest subclass: #MovementTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MovementTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MovementTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MovementTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MovementTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MovementTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MovementTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MovementTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MovementTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MovementTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MovementTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MovementTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MovementTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MovementTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MovementTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MovementTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MovementTest methodsFor: 'assertions' stamp: 'TS 6/3/2023 18:58:18'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	self
		withRoverStartingAt: startPosition
		heading: startHeadingType
		andCommandString: commands
		afterProcessingDo: [:marsRover |
			self assert: (marsRover isAt: newPosition heading: newHeadingType)
		]! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'TS 6/4/2023 16:04:10'!
initializeAt: aPosition heading: aHeadingType

	position := ChangeTrackingProxy for: aPosition.
	head := ChangeTrackingProxy for: (aHeadingType for: self).
! !


!MarsRover methodsFor: 'heading' stamp: 'TS 6/4/2023 16:05:21'!
headEast
	
	head value: (MarsRoverHeadingEast for: self)! !

!MarsRover methodsFor: 'heading' stamp: 'TS 6/4/2023 16:05:32'!
headNorth
	
	head value: (MarsRoverHeadingNorth for: self)! !

!MarsRover methodsFor: 'heading' stamp: 'TS 6/4/2023 16:05:37'!
headSouth
	
	head value: (MarsRoverHeadingSouth for: self)! !

!MarsRover methodsFor: 'heading' stamp: 'TS 6/4/2023 16:05:42'!
headWest
	
	head value: (MarsRoverHeadingWest for: self)! !

!MarsRover methodsFor: 'heading' stamp: 'TS 6/4/2023 16:06:40'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'TS 6/4/2023 16:06:36'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'TS 6/4/2023 16:06:27'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'TS 6/4/2023 16:04:31'!
moveEast
	
	position value: position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'TS 6/4/2023 16:06:31'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'TS 6/4/2023 16:04:36'!
moveNorth
	
	position value: position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'TS 6/4/2023 16:04:38'!
moveSouth
	
	position value: position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'TS 6/4/2023 16:04:41'!
moveWest
	
	position value: position + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'observers' stamp: 'TS 6/4/2023 16:07:11'!
addHeadingObserver: aBlock

	head addObserver: aBlock
! !

!MarsRover methodsFor: 'observers' stamp: 'TS 6/4/2023 16:07:18'!
addPositionObserver: aBlock

	position addObserver: aBlock
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !


!MarsRoverHeading methodsFor: 'visiting' stamp: 'TS 6/4/2023 16:23:08'!
accept: aVisitor

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'TS 6/4/2023 15:29:59'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'printing' stamp: 'TS 6/4/2023 16:18:46'!
monitoringWindowFieldName

	^ 'Este'! !


!MarsRoverHeadingEast methodsFor: 'visiting' stamp: 'TS 6/4/2023 16:23:43'!
accept: aVisitor

	aVisitor visitHeadingEast: self! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'printing' stamp: 'TS 6/4/2023 16:19:11'!
monitoringWindowFieldName

	^ 'Norte'! !


!MarsRoverHeadingNorth methodsFor: 'visiting' stamp: 'TS 6/4/2023 16:23:52'!
accept: aVisitor

	aVisitor visitHeadingNorth: self! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'printing' stamp: 'TS 6/4/2023 16:20:14'!
monitoringWindowFieldName

	^ 'Sur'! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'visiting' stamp: 'TS 6/4/2023 16:23:58'!
accept: aVisitor

	aVisitor visitHeadingSouth: self! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'printing' stamp: 'TS 6/4/2023 16:20:19'!
monitoringWindowFieldName

	^ 'Oeste'! !


!MarsRoverHeadingWest methodsFor: 'visiting' stamp: 'TS 6/4/2023 16:24:05'!
accept: aVisitor

	aVisitor visitHeadingWest: self! !


!classDefinition: #MarsRoverStateTracker category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverStateTracker
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverStateTracker methodsFor: 'tracking' stamp: 'TS 6/4/2023 17:26:07'!
headingUpdate: aHeading

	self subclassResponsibility! !

!MarsRoverStateTracker methodsFor: 'tracking' stamp: 'TS 6/4/2023 17:26:30'!
positionUpdate: aPosition

	self subclassResponsibility! !


!MarsRoverStateTracker methodsFor: 'initialization - private' stamp: 'TS 6/4/2023 17:27:25'!
trackHeadingOf: aMarsRover

	aMarsRover addHeadingObserver: [:newHeading |
		self headingUpdate: newHeading
	]! !

!MarsRoverStateTracker methodsFor: 'initialization - private' stamp: 'TS 6/4/2023 17:27:30'!
trackPositionOf: aMarsRover 

	aMarsRover addPositionObserver: [:newPosition |
		self positionUpdate: newPosition
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverStateTracker class' category: 'MarsRover-WithHeading'!
MarsRoverStateTracker class
	instanceVariableNames: ''!

!MarsRoverStateTracker class methodsFor: 'instance creation' stamp: 'TS 6/4/2023 17:27:52'!
trackingHeadingOf: aMarsRover 

	| logger |
	logger := self new.
	
	logger trackHeadingOf: aMarsRover.
	
	^ logger! !

!MarsRoverStateTracker class methodsFor: 'instance creation' stamp: 'TS 6/4/2023 17:28:00'!
trackingPositionAndHeadingOf: aMarsRover

	| logger |
	logger := self new.
	
	logger trackPositionOf: aMarsRover.
	logger trackHeadingOf: aMarsRover.
	
	^ logger! !

!MarsRoverStateTracker class methodsFor: 'instance creation' stamp: 'TS 6/4/2023 17:28:04'!
trackingPositionOf: aMarsRover 
	
	| logger |
	logger := self new.
	
	logger trackPositionOf: aMarsRover.

	^ logger! !


!classDefinition: #Logger category: 'MarsRover-WithHeading'!
MarsRoverStateTracker subclass: #Logger
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Logger methodsFor: 'tracking' stamp: 'TS 6/4/2023 17:23:56'!
headingUpdate: aHeading

	aHeading accept: self! !

!Logger methodsFor: 'tracking' stamp: 'TS 6/4/2023 17:36:09'!
positionUpdate: aPosition 

	self addLine: aPosition asString! !


!Logger methodsFor: 'initialization' stamp: 'TS 6/4/2023 15:20:58'!
initialize

	lines := OrderedCollection new! !


!Logger methodsFor: 'lines' stamp: 'TS 6/3/2023 19:11:44'!
addLine: aLine 

	lines add: aLine! !

!Logger methodsFor: 'lines' stamp: 'TS 6/4/2023 15:51:41'!
lines

	^ lines! !


!Logger methodsFor: 'visiting' stamp: 'TS 6/4/2023 16:24:31'!
visitHeadingEast: aHeading

	self addLine: 'East'! !

!Logger methodsFor: 'visiting' stamp: 'TS 6/4/2023 16:24:45'!
visitHeadingNorth: aHeading

	self addLine: 'North'! !

!Logger methodsFor: 'visiting' stamp: 'TS 6/4/2023 16:24:53'!
visitHeadingSouth: aHeading

	self addLine: 'South'! !

!Logger methodsFor: 'visiting' stamp: 'TS 6/4/2023 16:24:38'!
visitHeadingWest: aHeading

	self addLine: 'West'! !


!classDefinition: #MonitoringWindow category: 'MarsRover-WithHeading'!
MarsRoverStateTracker subclass: #MonitoringWindow
	instanceVariableNames: 'positionField headingField'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MonitoringWindow methodsFor: 'fields' stamp: 'TS 6/4/2023 14:54:55'!
headingField

	^ headingField! !

!MonitoringWindow methodsFor: 'fields' stamp: 'TS 6/3/2023 20:35:33'!
positionField

	^ positionField! !


!MonitoringWindow methodsFor: 'tracking' stamp: 'TS 6/4/2023 17:24:21'!
headingUpdate: aHeading

	aHeading accept: self! !

!MonitoringWindow methodsFor: 'tracking' stamp: 'TS 6/4/2023 17:36:18'!
positionUpdate: aPosition 

	positionField := aPosition asString! !


!MonitoringWindow methodsFor: 'visiting' stamp: 'TS 6/4/2023 16:26:06'!
visitHeadingEast: aHeading

	headingField := 'Apuntando al Este'! !

!MonitoringWindow methodsFor: 'visiting' stamp: 'TS 6/4/2023 16:26:18'!
visitHeadingNorth: aHeading

	headingField := 'Apuntando al Norte'! !

!MonitoringWindow methodsFor: 'visiting' stamp: 'TS 6/4/2023 16:26:24'!
visitHeadingSouth: aHeading

	headingField := 'Apuntando al Sur'! !

!MonitoringWindow methodsFor: 'visiting' stamp: 'TS 6/4/2023 16:26:13'!
visitHeadingWest: aHeading

	headingField := 'Apuntando al Oeste'! !


!classDefinition: #ChangeTrackingProxy category: 'MarsRover-WithHeading'!
ProtoObject subclass: #ChangeTrackingProxy
	instanceVariableNames: 'value observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!ChangeTrackingProxy methodsFor: 'initialization' stamp: 'TS 6/4/2023 16:01:54'!
initializeFor: aValue 

	value := aValue.
	observers := OrderedCollection new! !


!ChangeTrackingProxy methodsFor: 'message handling' stamp: 'TS 6/4/2023 16:00:40'!
doesNotUnderstand: aMessage

	^ aMessage sendTo: value! !


!ChangeTrackingProxy methodsFor: 'observing' stamp: 'TS 6/4/2023 16:01:41'!
addObserver: aBlock

	observers add: aBlock! !

!ChangeTrackingProxy methodsFor: 'observing' stamp: 'TS 6/4/2023 16:03:41'!
notifyObservers

	observers do: [:aBlock | aBlock value: value ]! !


!ChangeTrackingProxy methodsFor: 'accessing' stamp: 'TS 6/4/2023 16:03:56'!
value: aNewValue

	value := aNewValue.
	self notifyObservers! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ChangeTrackingProxy class' category: 'MarsRover-WithHeading'!
ChangeTrackingProxy class
	instanceVariableNames: ''!

!ChangeTrackingProxy class methodsFor: 'as yet unclassified' stamp: 'TS 6/4/2023 15:55:10'!
for: aValue

	^ self new initializeFor: aValue! !
