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
	aSpaceshipArray := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 4 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboardLength: 5
		         withWormholesPoisitions: #( 2 4 )
		         withDice: aDiceCollection
		         withLaps: 2.

	self
		should: [ aGame winner ]
		raise: Error
		withMessage: 'There is no winner yet'
]

{ #category : #tests }
SpaceshipGameTest >> testErrorWhenGameIsOverAndItIsAttemptedToContinuePlaying [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection |
	aSpaceship := 'Hernan'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 4 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 5
		         withWormholesPoisitions: #( 2 4 )
		         withDice: aDiceCollection
		         withLaps: 1.

	aGame playTurn.

	self
		should: [ aGame playTurn ]
		raise: Error
		withMessage: 'Game is over'
]

{ #category : #tests }
SpaceshipGameTest >> testGameEndsWhenSpaceshipCompletesRequiredLaps [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection |
	aSpaceship := 'zepito'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := OrderedCollection
		                   with: (LoadedDie sequence: #(20))
		                   with: (LoadedDie sequence: #(15)).
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 10
		         withWormholesPoisitions: #( 3 9 )
		         withDice: aDiceCollection
		         withLaps: 3.

	aGame playTurn.

	self assert: aGame isOver
]

{ #category : #tests }
SpaceshipGameTest >> testGameWinnerWithMoreThanOneLap [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection |
	aSpaceship := 'zepito'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := OrderedCollection
		                   with: (LoadedDie sequence: #( 20 ))
		                   with: (LoadedDie sequence: #( 15 )).
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 10
		         withWormholesPoisitions: #( 3 9 )
		         withDice: aDiceCollection
		         withLaps: 3.

	aGame playTurn.

	self assert: aGame winner equals: aSpaceship
]

{ #category : #tests }
SpaceshipGameTest >> testGameWinnerWithMoreThanOnePlayer [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 6 5 5)) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 11
		         withWormholesPoisitions: #( 2 4 )
		         withDice: aDiceCollection
		         withLaps: 1.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.


	self assert: aGame winner equals: aSpaceship
]

{ #category : #tests }
SpaceshipGameTest >> testSpaceshipMovedToStartWhenFuelIsEmpty [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection |
	aSpaceship := 'Helado de menta granizada'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := OrderedCollection with:
		                   (LoadedDie sequence: #( 3 )).
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withWormholesPoisitions: #( 11 13 )
		         withDice: aDiceCollection
		         withLaps: 2.

	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 1
]

{ #category : #tests }
SpaceshipGameTest >> testWhenAGameIsCreatedCheckThatItIsNotOver [

	| aGame aSpaceship aDiceCollection aSpaceshipCollection |
	aSpaceship := 'Pancho'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 6 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 12
		         withWormholesPoisitions: #( 2 7 )
		         withDice: aDiceCollection
		         withLaps: 2.
	self deny: aGame isOver
]

{ #category : #tests }
SpaceshipGameTest >> testWhenAPlayerReachesTheEndTheGameFinishes [

	| aSpaceship aDiceCollection aGame aSpaceshipArray |
	aSpaceship := 'Zalo'.
	aSpaceshipArray := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 12 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboardLength: 13
		         withWormholesPoisitions: #( 2 7 )
		         withDice: aDiceCollection
		         withLaps: 1.

	aGame playTurn.


	self assert: aGame isOver
]

{ #category : #tests }
SpaceshipGameTest >> testWhenASixIsThrownOnFirstTurnNextPositionIsSeven [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection |
	aSpaceship := 'Pancho'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 6 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 12
		         withWormholesPoisitions: #( 2 9 )
		         withDice: aDiceCollection
		         withLaps: 2.

	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 7
]

{ #category : #tests }
SpaceshipGameTest >> testWhenCreatingTheGameCheckThatTheSpaceshipsAreInTheFirstSquare [

	| aGame aSpaceship aDiceCollection aSpaceshipCollection |
	aSpaceship := 'Pancho'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #(6)) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 12
		         withWormholesPoisitions: #( 2 7 )
		         withDice: aDiceCollection
		         withLaps: 2.

	self assert: (aGame positionOf: aSpaceship) equals: 1
]

{ #category : #tests }
SpaceshipGameTest >> testWhenGameFinishGivesThePositionOfTheSpaceships [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := OrderedCollection  with: (LoadedDie sequence: #( 3 4 3 9 )) .
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 11
		         withWormholesPoisitions: #( 2 8 )
		         withDice: aDiceCollection
		         withLaps: 2.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 7.
	self assert: (aGame positionOf: anotherSpaceship) equals: 5
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerReachesTheEndOnFirstLapThenGameIsNotOver [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection |
	aSpaceship := 'Jorge Spaceship'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := OrderedCollection
		                   with: (LoadedDie sequence: #( 10 ))
		                   with: (LoadedDie sequence: #( 5 )).
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withWormholesPoisitions: #( 9 12 )
		         withDice: aDiceCollection
		         withLaps: 2.

	aGame playTurn.

	self deny: aGame isOver
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerReachesTheEndThenPlayerWins [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection |
	aSpaceship := 'Galindez'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 4 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 5
		         withWormholesPoisitions: #( 2 4 )
		         withDice: aDiceCollection
		         withLaps: 1.

	aGame playTurn.

	self assert: aGame winner equals: aSpaceship
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerRunsOutOfFuelThenGoesToStartAndLosesTwoTurns [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 6 4 6 3 3 4 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withWormholesPoisitions: #( 2 14 )
		         withDice: aDiceCollection
		         withLaps: 1.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	
	self assert: (aGame positionOf: aSpaceship) equals: 5.
	self assert: (aGame positionOf: anotherSpaceship) equals: 11
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerSkipsTurnThenItStaysInTheSamePosition [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := { (LoadedDie sequence: #(6 5 3 4)) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 11
		         withWormholesPoisitions: #( 2 4 )
		         withDice: aDiceCollection
		         withLaps: 1.

	aGame playTurn.
	aGame playTurn.
	aGame skipTurn.
	aGame playTurn.


	self assert: (aGame positionOf: aSpaceship) equals: 7.
	self assert: (aGame positionOf: anotherSpaceship) equals: 9
	
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerSkipsTurnThenRefuels [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection |
	aSpaceship := 'Pancho'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #(5 5)) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withWormholesPoisitions: #( 2 4 )
		         withDice: aDiceCollection
		         withLaps: 1.

	aGame playTurn.
	aGame skipTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 11.
	
]

{ #category : #tests }
SpaceshipGameTest >> testWhenSpaceshipLandsOnFirstWormholeThenMoveItToSecondWormhole [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection |
	aSpaceship := 'Helado de menta granizada'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := OrderedCollection
		                   with: (LoadedDie sequence: #( 3 ))
		                   with: (LoadedDie sequence: #( 5 )).
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withWormholesPoisitions: #( 9 12 )
		         withDice: aDiceCollection
		         withLaps: 2.

	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 12
]

{ #category : #tests }
SpaceshipGameTest >> testWhenSpaceshipLandsOnSecondWormholeThenMoveItToFirstWormhole [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection |
	aSpaceship := 'Tornillito loco'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := OrderedCollection
		                   with: (LoadedDie sequence: #( 7 ))
		                   with: (LoadedDie sequence: #( 4 )).
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withWormholesPoisitions: #( 9 12 )
		         withDice: aDiceCollection
		         withLaps: 2.

	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 9
]

{ #category : #tests }
SpaceshipGameTest >> testWhenTwoDieAreThrownMovePlayerToTheSumOfDice [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection |
	aSpaceship := 'Pancho'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := OrderedCollection
		                   with: (LoadedDie sequence: #( 6 ))
		                   with: (LoadedDie sequence: #( 3 )).
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 12
		         withWormholesPoisitions: #( 2 7 )
		         withDice: aDiceCollection
		         withLaps: 2.

	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 10
]
