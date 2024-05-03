Class {
	#name : #SpaceshipGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
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

{ #category : #tests }
SpaceshipGameTest >> testWhenAGameIsCreatedCheckThatItIsNotOver [
| aGame |

aGame := SpaceshipGame new.
self deny: (aGame isOver)
]

{ #category : #tests }
SpaceshipGameTest >> testWhenASixIsThrownOnFirstTurnNextPositionIsSeven [ 
| aSpaceship aGameboard aDie aGame |

aSpaceship :=  Spaceship withName: 'Pancho'. 
aGameboard :=  Gameboard numberOfSquares: 12.
aDie := LoadedDie of: 6.
aGame := SpaceshipGame withPlayers: aSpaceship withGameboard: aGameboard withDie: aDie . 

aGame playTurn.

self assert: (aGame positionOf: aSpaceship) equals: 7 
]

{ #category : #tests }
SpaceshipGameTest >> testWhenCreatingTheGameCheckThatTheSpaceshipsAreInTheFirstSquare [ 
|aGame aSpaceship aGameboard aDie |

aSpaceship :=  Spaceship withName: 'Pancho'. 
aGameboard :=  Gameboard numberOfSquares: 12.
aDie := LoadedDie of: 6.
aGame := SpaceshipGame withPlayers: aSpaceship withGameboard: aGameboard withDie: aDie . 

self assert: (aGameboard at: 1) equals: aSpaceship.
]