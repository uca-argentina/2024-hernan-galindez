Class {
	#name : #SpaceshipGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'gameboard',
		'dice',
		'currentTurn',
		'numberOfLaps'
	],
	#category : 'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipGame class >> withPlayers: aCollection withGameboard: aGameboard withDie: aDice withLaps: aNumberOfLaps [

	^ self new
		  initializeWithPlayers: aCollection
		  withGameboard: aGameboard
		  withDie: aDice
		  withLaps: aNumberOfLaps
]

{ #category : #initialization }
SpaceshipGame >> initializeWithPlayers: aCollectionOfPlayers withGameboard: aGameboard withDie: aDice withLaps: aNumberOfLaps [

	players := aCollectionOfPlayers collect: [ :playerName |
		           Spaceship withName: playerName ].
	aGameboard setPlayersAtFirstPosition: players.
	gameboard := aGameboard.
	dice := aDice.
	currentTurn := 1.
	numberOfLaps := aNumberOfLaps
]

{ #category : #'game logic' }
SpaceshipGame >> isOver [

	^ players anySatisfy: [ :aSpaceship |
		  aSpaceship lapsCompleted >= numberOfLaps ]
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
SpaceshipGame >> positionOf: aSpaceshipName [

	| aSpaceship |
	aSpaceship := players detect: [ :player |
		              player name = aSpaceshipName ] ifNone:[aSpaceshipName].
	^ gameboard find: aSpaceship
]

{ #category : #'game logic' }
SpaceshipGame >> verifyGameIsNotOver [

	self isOver ifTrue: [ Error signal: 'Game is over' ]
]

{ #category : #'game logic' }
SpaceshipGame >> winner [

	| lastSquarePosition spaceshipWinner |
	lastSquarePosition := gameboard size.

	spaceshipWinner := players
		                   detect: [ :player |
		                   player lapsCompleted >= numberOfLaps ]
		                   ifNone: [ Error signal: 'There is no winner yet' ].
	^spaceshipWinner name
]
