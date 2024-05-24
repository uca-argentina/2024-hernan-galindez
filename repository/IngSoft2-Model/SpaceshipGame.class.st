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
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipGame class >> withPlayers: somePlayers withGameboardLength: aLength withWormholesPoisitions: wormholePositions withDice: aDiceCollection withLaps: anAmountOfLaps [

	^ self new
		  initializeWithPlayers: somePlayers
		  withGameboardLength: aLength
		  withWormholesPoisitions: wormholePositions
		  withDice: aDiceCollection
		  withLaps: anAmountOfLaps
]

{ #category : #initialization }
SpaceshipGame >> initializeWithPlayers: aCollectionOfPlayers withGameboardLength: aLength withWormholesPoisitions: wormholePositions withDice: aDiceCollection withLaps: anAmountOfLaps [

	dice := Dice with: aDiceCollection copy.
	players := aCollectionOfPlayers collect: [ :playerName |
		           Spaceship
			           withName: playerName
			           withFuel: dice maxThrow * 2 ].
	gameboard := Gameboard
		             numberOfSquares: aLength
		             withWormholeAt: (wormholePositions at: 1)
		             and: (wormholePositions at: 2).
	gameboard setPlayersAtFirstPosition: players.


	currentTurn := 1.
	numberOfLaps := anAmountOfLaps
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
	"gameboard move: currentPlayer with: aNumber."
	currentPlayer move: aNumber in: gameboard.
	currentTurn := self nextTurn
]

{ #category : #'game logic' }
SpaceshipGame >> positionOf: aSpaceshipName [

	| aSpaceship |
	aSpaceship := players detect: [ :player |
		              player name = aSpaceshipName ].
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
