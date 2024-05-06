Class {
	#name : #SpaceshipGameTest,
	#superclass : #TestCase,
	#category : 'IngSoft2-Tests'
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
SpaceshipGameTest >> testCreateAGameWithMoreThanOnePlayer [

| aSpaceship aGameboard aDie aGame aSpaceship2 aSpaceshipArray |
aSpaceship :=  Spaceship withName: 'Galindez'. 
aSpaceship2 :=  Spaceship withName: 'Hernan'. 
aSpaceshipArray := Array with: aSpaceship with: aSpaceship2.
aGameboard :=  Gameboard numberOfSquares: 5.
aDie := LoadedDie of: 4.
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDie . 


self assert: aGame players equals: aSpaceshipArray. 
]

{ #category : #tests }
SpaceshipGameTest >> testErrorWhenGameIsOverAndItIsAttemptedToContinuePlaying [ 

| aSpaceship aGameboard aDie aGame aSpaceshipArray |
aSpaceship :=  Spaceship withName: 'Hernan'. 
aSpaceshipArray := Array with: aSpaceship.
aGameboard :=  Gameboard numberOfSquares: 5.
aDie := LoadedDie of: 4.
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDie . 

aGame playTurn.

self
	should: [ aGame playTurn ]
	raise: Error
	withMessage: 'Game is over'
]

{ #category : #tests }
SpaceshipGameTest >> testGameCanBeCreatedWithPlayersGameboardAndDie [
|aGame aSpaceship aGameboard aDie aSpaceshipArray |


aSpaceship :=  Spaceship withName: 'Pancho'. 
aSpaceshipArray := Array with: aSpaceship.
aGameboard :=  Gameboard numberOfSquares: 12.
aDie := Die of: 6.
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDie . 

self assert: aGame players equals: aSpaceshipArray.
self assert: aGame gameboard equals: aGameboard.
self assert: aGame dice equals: aDie.
]

{ #category : #tests }
SpaceshipGameTest >> testGameWinner [

| aSpaceship aGameboard aDie aGame aSpaceshipArray |
aSpaceship :=  Spaceship withName: 'Galindez'. 
aSpaceshipArray := Array with: aSpaceship.
aGameboard :=  Gameboard numberOfSquares: 5.
aDie := LoadedDie of: 4.
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDie . 

aGame playTurn.

self assert: aGame winner equals: aSpaceship 
]

{ #category : #tests }
SpaceshipGameTest >> testWhenAGameIsCreatedCheckThatItIsNotOver [
|aGame aSpaceship aGameboard aDie aSpaceshipArray |

aSpaceship :=  Spaceship withName: 'Pancho'. 
aSpaceshipArray := Array with: aSpaceship.
aGameboard :=  Gameboard numberOfSquares: 12.
aDie := LoadedDie of: 6.
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDie . 
self deny: (aGame isOver)
]

{ #category : #tests }
SpaceshipGameTest >> testWhenAPlayerReachesTheEndTheGameFinishes [ 
| aSpaceship aGameboard aDie aGame aSpaceshipArray |

aSpaceship :=  Spaceship withName: 'Zalo'. 
aSpaceshipArray := Array with: aSpaceship.
aGameboard :=  Gameboard numberOfSquares: 13.
aDie := LoadedDie of: 6.
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDie . 

aGame playTurn.
aGame playTurn.

self assert: aGame isOver.  

]

{ #category : #tests }
SpaceshipGameTest >> testWhenASixIsThrownOnFirstTurnNextPositionIsSeven [ 
| aSpaceship aGameboard aDie aGame aSpaceshipArray |

aSpaceship :=  Spaceship withName: 'Pancho'. 
aSpaceshipArray := Array with: aSpaceship.
aGameboard :=  Gameboard numberOfSquares: 12.
aDie := LoadedDie of: 6.
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDie . 

aGame playTurn.

self assert: (aGame positionOf: aSpaceship) equals: 7 
]

{ #category : #tests }
SpaceshipGameTest >> testWhenCreatingTheGameCheckThatTheSpaceshipsAreInTheFirstSquare [ 
|aGame aSpaceship aGameboard aDie aSpaceshipArray |

aSpaceship :=  Spaceship withName: 'Pancho'. 
aSpaceshipArray := Array with: aSpaceship.
aGameboard :=  Gameboard numberOfSquares: 12.
aDie := LoadedDie of: 6.
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDie . 

self assert: (aGame positionOf: aSpaceship) equals: 1.
]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerDontPlayAndAskForWinnerThenThereIsNoWinner [

| aSpaceship aGameboard aDie aGame aSpaceshipArray |
aSpaceship :=  Spaceship withName: 'Galindez'. 
aSpaceshipArray := Array with: aSpaceship.
aGameboard :=  Gameboard numberOfSquares: 5.
aDie := LoadedDie of: 4.
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDie . 

self assert: aGame winner equals: 'There is no winner yet'.
]

{ #category : #tests }
SpaceshipGameTest >> testWhenTargetIsOutOfBoundMoveToTheEnd [ 

| aSpaceship aGameboard aDie aGame aSpaceshipArray |
aSpaceship :=  Spaceship withName: 'Zepo'. 
aSpaceshipArray := Array with: aSpaceship.
aGameboard :=  Gameboard numberOfSquares: 5.
aDie := LoadedDie of: 6.
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDie . 

aGame playTurn.

self assert: (aGame positionOf: aSpaceship) equals: 5.


]

{ #category : #tests }
SpaceshipGameTest >> testWhenTwoDieAreThrownMovePlayerToTheSumOfDice [
| aSpaceship aGameboard aDice aGame aSpaceshipArray |

aSpaceship :=  Spaceship withName: 'Pancho'. 
aGameboard :=  Gameboard numberOfSquares: 12.
aSpaceshipArray:= Array with: aSpaceship.
aDice := Dice with:(LoadedDie of: 6) with: (LoadedDie of: 3).
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDice . 

aGame playTurn.

self assert: (aGame positionOf: aSpaceship) equals: 10


]
