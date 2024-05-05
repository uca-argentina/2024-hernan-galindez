Class {
	#name : 'SpaceshipGameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceshipGameTest >> should: anErrorBlock raise: exceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: exceptionClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
SpaceshipGameTest >> testErrorWhenGameIsOverAndItIsAttemptedToContinuePlaying [ 

| aSpaceship aGameboard aDie aGame |
aSpaceship :=  Spaceship withName: 'Hernan'. 
aGameboard :=  Gameboard numberOfSquares: 5.
aDie := LoadedDie of: 4.
aGame := SpaceshipGame withPlayers: aSpaceship withGameboard: aGameboard withDie: aDie . 

aGame playTurn.

self
	should: [ aGame playTurn ]
	raise: Error
	withMessage: 'Game is over'
]

{ #category : 'tests' }
SpaceshipGameTest >> testGameCanBeCreatedWithPlayersGameboardAndDie [
|aGame aSpaceship aGameboard aDie |


aSpaceship :=  Spaceship withName: 'Pancho'. 
aGameboard :=  Gameboard numberOfSquares: 12.
aDie := Die of: 6.
aGame := SpaceshipGame withPlayers: aSpaceship withGameboard: aGameboard withDie: aDie . 

self assert: aGame players equals: aSpaceship.
self assert: aGame gameboard equals: aGameboard.
self assert: aGame die equals: aDie.
]

{ #category : 'tests' }
SpaceshipGameTest >> testGameWinner [

| aSpaceship aGameboard aDie aGame |
aSpaceship :=  Spaceship withName: 'Galindez'. 
aGameboard :=  Gameboard numberOfSquares: 5.
aDie := LoadedDie of: 4.
aGame := SpaceshipGame withPlayers: aSpaceship withGameboard: aGameboard withDie: aDie . 

self assert: aGame winner equals: 'There is no winner yet'.

aGame playTurn.

self assert: aGame winner equals: aSpaceship 
]

{ #category : 'tests' }
SpaceshipGameTest >> testWhenAGameIsCreatedCheckThatItIsNotOver [
|aGame aSpaceship aGameboard aDie |

aSpaceship :=  Spaceship withName: 'Pancho'. 
aGameboard :=  Gameboard numberOfSquares: 12.
aDie := LoadedDie of: 6.
aGame := SpaceshipGame withPlayers: aSpaceship withGameboard: aGameboard withDie: aDie . 
self deny: (aGame isOver)
]

{ #category : 'tests' }
SpaceshipGameTest >> testWhenAPlayerReachesTheEndTheGameFinishes [ 
| aSpaceship aGameboard aDie aGame |

aSpaceship :=  Spaceship withName: 'Zalo'. 
aGameboard :=  Gameboard numberOfSquares: 13.
aDie := LoadedDie of: 6.
aGame := SpaceshipGame withPlayers: aSpaceship withGameboard: aGameboard withDie: aDie . 

aGame playTurn.
aGame playTurn.

self assert: aGame isOver.  

]

{ #category : 'tests' }
SpaceshipGameTest >> testWhenASixIsThrownOnFirstTurnNextPositionIsSeven [ 
| aSpaceship aGameboard aDie aGame |

aSpaceship :=  Spaceship withName: 'Pancho'. 
aGameboard :=  Gameboard numberOfSquares: 12.
aDie := LoadedDie of: 6.
aGame := SpaceshipGame withPlayers: aSpaceship withGameboard: aGameboard withDie: aDie . 

aGame playTurn.

self assert: (aGame positionOf: aSpaceship) equals: 7 
]

{ #category : 'tests' }
SpaceshipGameTest >> testWhenCreatingTheGameCheckThatTheSpaceshipsAreInTheFirstSquare [ 
|aGame aSpaceship aGameboard aDie |

aSpaceship :=  Spaceship withName: 'Pancho'. 
aGameboard :=  Gameboard numberOfSquares: 12.
aDie := LoadedDie of: 6.
aGame := SpaceshipGame withPlayers: aSpaceship withGameboard: aGameboard withDie: aDie . 

self assert: (aGameboard at: 1) equals: aSpaceship.
]

{ #category : 'tests' }
SpaceshipGameTest >> testWhenTargetIsOutOfBoundMoveToTheEnd [ 

| aSpaceship aGameboard aDie aGame |
aSpaceship :=  Spaceship withName: 'Zepo'. 
aGameboard :=  Gameboard numberOfSquares: 5.
aDie := LoadedDie of: 6.
aGame := SpaceshipGame withPlayers: aSpaceship withGameboard: aGameboard withDie: aDie . 

aGame playTurn.

self assert: (aGame positionOf: aSpaceship) equals: 5.


]
