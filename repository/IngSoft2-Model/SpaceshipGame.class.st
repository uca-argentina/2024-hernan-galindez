Class {
	#name : #SpaceshipGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'gameboard',
		'die'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'accesing - defaults' }
SpaceshipGame class >> withPlayers: aSpaceship withGameboard: aGameboard withDie: aDie [
	^ (self new) initializeWithPlayers: aSpaceship withGameboard: aGameboard withDie: aDie
]

{ #category : #testing }
SpaceshipGame >> die [
	^ die
]

{ #category : #testing }
SpaceshipGame >> gameboard [
	^ gameboard
]

{ #category : #initialization }
SpaceshipGame >> initializeWithPlayers: aSpaceship [

players := aSpaceship 
 
]

{ #category : #initialization }
SpaceshipGame >> initializeWithPlayers: aSpaceship withGameboard: aGameboard withDie: aDie [

players := aSpaceship.
gameboard := aGameboard.
die := aDie 
 
]

{ #category : #testing }
SpaceshipGame >> isOver [
	^ false
]

{ #category : #testing }
SpaceshipGame >> players [
	^ players
]
