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
SpaceshipGameTest >> testCreateAGameWithMoreThanOnePlayer [

| aSpaceship aGameboard aDie aGame aSpaceship2 aSpaceshipArray |
aSpaceship :=  Spaceship withName: 'Galindez'. 
aSpaceship2 :=  Spaceship withName: 'Hernan'. 
aSpaceshipArray := Array with: aSpaceship with: aSpaceship2.
aGameboard :=  Gameboard numberOfSquares: 5 withWormholeAt: 2 and: 4.
aDie := LoadedDie of: 4.
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDie . 


self assert: aGame players equals: aSpaceshipArray. 
]

{ #category : #tests }
SpaceshipGameTest >> testErrorWhenGameIsOverAndItIsAttemptedToContinuePlaying [ 

| aSpaceship aGameboard aDie aGame aSpaceshipArray |
aSpaceship :=  Spaceship withName: 'Hernan'. 
aSpaceshipArray := Array with: aSpaceship.
aGameboard :=  Gameboard numberOfSquares: 5 withWormholeAt: 2 and: 4.
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
aGameboard :=  Gameboard numberOfSquares: 12 withWormholeAt: 2 and: 7.
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
aGameboard :=  Gameboard numberOfSquares: 5 withWormholeAt: 2 and: 4.
aDie := LoadedDie of: 4.
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDie . 

aGame playTurn.

self assert: aGame winner equals: aSpaceship 
]

{ #category : #tests }
SpaceshipGameTest >> testGameWinnerWithMoreThanOnePlayer [

| aSpaceship aGameboard aDie aGame aSpaceship2 aSpaceshipArray |
aSpaceship :=  Spaceship withName: 'Pancho'. 
aSpaceship2 :=  Spaceship withName: 'Seijas'. 
aSpaceshipArray := Array with: aSpaceship with: aSpaceship2.
aGameboard :=  Gameboard numberOfSquares: 11 withWormholeAt:2 and: 4 .
aDie := LoadedDie of: 5.
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDie . 

aGame playTurn.
aGame playTurn.
aGame playTurn.


self assert: aGame winner equals: aSpaceship.

]

{ #category : #tests }
SpaceshipGameTest >> testWhenAGameIsCreatedCheckThatItIsNotOver [
|aGame aSpaceship aGameboard aDie aSpaceshipArray |

aSpaceship :=  Spaceship withName: 'Pancho'. 
aSpaceshipArray := Array with: aSpaceship.
aGameboard :=  Gameboard numberOfSquares: 12 withWormholeAt: 2 and: 7.
aDie := LoadedDie of: 6.
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDie . 
self deny: (aGame isOver)
]

{ #category : #tests }
SpaceshipGameTest >> testWhenAPlayerReachesTheEndTheGameFinishes [ 
| aSpaceship aGameboard aDie aGame aSpaceshipArray |

aSpaceship :=  Spaceship withName: 'Zalo'. 
aSpaceshipArray := Array with: aSpaceship.
aGameboard :=  Gameboard numberOfSquares: 13 withWormholeAt: 2 and: 7.
aDie := LoadedDie of: 12.
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDie . 

aGame playTurn.


self assert: aGame isOver.  

]

{ #category : #tests }
SpaceshipGameTest >> testWhenASixIsThrownOnFirstTurnNextPositionIsSeven [ 
| aSpaceship aGameboard aDie aGame aSpaceshipArray |

aSpaceship :=  Spaceship withName: 'Pancho'. 
aSpaceshipArray := Array with: aSpaceship.
aGameboard :=  Gameboard numberOfSquares: 12 withWormholeAt: 2 and: 9.
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
aGameboard :=  Gameboard numberOfSquares: 12 withWormholeAt: 2 and: 7.
aDie := LoadedDie of: 6.
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDie . 

self assert: (aGame positionOf: aSpaceship) equals: 1.
]

{ #category : #tests }
SpaceshipGameTest >> testWhenGameFinishGivesThePositionOfTheSpaceships [

| aSpaceship aGameboard aDie aGame anotherSpaceship aSpaceshipArray |
aSpaceship :=  Spaceship withName: 'Pancho'. 
anotherSpaceship :=  Spaceship withName: 'Seijas'. 
aSpaceshipArray := Array with: aSpaceship with: anotherSpaceship.
aGameboard :=  Gameboard numberOfSquares: 11 withWormholeAt: 2 and: 7.
aDie := LoadedDie of: 5.
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDie . 

aGame playTurn.
aGame playTurn.
aGame playTurn.

self assert: (aGame positionOf: aSpaceship) equals: 11.
self assert: (aGame positionOf: anotherSpaceship) equals: 6.

]

{ #category : #tests }
SpaceshipGameTest >> testWhenPlayerDontPlayAndAskForWinnerThenThereIsNoWinner [

| aSpaceship aGameboard aDie aGame aSpaceshipArray |
aSpaceship :=  Spaceship withName: 'Galindez'. 
aSpaceshipArray := Array with: aSpaceship.
aGameboard :=  Gameboard numberOfSquares: 5 withWormholeAt: 2 and: 4.
aDie := LoadedDie of: 4.
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDie . 

self assert: aGame winner equals: 'There is no winner yet'.
]

{ #category : #tests }
SpaceshipGameTest >> testWhenSpaceshipLandsOnFirstWormholeThenMoveItToSecondWormhole [

| aSpaceship aGameboard aDice aGame aSpaceshipArray |
aSpaceship :=  Spaceship withName: 'Helado de menta granizada'. 
aSpaceshipArray := Array with: aSpaceship.
aGameboard :=  Gameboard numberOfSquares: 15 withWormholeAt: 9 and: 12.
aDice := Dice with: (LoadedDie of: 3) with: (LoadedDie of: 5).
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDice . 

aGame playTurn.

self assert: (aGame positionOf: aSpaceship) equals: 12 
]

{ #category : #tests }
SpaceshipGameTest >> testWhenSpaceshipLandsOnSecondWormholeThenMoveItToFirstWormhole [

| aSpaceship aGameboard aDice aGame aSpaceshipArray |
aSpaceship :=  Spaceship withName: 'Tornillito loco'. 
aSpaceshipArray := Array with: aSpaceship.
aGameboard :=  Gameboard numberOfSquares: 15 withWormholeAt: 9 and: 12.
aDice := Dice with: (LoadedDie of: 7) with: (LoadedDie of: 4).
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDice . 

aGame playTurn.

self assert: (aGame positionOf: aSpaceship) equals: 9 
]

{ #category : #tests }
SpaceshipGameTest >> testWhenTargetIsOutOfBoundMoveToTheEnd [ 

| aSpaceship aGameboard aDie aGame aSpaceshipArray |
aSpaceship :=  Spaceship withName: 'Zepo'. 
aSpaceshipArray := Array with: aSpaceship.
aGameboard :=  Gameboard numberOfSquares: 5 withWormholeAt: 2 and: 4.
aDie := LoadedDie of: 6.
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDie . 

aGame playTurn.

self assert: (aGame positionOf: aSpaceship) equals: 5.


]

{ #category : #tests }
SpaceshipGameTest >> testWhenTwoDieAreThrownMovePlayerToTheSumOfDice [
| aSpaceship aGameboard aDice aGame aSpaceshipArray |

aSpaceship :=  Spaceship withName: 'Pancho'. 
aGameboard :=  Gameboard numberOfSquares: 12 withWormholeAt: 2 and: 7.
aSpaceshipArray:= Array with: aSpaceship.
aDice := Dice with:(LoadedDie of: 6) with: (LoadedDie of: 3).
aGame := SpaceshipGame withPlayers: aSpaceshipArray withGameboard: aGameboard withDie: aDice . 

aGame playTurn.

self assert: (aGame positionOf: aSpaceship) equals: 10


]
