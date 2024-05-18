Class {
	#name : #SpaceshipGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'gameboard',
		'dice',
		'isOver',
		'winner',
		'currentTurn',
		'square'
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

	| lastSquarePosition |
	lastSquarePosition := gameboard size.
	^ self players anySatisfy: [ :aSpaceship |
		  (self positionOf: aSpaceship) = lastSquarePosition ]
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
	self winner.
	self verifyGameIsNotOver.
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
SpaceshipGame >> winner [
	| lastSquarePosition |
	lastSquarePosition := gameboard size.

	self players do: [:aSpaceship |
		(self positionOf: aSpaceship) = lastSquarePosition ifTrue: [ ^ aSpaceship ]].

	^ 'There is no winner yet'

]
