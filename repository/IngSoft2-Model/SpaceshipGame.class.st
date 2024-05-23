Class {
	#name : #SpaceshipGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'gameboard',
		'dice',
		'currentTurn'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'accesing - defaults' }
SpaceshipGame class >> withPlayers: somePlayers withGameboardLength: aLength withWormholesPoisitions: wormholePositions withDice: aDiceCollection [

	^ self new
		  initializeWithPlayers: somePlayers
		  withGameboardLength: aLength
		  withWormholesPoisitions: wormholePositions
		  withDice: aDiceCollection
]

{ #category : #initialization }
SpaceshipGame >> initializeWithPlayers: somePlayers withGameboard: aGameboard withDice: aDice [

	players := somePlayers.
	aGameboard setPlayersAtFirstPosition: somePlayers.
	gameboard := aGameboard.
	dice := aDice.
	currentTurn := 1
]

{ #category : #initialization }
SpaceshipGame >> initializeWithPlayers: somePlayers withGameboardLength: aLength withWormholesPoisitions: wormholePositions withDice: aDiceCollection [

	players := somePlayers copy.
	gameboard := Gameboard
		             numberOfSquares: aLength
		             withWormholeAt: (wormholePositions at: 1)
		             and: (wormholePositions at: 2).
	gameboard setPlayersAtFirstPosition: somePlayers.
	dice := Dice with: aDiceCollection copy.
	currentTurn := 1
]

{ #category : #'game logic' }
SpaceshipGame >> isOver [

	| lastSquarePosition |
	lastSquarePosition := gameboard size.
	^ players anySatisfy: [ :aSpaceship |
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
	currentTurn := self nextTurn
]

{ #category : #'game logic' }
SpaceshipGame >> positionOf: aSpaceship [

	^ gameboard find: aSpaceship
]

{ #category : #'game logic' }
SpaceshipGame >> verifyGameIsNotOver [

	self isOver ifTrue: [ Error signal: 'Game is over' ]
]

{ #category : #'game logic' }
SpaceshipGame >> winner [

	| lastSquarePosition |
	lastSquarePosition := gameboard size.

	^ players
		  detect: [ :player |
		  (self positionOf: player) = lastSquarePosition ]
		  ifNone: [ Error signal:'There is no winner yet' ]
]
