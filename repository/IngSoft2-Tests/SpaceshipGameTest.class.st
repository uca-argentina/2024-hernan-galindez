Class {
	#name : #SpaceshipGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SpaceshipGameTest >> testGameCanBeCreatedWithPlayersGameboardAndDie [
|aGame aSpaceship aGameboard aDie |


aSpaceship :=  Spaceship withName: 'Pancho'. 
aGameboard :=  Gameboard withLength: 12.
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
