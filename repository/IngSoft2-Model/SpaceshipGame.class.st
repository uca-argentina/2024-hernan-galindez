Class {
	#name : #SpaceshipGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'gameboard',
		'die',
		'isOver',
		'winner'
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
winner := 'There is no winner yet'

 
]

{ #category : #testing }
SpaceshipGame >> isOver [
	^ isOver
]

{ #category : #'game controls' }
SpaceshipGame >> playTurn [
	|aNumber|
	self verifyGameIsNotOver.
	aNumber := die throw.
	gameboard move: players with: aNumber.
	self verifyIfThePlayerReachedTheEnd: players.
]

{ #category : #testing }
SpaceshipGame >> players [
	^ players
]

{ #category : #'game logic' }
SpaceshipGame >> positionOf: aSpaceship [

^ gameboard indexOf: aSpaceship .
]

{ #category : #'game logic' }
SpaceshipGame >> verifyGameIsNotOver [
	isOver ifTrue:[Error signal: 'Game is over']
]

{ #category : #'game logic' }
SpaceshipGame >> verifyIfThePlayerReachedTheEnd: aSpaceship [
	|currentPosition|
	currentPosition := self positionOf: aSpaceship.
	
	(currentPosition  = gameboard size) ifFalse:[^ self].
	
	isOver := true.
	winner := aSpaceship.
]

{ #category : #'game logic' }
SpaceshipGame >> winner [
	^ winner
]
