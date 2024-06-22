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
SpaceshipGameTest >> testCancellationCardCanBeUsedAtAnyMomentOfTheGame [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 9 7 3 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 11
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: {
				         Overload.
				         Cancellation }.


	aGame
		playCard: Overload new
		from: aSpaceship
		target:  anotherSpaceship .
	aGame
		playCard: Cancellation new
		from: anotherSpaceship
		target: Overload new.

	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 10.
	self assert: (aGame positionOf: anotherSpaceship) equals: 8
]

{ #category : #tests }
SpaceshipGameTest >> testErrorWhenAPlayerUsesCancellationCardAndNoOtherCardsWhereUsed [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection specificGenerator overloadCard |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 9 7 2 3 10 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	overloadCard := Overload new.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: {
				         Overload.
				         Cancellation }.
	aGame playTurn.

	self
		should: [
			aGame
				playCard: Cancellation new
				from: anotherSpaceship
				target: Overload new  ]
		raise: Error
		withMessage: 'Overload card was not used on this spaceship'
]

{ #category : #tests }
SpaceshipGameTest >> testErrorWhenAskedForAWinnerAndThereIsNone [

	| aSpaceship aDiceCollection aGame aSpaceshipArray specificGenerator |
	aSpaceship := 'Galindez'.
	aSpaceshipArray := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 4 )) }.

	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.

	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: {  }
		         cards: { Overload . Ally . Acceleration  }.
	self
		should: [ aGame winner ]
		raise: Error
		withMessage: 'There is no winner yet'
]

{ #category : #tests }
SpaceshipGameTest >> testErrorWhenGameIsOverAndItIsAttemptedToContinuePlaying [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection specificGenerator |
	aSpaceship := 'Hernan'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 15 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.

	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.


	aGame playTurn.

	self
		should: [ aGame playTurn ]
		raise: Error
		withMessage: 'Game is over'
]

{ #category : #tests }
SpaceshipGameTest >> testErrorWhenPlayerWantsToPlayOverloadCardWhenItsNotHisTurn [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection specificGenerator overloadCard |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 9 7 3 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	overloadCard := Overload new.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 11
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.


	self
		should: [
			aGame
				playCard: Overload new
				from: anotherSpaceship
				target: { aSpaceship } ]
		raise: Error
		withMessage: 'You can only play this card when its your turn'
]

{ #category : #tests }
SpaceshipGameTest >> testErrorWhenRedoCardIsUsedAndNoOtherCardsWereUsed [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 9 7 3 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 11
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: {
				         Redo.
				         Cancellation.
				         Overload }.


	self
		should: [
		aGame playCard: Redo new from: aSpaceship target: anotherSpaceship ]
		raise: Error
		withMessage: 'There is no card to redo'
]

{ #category : #tests }
SpaceshipGameTest >> testGameEndsWhenSpaceshipCompletesRequiredLaps [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection specificGenerator |
	aSpaceship := 'zepito'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := OrderedCollection
		                   with: (LoadedDie sequence: #( 20 ))
		                   with: (LoadedDie sequence: #( 15 )).
	specificGenerator := SpecificSquareGenerator with:

		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 10
		         withDice: aDiceCollection
		         withLaps: 3
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.


	aGame playTurn.

	self assert: aGame isOver
]

{ #category : #tests }
SpaceshipGameTest >> testGameWinnerWithMoreThanOneLap [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection normalSquare probabilityGenerator |
	aSpaceship := 'zepito'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := OrderedCollection with:
		                   (LoadedDie sequence: #( 35 )).

	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 10
		         withDice: aDiceCollection
		         withLaps: 3
		         withParsecs: 100
		         squareGenerator: probabilityGenerator.

	aGame playTurn.

	self assert: aGame winner equals: aSpaceship
]

{ #category : #tests }
SpaceshipGameTest >> testGameWinnerWithMoreThanOnePlayer [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 9 7 3 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 11
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.


	self assert: aGame winner equals: aSpaceship
]

{ #category : #tests }
SpaceshipGameTest >> testSpaceshipMovedToStartWhenFuelIsEmpty [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection specificGenerator |
	aSpaceship := 'Helado de menta granizada'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := OrderedCollection with:
		                   (LoadedDie sequence: #( 2 2 2 3 )).
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: {  }
		         cards: {
				         Overload.
				         Ally.
				         Acceleration }.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 1
]

{ #category : #tests }
SpaceshipGameTest >> testWhenAGameIsCreatedCheckThatItIsNotOver [

	| aGame aSpaceship aDiceCollection aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 6 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 12
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: {  }
		         cards: {
				         Overload.
				         Ally.
				         Acceleration }.
	self deny: aGame isOver
]

{ #category : #tests }
SpaceshipGameTest >> testWhenAPlayerReachesTheEndTheGameFinishes [

	| aSpaceship aDiceCollection aGame aSpaceshipArray specificGenerator |
	aSpaceship := 'Zalo'.
	aSpaceshipArray := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 13 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipArray
		         withGameboardLength: 13
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.

	aGame playTurn.


	self assert: aGame isOver
]

{ #category : #tests }
SpaceshipGameTest >> testWhenASixIsThrownOnFirstTurnNextPositionIsSeven [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 6 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 12
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.

	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 7
]

{ #category : #tests }
SpaceshipGameTest >> testWhenAccelerationCardIsUdedAndCancellationCardIsUsedThenNoPermanentEffectsAreApplied [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 9 7 3 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: {
				         Acceleration.
				         Cancellation }.

	aGame
		playCard: Acceleration new
		from: aSpaceship
		target: aSpaceshipCollection.
	aGame
		playCard: Cancellation new
		from: aSpaceship
		target: Acceleration new.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 10.
	self assert: (aGame positionOf: anotherSpaceship) equals: 8
]

{ #category : #tests }
SpaceshipGameTest >> testWhenAccelerationCardIsUsedThenAllSpaceshipsTotalThrowAreIncrementedByOne [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 9 7 3 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: {
				         Acceleration.
				         Cancellation }.

	aGame
		playCard: Acceleration new
		from: aSpaceship
		target: aSpaceshipCollection.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 11.
	self assert: (aGame positionOf: anotherSpaceship) equals: 9
]

{ #category : #tests }
SpaceshipGameTest >> testWhenAllyCardIsUsedAndBothSpaceshipsDoesNotHaveEnoughFuelThenBothOfThemGoToTheStart [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection specificGenerator allyCard |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 5 5 5 5 5 6 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	allyCard := Ally new.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 13
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.

	aGame playCard: allyCard from: aSpaceship target:  anotherSpaceship .
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 1.
	self assert: (aGame positionOf: anotherSpaceship) equals: 1
]

{ #category : #tests }
SpaceshipGameTest >> testWhenAllyCardIsUsedAndBothSpaceshipsDoesNotHaveEnoughFuelThenBothOfThemGoToTheStartAndLoseTwoTurns [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection specificGenerator yetAnothherSpaceship allyCard |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	yetAnothherSpaceship := 'Zepo'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship
		                        with: yetAnothherSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 5 5 2 5 5 2 5 2 2 6 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	allyCard := Ally new.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 13
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.

	aGame playCard: allyCard from: aSpaceship target: anotherSpaceship.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.



	self assert: (aGame positionOf: aSpaceship) equals: 1.
	self assert: (aGame positionOf: anotherSpaceship) equals: 1.
	self assert: (aGame positionOf: yetAnothherSpaceship) equals: 9
]

{ #category : #tests }
SpaceshipGameTest >> testWhenAllyCardIsUsedAndOnePlayerDoesNotHaveFuelRequiredToMoveThenItUsesTheAllyFuel [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 5 2 5 2 4 6 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 20
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.

	aGame playCard: Ally new from: aSpaceship target: anotherSpaceship.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.


	self assert: (aGame positionOf: aSpaceship) equals: 15
]

{ #category : #tests }
SpaceshipGameTest >> testWhenCancellationCardIsUsedAndRedoCardIsUsedThenRedoCardCancellsTheTargetCard [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 5 5 6 7 10 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (CardSquare create -> 6) }.

	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 20
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: {
				         Overload.
				         Cancellation.
				         Redo }.

	aGame
		playCard: Overload new
		from: aSpaceship
		target: anotherSpaceship.

	aGame playTurn.

	aGame
		playCard: Overload new
		from: anotherSpaceship
		target: aSpaceship.

	aGame playTurn.

	aGame
		playCard: Cancellation new
		from: anotherSpaceship
		target: Overload new.
	aGame playCard: Redo new from: aSpaceship target: Overload new.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 12.
	self assert: (aGame positionOf: anotherSpaceship) equals: 11
]

{ #category : #tests }
SpaceshipGameTest >> testWhenCancellationCardIsUsedOnAllyCardThenFuelIsNotLongerShared [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 5 2 5 2 4 6 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 20
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: {
				         Ally.
				         Cancellation }.

	aGame playCard: Ally new from: aSpaceship target: anotherSpaceship.
	aGame playCard: Cancellation new from: aSpaceship target: Ally new.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.


	self assert: (aGame positionOf: aSpaceship) equals: 1
]

{ #category : #tests }
SpaceshipGameTest >> testWhenCancellationCardIsUsedThenItRemovesTheOtherCardEffect [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection specificGenerator overloadCard |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 9 7 2 3 10 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	overloadCard := Overload new.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: {
				         Overload.
				         Cancellation }.
	aGame
		playCard: Overload new
		from: aSpaceship
		target: anotherSpaceship.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame
		playCard: Cancellation new
		from: anotherSpaceship
		target: Overload new.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 12.
	self assert: (aGame positionOf: anotherSpaceship) equals: 9
]

{ #category : #tests }
SpaceshipGameTest >> testWhenCreatingTheGameCheckThatTheSpaceshipsAreInTheFirstSquare [

	| aGame aSpaceship aDiceCollection aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 6 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 12
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: {  }
		         cards: {
				         Overload.
				         Ally.
				         Acceleration }.


	self assert: (aGame positionOf: aSpaceship) equals: 1
]

{ #category : #tests }
SpaceshipGameTest >> testWhenFirstPlayerLandsOnHyperJumpThenItStaysInTheSamePositionAndTheNextPlayerThatLandsOnItMovesOneSquareForward [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection aSpaceship2 specificGenerator |
	aSpaceship := 'Banana'.
	aSpaceship2 := 'Dolca'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: aSpaceship2.
	aDiceCollection := { (LoadedDie sequence: #( 9 9 )) }.
	specificGenerator := SpecificSquareGenerator with: { ((HyperJump with: {
				                       (Parsecs of: 4).
				                       (LightYears of: 33) }) -> 10) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 150
		         squareGenerator: specificGenerator
		         rewards: (DecrementCurrentFuel by: 1)
		         cards: {
				         Overload.
				         Ally.
				         Acceleration }.



	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 10.
	self assert: (aGame positionOf: aSpaceship2) equals: 11
]

{ #category : #tests }
SpaceshipGameTest >> testWhenGameFinishesGivesTheRankingOfTheSpaceships [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection aSpaceship2 aSpaceship3 specificGenerator |
	aSpaceship := 'Pancho'.
	aSpaceship2 := 'Zepo'.
	aSpaceship3 := 'Zalo'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: aSpaceship2
		                        with: aSpaceship3.
	aDiceCollection := { (LoadedDie sequence: #( 15 10 3 10 16 7 5 50 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 150
		         squareGenerator: specificGenerator
		         rewards: {  }
		         cards: {
				         Overload.
				         Ally.
				         Acceleration }.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.


	self
		assert: aGame rankings
		equals: #( 'Pancho' 'Zepo' 'Zalo' ) asOrderedCollection
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerCompletesLapAndLandsOnBlackHoleInInitialSquaresThenGoesBackwardsToPreviousLap [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection specificGenerator |
	aSpaceship := 'Zalon'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 10 4 3 )) }.
	specificGenerator := SpecificSquareGenerator with: {
			                     (BlackHole create -> 3).
			                     (BlackHole create -> 8) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.

	aGame playTurn.
	aGame playTurn.
	aGame skipTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 14
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerIsInInitialSquaresOfTheSecondLapAndAnotherPlayerLandsOnMoonWalkAndTheOtherPlayerRunsOutOfFuelThenItGoesBackToTheFirstSquareOnTheSameLap [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection aSpaceship2 specificGenerator |
	aSpaceship := 'Zalo'.
	aSpaceship2 := 'Pancho'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: aSpaceship2.
	aDiceCollection := { (LoadedDie sequence: #( 9 3 7 3 9 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { ((MoonWalk withSquaresToMove: 3) -> 7) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 150
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.


	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame positionOf: aSpaceship) equals: 1
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerIsInInitialSquaresOfTheSecondLapAndAnotherPlayerLandsOnMoonWalkThenItGoesBackToTheFirstLap [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection aSpaceship2 specificGenerator |
	aSpaceship := 'Zalo'.
	aSpaceship2 := 'Pancho'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: aSpaceship2.
	aDiceCollection := { (LoadedDie sequence: #( 10 3 6 3 10 18 )) }.
	specificGenerator := SpecificSquareGenerator with:

		                     { ((MoonWalk withSquaresToMove: 3) -> 7) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.

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

	| aSpaceship aDiceCollection aGame aSpaceshipCollection aSpaceship2 aSpaceship3 specificGenerator |
	aSpaceship := 'Pancho'.
	aSpaceship2 := 'Zepo'.
	aSpaceship3 := 'Zalo'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: aSpaceship2
		                        with: aSpaceship3.
	aDiceCollection := { (LoadedDie sequence: #( 9 9 8 4 4 4 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (AtomicBomb create -> 9) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.

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
SpaceshipGameTest >> testWhenPlayerLandsOnBlackHoleAndRepeatCardIsUsedThenBlackHoleEffectIsAppliedToTheChoosenPlayer [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 9 6 15 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (BlackHole create -> 10) }.

	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: {
				         Repeat.
				         Overload.
				         Ally }.

	aGame playTurn.
	aGame playCard: Repeat new from: anotherSpaceship target: aSpaceship.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 2.
	self assert: (aGame positionOf: anotherSpaceship) equals: 7
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerLandsOnBlackHoleAndRunsOutOfFuelWhenGoingBackwardsThenGoesToFirstSquareAndLosesTwoTurns [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection specificGenerator |
	aSpaceship := 'Zalon'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 1 3 3 4 )) }.
	specificGenerator := SpecificSquareGenerator with:

		                     { (BlackHole create -> 8) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: {  }
		         cards: {
				         Overload.
				         Ally.
				         Acceleration }.

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 1
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerLandsOnBlackHoleThenMovesBackFourSquares [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection specificGenerator |
	aSpaceship := 'Zalo4'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 3 4 8 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (BlackHole create -> 8) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: {  }
		         cards: {
				         Overload.
				         Ally.
				         Acceleration }.


	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 4
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerLandsOnCardSquareThenHeCanUseOverloadCard [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 9 7 2 3 10 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (CardSquare create -> 10) }.

	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 20
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: {
				         Overload.
				         Acceleration.
				         Overload }.

	aGame
		playCard: Overload new
		from: aSpaceship
		target: anotherSpaceship.
	aGame playTurn.
	aGame playTurn.
	aGame
		playCard: Overload new
		from: aSpaceship
		target: anotherSpaceship.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 12.
	self assert: (aGame positionOf: anotherSpaceship) equals: 5
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerLandsOnHyperGravityAndThrowsANumberLowerThanExpectedNumberThenStaysInTheSamePosition [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 5 3 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { ((HyperGravity withExpectedNumber: 4) -> 6) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.

	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 6
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerLandsOnHyperGravityAndThrowsHigherNumberThanNumberExpectedThenItMovesFowardAgain [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 5 7 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { ((HyperGravity withExpectedNumber: 4) -> 6) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.

	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 13
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerLandsOnMoonWalkThenAllOtherSpaceshipsMoveThreeSquaresBack [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection aSpaceship2 aSpaceship3 specificGenerator |
	aSpaceship := 'Pancho'.
	aSpaceship2 := 'Zepo'.
	aSpaceship3 := 'Zalo'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: aSpaceship2
		                        with: aSpaceship3.
	aDiceCollection := { (LoadedDie sequence: #( 3 4 3 3 10 )) }.
	specificGenerator := SpecificSquareGenerator with:

		                     { ((MoonWalk withSquaresToMove: 3) -> 7) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: {  }
		         cards: {
				         Overload.
				         Ally.
				         Acceleration }.

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

	| aSpaceship aDiceCollection aGame aSpaceshipCollection aSpaceship2 specificGenerator |
	aSpaceship := 'Pancho'.
	aSpaceship2 := 'Zepo'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: aSpaceship2.

	aDiceCollection := { (LoadedDie sequence: #( 3 3 5 3 6 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { ((MoonWalk withSquaresToMove: 5) -> 7) }.

	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.

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

	| aSpaceship aDiceCollection aGame aSpaceshipCollection specificGenerator |
	aSpaceship := 'Jorge Spaceship'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := OrderedCollection
		                   with: (LoadedDie sequence: #( 10 ))
		                   with: (LoadedDie sequence: #( 5 )).
	specificGenerator := SpecificSquareGenerator with:

		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.


	aGame playTurn.

	self deny: aGame isOver
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerReachesTheEndThenPlayerWins [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection specificGenerator |
	aSpaceship := 'Galindez'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 15 )) }.
	specificGenerator := SpecificSquareGenerator with:

		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.



	aGame playTurn.

	self assert: aGame winner equals: aSpaceship
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerRunsOutOfFuelThenGoesToStartAndLosesTwoTurns [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.

	aDiceCollection := { (LoadedDie sequence: #( 9 4 9 1 2 6 3 10 )) }.
	specificGenerator := SpecificSquareGenerator with:

		                     { (NormalSquare create -> 1) }.

	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 20
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: {  }
		         cards: {
				         Overload.
				         Ally.
				         Acceleration }.


	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 1.
	self assert: (aGame positionOf: anotherSpaceship) equals: 15
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerSkipsTurnThenItStaysInTheSamePosition [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 9 9 4 10 )) }.
	specificGenerator := SpecificSquareGenerator with:

		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: {  }
		         cards: {
				         Overload.
				         Ally.
				         Acceleration }.

	aGame playTurn.
	aGame playTurn.
	aGame skipTurn.
	aGame playTurn.


	self assert: (aGame positionOf: aSpaceship) equals: 10.
	self assert: (aGame positionOf: anotherSpaceship) equals: 14
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerSkipsTurnThenRefuels [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 9 9 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.

	aGame playTurn.
	aGame skipTurn.
	aGame playTurn.


	self assert: (aGame positionOf: aSpaceship) equals: 4
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerUsesOverloadCardThenTheOtherSpaceshipReducesItsTotalThrowByTwo [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 9 7 3 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 11
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.

	aGame
		playCard: Overload new
		from: aSpaceship
		target: anotherSpaceship.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 10.
	self assert: (aGame positionOf: anotherSpaceship) equals: 6

]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayersCompleteALapThenShowNumbersOfLapsCompleted [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection aSpaceship2 specificGenerator |
	aSpaceship := 'Banana'.
	aSpaceship2 := 'Dolca'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: aSpaceship2.
	aDiceCollection := { (LoadedDie sequence: #( 15 15 )) }.
	specificGenerator := SpecificSquareGenerator with:

		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.


	aGame playTurn.

	self assert: (aGame lapsCompletedOf: aSpaceship) equals: 1.

	aGame playTurn.

	self assert: (aGame lapsCompletedOf: aSpaceship2) equals: 1
]



{ #category : #tests }
SpaceshipGameTest >> testWhenSomePlayersMoveGivesThePositionOfTheSpaceships [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := OrderedCollection with:
		                   (LoadedDie sequence: #( 9 5 3 3 9 )).
	specificGenerator := SpecificSquareGenerator with:

		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 13.
	self assert: (aGame positionOf: anotherSpaceship) equals: 6
]

{ #category : #tests }
SpaceshipGameTest >> testWhenSpaceshipLandsOnFirstWormholeThenMoveItToSecondWormhole [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection specificGenerator |
	aSpaceship := 'Helado de menta granizada'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := OrderedCollection with:
		                   (LoadedDie sequence: #( 3 )).
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.


	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 4
]

{ #category : #tests }
SpaceshipGameTest >> testWhenSpaceshipLandsOnSecondWormholeThenMoveItToFirstWormhole [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection wormholePair wormhole anotherWormhole specificGenerator |
	aSpaceship := 'Tornillito loco'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := OrderedCollection with:
		                   (LoadedDie sequence: #( 4 )).
	wormholePair := Wormhole newPair.
	wormhole := wormholePair first.
	anotherWormhole := wormholePair second.
	specificGenerator := SpecificSquareGenerator with: {
			                     (wormhole -> 4).
			                     (anotherWormhole -> 5) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 15
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.


	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 4
]

{ #category : #tests }
SpaceshipGameTest >> testWhenSpaceshipThrowsMaxThrowThenItsCurrentFuelItsDecrementedByOne [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 6 5 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 20
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (DecrementCurrentFuel by: 1)
		         cards: {
				         Overload.
				         Ally.
				         Acceleration }.

	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 1
]

{ #category : #tests }
SpaceshipGameTest >> testWhenSpaceshipThrowsMaxThrowThenItsFuelCapacityItsIncrementedByOne [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 6 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 20
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.

	aGame playTurn.
	aGame skipTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 19
]

{ #category : #tests }
SpaceshipGameTest >> testWhenTwoDieAreThrownMovePlayerToTheSumOfDice [

	| aSpaceship aDiceCollection aGame aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	aSpaceshipCollection := OrderedCollection with: aSpaceship.
	aDiceCollection := OrderedCollection
		                   with: (LoadedDie sequence: #( 6 ))
		                   with: (LoadedDie sequence: #( 3 )).
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 1) }.
	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 12
		         withDice: aDiceCollection
		         withLaps: 2
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: { Overload . Ally . Acceleration }.

	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 10
]

{ #category : #tests }
SpaceshipGameTest >> testWhenTwoRedoCardAreUsedThenItRedoesTheSameCardTwice [

	| aSpaceship aDiceCollection aGame anotherSpaceship aSpaceshipCollection specificGenerator |
	aSpaceship := 'Pancho'.
	anotherSpaceship := 'Seijas'.
	aSpaceshipCollection := OrderedCollection
		                        with: aSpaceship
		                        with: anotherSpaceship.
	aDiceCollection := { (LoadedDie sequence: #( 5 5 6 7 2 10 )) }.
	specificGenerator := SpecificSquareGenerator with:
		                     { (NormalSquare create -> 10) }.

	aGame := SpaceshipGame
		         withPlayers: aSpaceshipCollection
		         withGameboardLength: 20
		         withDice: aDiceCollection
		         withLaps: 1
		         withParsecs: 100
		         squareGenerator: specificGenerator
		         rewards: (IncrementFuelCapacity by: 1)
		         cards: {
				         Overload.
				         Redo }.


	aGame playTurn.
	aGame playTurn.

	aGame
		playCard: Overload new
		from: aSpaceship
		target: anotherSpaceship.
	aGame playCard: Redo new from: aSpaceship target: anotherSpaceship.
	aGame playTurn.
	aGame playCard: Redo new from: anotherSpaceship target: aSpaceship.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame positionOf: aSpaceship) equals: 12.
	self assert: (aGame positionOf: anotherSpaceship) equals: 9
]
