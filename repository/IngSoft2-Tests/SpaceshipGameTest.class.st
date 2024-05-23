Class {
	#name : #SpaceshipGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SpaceshipGameTest >> should: anErrorBlock raise: exceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: exceptionClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
SpaceshipGameTest >> testErrorWhenAskedForAWinnerAndThereIsNone [

	| aSpaceship aDiceCollection aGame aSpaceshipArray |
	aSpaceship := 'Galindez'.
	aSpaceshipArray := Array with: aSpaceship.
	aDiceCollection := { (LoadedDie of: 4) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboardLength: 5
		         withWormholesPoisitions: #( 2 4 )
		         withDice: aDiceCollection.

	self
		should: [ aGame winner ]
		raise: Error
		withMessage: 'There is no winner yet'
]

{ #category : #tests }
SpaceshipGameTest >> testErrorWhenGameIsOverAndItIsAttemptedToContinuePlaying [

	| aSpaceship aDiceCollection aGame aSpaceshipArray |
	aSpaceship := 'Hernan'.
	aSpaceshipArray := Array with: aSpaceship.
	aDiceCollection := { (LoadedDie of: 4) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboardLength: 5
		         withWormholesPoisitions: #( 2 4 )
		         withDice: aDiceCollection.

	aGame playTurn.

	self
		should: [ aGame playTurn ]
		raise: Error
		withMessage: 'Game is over'
]

{ #category : #tests }
SpaceshipGameTest >> testGameWinnerWithMoreThanOnePlayer [

	| aSpaceship aDiceCollection aGame aSpaceship2 aSpaceshipArray |
	aSpaceship := 'Pancho'.
	aSpaceship2 := 'Seijas'.
	aSpaceshipArray := Array with: aSpaceship with: aSpaceship2.
	aDiceCollection := { (LoadedDie of: 5) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboardLength: 11
		         withWormholesPoisitions: #( 2 4 )
		         withDice: aDiceCollection.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.


	self assert: aGame winner equals: aSpaceship
]

{ #category : #tests }
SpaceshipGameTest >> testWhenAGameIsCreatedCheckThatItIsNotOver [

	| aGame aSpaceship aDiceCollection aSpaceshipArray |
	aSpaceship := 'Pancho'.
	aSpaceshipArray := Array with: aSpaceship.
	aDiceCollection := { (LoadedDie of: 6) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboardLength: 12
		         withWormholesPoisitions: #( 2 7 )
		         withDice: aDiceCollection.
	self deny: aGame isOver
]

{ #category : #tests }
SpaceshipGameTest >> testWhenAPlayerReachesTheEndTheGameFinishes [

	| aSpaceship aDiceCollection aGame aSpaceshipArray |
	aSpaceship := 'Zalo'.
	aSpaceshipArray := Array with: aSpaceship.
	aDiceCollection := { (LoadedDie of: 12) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboardLength: 13
		         withWormholesPoisitions: #( 2 7 )
		         withDice: aDiceCollection.

	aGame playTurn.


	self assert: aGame isOver
]

{ #category : #tests }
SpaceshipGameTest >> testWhenASixIsThrownOnFirstTurnNextPositionIsSeven [

	| aSpaceship aDiceCollection aGame aSpaceshipArray |
	aSpaceship := 'Pancho'.
	aSpaceshipArray := Array with: aSpaceship.
	aDiceCollection := { (LoadedDie of: 6) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboardLength: 12
		         withWormholesPoisitions: #( 2 9 )
		         withDice: aDiceCollection.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 7
]

{ #category : #tests }
SpaceshipGameTest >> testWhenCreatingTheGameCheckThatTheSpaceshipsAreInTheFirstSquare [

	| aGame aSpaceship aDiceCollection aSpaceshipArray |
	aSpaceship := 'Pancho'.
	aSpaceshipArray := Array with: aSpaceship.
	aDiceCollection := { (LoadedDie of: 6) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboardLength: 12
		         withWormholesPoisitions: #( 2 7 )
		         withDice: aDiceCollection.

	self assert: (aGame positionOf: aSpaceship) equals: 1
]

{ #category : #tests }
SpaceshipGameTest >> testWhenGameFinishGivesThePositionOfTheSpaceships [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipArray |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipArray := Array with: aSpaceship with: anotherSpaceship.
	aDiceCollection := { (LoadedDie of: 5) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboardLength: 11
		         withWormholesPoisitions: #( 2 7 )
		         withDice: aDiceCollection.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 11.
	self assert: (aGame positionOf: anotherSpaceship) equals: 6
]

{ #category : #tests }
SpaceshipGameTest >> testWhenNextMoveIsOutOfBoundMoveToTheEnd [

	| aSpaceship aDiceCollection aGame aSpaceshipArray |
	aSpaceship := 'Zepo'.
	aSpaceshipArray := Array with: aSpaceship.
	aDiceCollection := { (LoadedDie of: 6) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboardLength: 5
		         withWormholesPoisitions: #( 2 4 )
		         withDice: aDiceCollection.

	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 5
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerReachesTheEndThenPlayerWins [

	| aSpaceship aDiceCollection aGame aSpaceshipArray |
	aSpaceship := 'Galindez'.
	aSpaceshipArray := Array with: aSpaceship.
	aDiceCollection := { (LoadedDie of: 4) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboardLength: 5
		         withWormholesPoisitions: #( 2 4 )
		         withDice: aDiceCollection.

	aGame playTurn.

	self assert: aGame winner equals: aSpaceship
]

{ #category : #tests }
SpaceshipGameTest >> testWhenSpaceshipLandsOnFirstWormholeThenMoveItToSecondWormhole [

	| aSpaceship aDiceCollection aGame aSpaceshipArray |
	aSpaceship := 'Helado de menta granizada'.
	aSpaceshipArray := Array with: aSpaceship.

	aDiceCollection := OrderedCollection
		                   with: (LoadedDie of: 3)
		                   with: (LoadedDie of: 5).
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboardLength: 15
		         withWormholesPoisitions: #( 9 12 )
		         withDice: aDiceCollection.

	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 12
]

{ #category : #tests }
SpaceshipGameTest >> testWhenSpaceshipLandsOnSecondWormholeThenMoveItToFirstWormhole [

	| aSpaceship aDiceCollection aGame aSpaceshipArray |
	aSpaceship := 'Tornillito loco'.
	aSpaceshipArray := Array with: aSpaceship.

	aDiceCollection := OrderedCollection
		                   with: (LoadedDie of: 7)
		                   with: (LoadedDie of: 4).
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboardLength: 15
		         withWormholesPoisitions: #( 9 12 )
		         withDice: aDiceCollection.

	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 9
]

{ #category : #tests }
SpaceshipGameTest >> testWhenTwoDieAreThrownMovePlayerToTheSumOfDice [

	| aSpaceship aDiceCollection aGame aSpaceshipArray |
	aSpaceship := 'Pancho'.

	aSpaceshipArray := Array with: aSpaceship.
	aDiceCollection := OrderedCollection
		                   with: (LoadedDie of: 6)
		                   with: (LoadedDie of: 3).
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboardLength: 12
		         withWormholesPoisitions: #( 2 7 )
		         withDice: aDiceCollection.

	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 10
]
