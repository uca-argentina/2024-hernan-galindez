Class {
	#name : #SpaceshipGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'gameboard',
		'dice',
		'isOver',
		'winner',
		'currentTurn'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'accesing - defaults' }
SpaceshipGame class >> withPlayers: aSpaceship withGameboard: aGameboard withDie: aDie [
	^ (self new) initializeWithPlayers: aSpaceship withGameboard: aGameboard withDice: aDie
]

{ #category : #testing }
SpaceshipGame >> dice [

	^ dice
]

{ #category : #testing }
SpaceshipGame >> gameboard [

	^ gameboard
]

{ #category : #initialization }
SpaceshipGame >> initializeWithPlayers: somePlayers withGameboard: aGameboard withDice: aDice [

	players := somePlayers.
	aGameboard setPlayers: somePlayers.
	gameboard := aGameboard.
	dice := aDice.
	currentTurn := 1.
	isOver := false.
	winner := 'There is no winner yet'
]

{ #category : #testing }
SpaceshipGame >> isOver [

	^ isOver
]

{ #category : #'game controls' }
SpaceshipGame >> nextTurn [

	currentTurn := currentTurn = players size
		               ifTrue: [ 1 ]
		               ifFalse: [ currentTurn + 1 ].
	^ currentTurn
]

{ #category : #'game controls' }
SpaceshipGame >> playTurn [

	| aNumber currentPlayer |
	self verifyGameIsNotOver.
	aNumber := dice throw.
	currentPlayer := players at: currentTurn.
	gameboard move: currentPlayer with: aNumber.
	self verifyIfThePlayerReachedTheEnd: currentPlayer.
	currentTurn := self nextTurn
]

{ #category : #testing }
SpaceshipGame >> players [

	^ players
]

{ #category : #'game logic' }
SpaceshipGame >> positionOf: aSpaceship [

	^ gameboard find: aSpaceship
]

{ #category : #'game logic' }
SpaceshipGame >> verifyGameIsNotOver [

	isOver ifTrue: [ Error signal: 'Game is over' ]
]

{ #category : #'game logic' }
SpaceshipGame >> verifyIfThePlayerReachedTheEnd: aSpaceship [

	| currentPosition |
	currentPosition := self positionOf: aSpaceship.

	currentPosition = gameboard size ifFalse: [ ^ self ].

	isOver := true.
	winner := aSpaceship
]

{ #category : #'game logic' }
SpaceshipGame >> winner [
	^ winner
]
