Class {
	#name : #SpaceshipGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'gameboard',
		'die',
		'isOver'
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
SpaceshipGame >> initializeWithPlayers: aPlayer withGameboard: aGameboard withDie: aDie [

players := aPlayer.
aGameboard setPlayers: aPlayer.
gameboard := aGameboard.
die := aDie.
isOver := false.

 
]

{ #category : #accessing }
SpaceshipGame >> isOver [
	^ isOver
]

{ #category : #accessing }
SpaceshipGame >> playTurn [
	|aNumber|
	aNumber := die throw.
	gameboard move: players with: aNumber.
	self verifyIfThePlayerReachedTheEnd: players.
]

{ #category : #testing }
SpaceshipGame >> players [
	^ players
]

{ #category : #accessing }
SpaceshipGame >> positionOf: aSpaceship [

^ gameboard indexOf: aSpaceship .
]

{ #category : #accessing }
SpaceshipGame >> verifyIfThePlayerReachedTheEnd: aSpaceship [
	|currentPosition|
	currentPosition := self positionOf: aSpaceship.
	
	(currentPosition  = gameboard size)  ifTrue:[ isOver := true ].
]
