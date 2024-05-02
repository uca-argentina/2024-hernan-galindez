Class {
	#name : #SpaceshipGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SpaceshipGameTest >> testGameCanBeCreatedWithPlayers [
|aGame aSpaceship|


aSpaceship :=  Spaceship withName: 'Pancho'. 
aGame := SpaceshipGame withPlayers: aSpaceship. 

self assert: aGame players equals: aSpaceship 
]

{ #category : #tests }
SpaceshipGameTest >> testWhenAGameIsCreatedCheckThatItIsNotOver [
| aGame |

aGame := SpaceshipGame new.
self deny: (aGame isOver)
]
