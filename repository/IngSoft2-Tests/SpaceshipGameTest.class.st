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
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100.

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
	aDiceCollection := { (LoadedDie sequence: #( 15 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100.

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
		                   with: (LoadedDie sequence: #( 20 ))
		                   with: (LoadedDie sequence: #( 15 )).
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 10
		         withDice: aDiceCollection
		         withLaps: 3
		         withParsecs: 100.

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
		         withDice: aDiceCollection
		         withLaps: 3
		         withParsecs: 100.

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
	aDiceCollection := { (LoadedDie sequence: #( 9 7 3 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 11
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100.

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
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100.

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
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100.
	self deny: aGame isOver
]

{ #category : #tests }
SpaceshipGameTest >> testWhenAPlayerReachesTheEndTheGameFinishes [

	| aSpaceship aDiceCollection aGame aSpaceshipArray |
	aSpaceship := 'Zalo'.
	aSpaceshipArray := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 13 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboardLength: 13
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100.

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
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100.

	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 7
]

{ #category : #tests }
SpaceshipGameTest >> testWhenCreatingTheGameCheckThatTheSpaceshipsAreInTheFirstSquare [

	| aGame aSpaceship aDiceCollection aSpaceshipCollection |
	aSpaceship := 'Pancho'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 6 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 12
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100.

	self assert: (aGame positionOf: aSpaceship) equals: 1
]

{ #category : #tests }
SpaceshipGameTest >> testWhenFirstPlayerLandsOnHyperJumpThenItStaysInTheSamePositionAndTheNextPlayerThatLandsOnItMovesOneSquareForward [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection aSpaceship2 |
	aSpaceship := 'Banana'.
	aSpaceship2 := 'Dolca'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: aSpaceship2.
	aDiceCollection := { (LoadedDie sequence: #( 9 9 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 10
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100.

	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 10.
	self assert: (aGame positionOf: aSpaceship2) equals: 1
]

{ #category : #tests }
SpaceshipGameTest >> testWhenGameFinishesGivesTheRankingOfTheSpaceships [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection aSpaceship2 aSpaceship3 |
	aSpaceship := 'Pancho'.
	aSpaceship2 := 'Zepo'.
	aSpaceship3 := 'Zalo'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: aSpaceship2
		                        with: aSpaceship3.
	aDiceCollection := { (LoadedDie sequence: #( 15 10 3 10 16 7 5 50 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 150.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

"	self assert: (aGame positionOf: aSpaceship) equals: 1.
	self assert: (aGame positionOf: aSpaceship2) equals: 12.
	self assert: (aGame positionOf: aSpaceship3) equals: 12"
	
	self assert: (aGame rankings) equals: #('Pancho' 'Zepo' 'Zalo') asOrderedCollection . 


]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerCompletesLapAndLandsOnBlackHoleInInitialSquaresThenGoesBackwardsToPreviousLap [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection |
	aSpaceship := 'Zalon'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 10 4 3 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100.

	aGame playTurn.
	aGame playTurn.
	aGame skipTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 14
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerIsInInitialSquaresOfTheSecondLapAndAnotherPlayerLandsOnMoonWalkAndTheOtherPlayerRunsOutOfFuelThenItGoesBackToTheFirstSquareOnTheSameLap [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection aSpaceship2 |
	aSpaceship := 'Zalo'.
	aSpaceship2 := 'Pancho'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: aSpaceship2.
	aDiceCollection := { (LoadedDie sequence: #( 9 4 7 3 9 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 150.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship) equals: 1
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerIsInInitialSquaresOfTheSecondLapAndAnotherPlayerLandsOnMoonWalkThenItGoesBackToTheFirstLap [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection aSpaceship2 |
	aSpaceship := 'Zalo'.
	aSpaceship2 := 'Pancho'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: aSpaceship2.
	aDiceCollection := { (LoadedDie sequence: #( 10 4 6 3 10 18 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship) equals: 14.
	aGame skipTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: aGame winner equals: aSpaceship
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerLandsOnAtomicBombThenAllPlayersStartFromInitialSquareWithTheSameAmountOfFuel [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection aSpaceship2 aSpaceship3 |
	aSpaceship := 'Pancho'.
	aSpaceship2 := 'Zepo'.
	aSpaceship3 := 'Zalo'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: aSpaceship2
		                        with: aSpaceship3.
	aDiceCollection := { (LoadedDie sequence: #( 9 9 8 3 3 3 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 1.
	self assert: (aGame positionOf: aSpaceship2) equals: 1.
	self assert: (aGame positionOf: aSpaceship3) equals: 1.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 5.
	self assert: (aGame positionOf: aSpaceship2) equals: 5.
	self assert: (aGame positionOf: aSpaceship3) equals: 5
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerLandsOnBlackHoleAndRunsOutOfFuelWhenGoingBackwardsThenGoesToFirstSquareAndLosesTwoTurns [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection |
	aSpaceship := 'Zalon'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 4 4 5 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100.

	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 1
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerLandsOnBlackHoleThenMovesBackFourSquares [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection |
	aSpaceship := 'Zalon'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 4 4 8 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100.

	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 4
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerLandsOnHyperGravityAndThrowsANumberLowerThanExpectedNumberThenStaysInTheSamePosition [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection |
	aSpaceship := 'Pancho'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 5 3 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100.

	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 6
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerLandsOnHyperGravityAndThrowsHigherNumberThanNumberExpectedThenItMovesFowardAgain [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection |
	aSpaceship := 'Pancho'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 5 7 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100.

	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 13
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerLandsOnMoonWalkThenAllOtherSpaceshipsMoveThreeSquaresBack [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection aSpaceship2 aSpaceship3 |
	aSpaceship := 'Pancho'.
	aSpaceship2 := 'Zepo'.
	aSpaceship3 := 'Zalo'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: aSpaceship2
		                        with: aSpaceship3.
	aDiceCollection := { (LoadedDie sequence: #( 4 3 4 3 10 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 7.
	self assert: (aGame positionOf: aSpaceship2) equals: 2.
	self assert: (aGame positionOf: aSpaceship3) equals: 1
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerLandsOnMoonwalkThenOtherPlayersMoveBackwardsAndRunsOutOfFuel [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection aSpaceship2 |
	aSpaceship := 'Pancho'.
	aSpaceship2 := 'Zepo'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: aSpaceship2.

	aDiceCollection := { (LoadedDie sequence: #( 4 4 6 3 6 )) }.

	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame skipTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 1.
	self assert: (aGame positionOf: aSpaceship2) equals: 13
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
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100.

	aGame playTurn.

	self deny: aGame isOver
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerReachesTheEndThenPlayerWins [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection |
	aSpaceship := 'Galindez'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 15 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100.

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

	aDiceCollection := { (LoadedDie sequence: #( 9 4 9 6 3 )) }.

	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 1.
	self assert: (aGame positionOf: anotherSpaceship) equals: 14
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerSkipsTurnThenItStaysInTheSamePosition [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 9 9 4 10 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100.

	aGame playTurn.
	aGame playTurn.
	aGame skipTurn.
	aGame playTurn.


	self assert: (aGame positionOf: aSpaceship) equals: 10.
	self assert: (aGame positionOf: anotherSpaceship) equals: 15
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerSkipsTurnThenRefuels [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection |
	aSpaceship := 'Pancho'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 9 9 )) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100.

	aGame playTurn.
	aGame skipTurn.
	aGame playTurn.


	self assert: (aGame positionOf: aSpaceship) equals: 5
]

{ #category : #tests }
SpaceshipGameTest >> testWhenSomePlayersMoveGivesThePositionOfTheSpaceships [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := OrderedCollection with:
		                   (LoadedDie sequence: #( 9 5 3 3 9 )).
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 13.
	self assert: (aGame positionOf: anotherSpaceship) equals: 6
]

{ #category : #tests }
SpaceshipGameTest >> testWhenSpaceshipLandsOnFirstWormholeThenMoveItToSecondWormhole [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection |
	aSpaceship := 'Helado de menta granizada'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := OrderedCollection with:
		                   (LoadedDie sequence: #( 3 )).
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100.

	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 5
]

{ #category : #tests }
SpaceshipGameTest >> testWhenSpaceshipLandsOnSecondWormholeThenMoveItToFirstWormhole [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection |
	aSpaceship := 'Tornillito loco'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := OrderedCollection with:
		                   (LoadedDie sequence: #( 4 )).
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100.

	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 4
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
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100.

	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 10
]
