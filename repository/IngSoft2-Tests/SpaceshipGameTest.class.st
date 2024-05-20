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

	| aSpaceship aGameboard aDie aGame aSpaceshipArray |
	aSpaceship := 'Galindez'.
	aSpaceshipArray := Array with: aSpaceship.
	aGameboard := Gameboard numberOfSquares: 5 withWormholeAt: 2 and: 4.
	aDie := LoadedDie of: 4.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboard: aGameboard
		         withDie: aDie.

	self
		should: [ aGame winner ]
		raise: Error
		withMessage: 'There is no winner yet'
]

{ #category : #tests }
SpaceshipGameTest >> testErrorWhenGameIsOverAndItIsAttemptedToContinuePlaying [

	| aSpaceship aGameboard aDie aGame aSpaceshipArray |
	aSpaceship := 'Hernan'.
	aSpaceshipArray := Array with: aSpaceship.
	aGameboard := Gameboard numberOfSquares: 5 withWormholeAt: 2 and: 4.
	aDie := LoadedDie of: 4.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboard: aGameboard
		         withDie: aDie.

	aGame playTurn.

	self
		should: [ aGame playTurn ]
		raise: Error
		withMessage: 'Game is over'
]

{ #category : #tests }
SpaceshipGameTest >> testGameWinnerWithMoreThanOnePlayer [

	| aSpaceship aGameboard aDie aGame aSpaceship2 aSpaceshipArray |
	aSpaceship := 'Pancho'.
	aSpaceship2 := 'Seijas'.
	aSpaceshipArray := Array with: aSpaceship with: aSpaceship2.
	aGameboard := Gameboard numberOfSquares: 11 withWormholeAt: 2 and: 4.
	aDie := LoadedDie of: 5.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboard: aGameboard
		         withDie: aDie.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.


	self assert: aGame winner equals: aSpaceship
]

{ #category : #tests }
SpaceshipGameTest >> testWhenAGameIsCreatedCheckThatItIsNotOver [

	| aGame aSpaceship aGameboard aDie aSpaceshipArray |
	aSpaceship := 'Pancho'.
	aSpaceshipArray := Array with: aSpaceship.
	aGameboard := Gameboard numberOfSquares: 12 withWormholeAt: 2 and: 7.
	aDie := LoadedDie of: 6.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboard: aGameboard
		         withDie: aDie.
	self deny: aGame isOver
]

{ #category : #tests }
SpaceshipGameTest >> testWhenAPlayerReachesTheEndTheGameFinishes [

	| aSpaceship aGameboard aDie aGame aSpaceshipArray |
	aSpaceship := 'Zalo'.
	aSpaceshipArray := Array with: aSpaceship.
	aGameboard := Gameboard numberOfSquares: 13 withWormholeAt: 2 and: 7.
	aDie := LoadedDie of: 12.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboard: aGameboard
		         withDie: aDie.

	aGame playTurn.


	self assert: aGame isOver
]

{ #category : #tests }
SpaceshipGameTest >> testWhenASixIsThrownOnFirstTurnNextPositionIsSeven [

	| aSpaceship aGameboard aDie aGame aSpaceshipArray |
	aSpaceship := 'Pancho'.
	aSpaceshipArray := Array with: aSpaceship.
	aGameboard := Gameboard numberOfSquares: 12 withWormholeAt: 2 and: 9.
	aDie := LoadedDie of: 6.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboard: aGameboard
		         withDie: aDie.

	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 7
]

{ #category : #tests }
SpaceshipGameTest >> testWhenCreatingTheGameCheckThatTheSpaceshipsAreInTheFirstSquare [

	| aGame aSpaceship aGameboard aDie aSpaceshipArray |
	aSpaceship := 'Pancho'.
	aSpaceshipArray := Array with: aSpaceship.
	aGameboard := Gameboard numberOfSquares: 12 withWormholeAt: 2 and: 7.
	aDie := LoadedDie of: 6.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboard: aGameboard
		         withDie: aDie.

	self assert: (aGame positionOf: aSpaceship) equals: 1
]

{ #category : #tests }
SpaceshipGameTest >> testWhenGameFinishGivesThePositionOfTheSpaceships [

	| aSpaceship aGameboard aDie aGame anotherSpaceship aSpaceshipArray |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipArray := Array with: aSpaceship with: anotherSpaceship.
	aGameboard := Gameboard numberOfSquares: 11 withWormholeAt: 2 and: 7.
	aDie := LoadedDie of: 5.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboard: aGameboard
		         withDie: aDie.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 11.
	self assert: (aGame positionOf: anotherSpaceship) equals: 6
]

{ #category : #tests }
SpaceshipGameTest >> testWhenNextMoveIsOutOfBoundMoveToTheEnd [

	| aSpaceship aGameboard aDie aGame aSpaceshipArray |
	aSpaceship := 'Zepo'.
	aSpaceshipArray := Array with: aSpaceship.
	aGameboard := Gameboard numberOfSquares: 5 withWormholeAt: 2 and: 4.
	aDie := LoadedDie of: 6.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboard: aGameboard
		         withDie: aDie.

	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 5
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerReachesTheEndThenPlayerWins [

	| aSpaceship aGameboard aDie aGame aSpaceshipArray |
	aSpaceship := 'Galindez'.
	aSpaceshipArray := Array with: aSpaceship.
	aGameboard := Gameboard numberOfSquares: 5 withWormholeAt: 2 and: 4.
	aDie := LoadedDie of: 4.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboard: aGameboard
		         withDie: aDie.

	aGame playTurn.

	self assert: aGame winner equals: aSpaceship
]

{ #category : #tests }
SpaceshipGameTest >> testWhenSpaceshipLandsOnFirstWormholeThenMoveItToSecondWormhole [

	| aSpaceship aGameboard aDice aGame aSpaceshipArray |
	aSpaceship := 'Helado de menta granizada'.
	aSpaceshipArray := Array with: aSpaceship.
	aGameboard := Gameboard numberOfSquares: 15 withWormholeAt: 9 and: 12.
	aDice := Dice with:
		         (OrderedCollection
			          with: (LoadedDie of: 3)
			          with: (LoadedDie of: 5)).
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboard: aGameboard
		         withDie: aDice.

	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 12
]

{ #category : #tests }
SpaceshipGameTest >> testWhenSpaceshipLandsOnSecondWormholeThenMoveItToFirstWormhole [

	| aSpaceship aGameboard aDice aGame aSpaceshipArray |
	aSpaceship := 'Tornillito loco'.
	aSpaceshipArray := Array with: aSpaceship.
	aGameboard := Gameboard numberOfSquares: 15 withWormholeAt: 9 and: 12.
	aDice := Dice with:
		         (OrderedCollection
			          with: (LoadedDie of: 7)
			          with: (LoadedDie of: 4)).
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboard: aGameboard
		         withDie: aDice.

	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 9
]

{ #category : #tests }
SpaceshipGameTest >> testWhenTwoDieAreThrownMovePlayerToTheSumOfDice [

	| aSpaceship aGameboard aDice aGame aSpaceshipArray |
	aSpaceship := 'Pancho'.
	aGameboard := Gameboard numberOfSquares: 12 withWormholeAt: 2 and: 7.
	aSpaceshipArray := Array with: aSpaceship.
	aDice := Dice with:
		         (OrderedCollection
			          with: (LoadedDie of: 6)
			          with: (LoadedDie of: 3)).
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboard: aGameboard
		         withDie: aDice.

	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 10
]
