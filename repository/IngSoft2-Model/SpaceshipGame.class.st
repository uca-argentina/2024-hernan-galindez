Class {
	#name : #SpaceshipGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'gameboard',
		'dice',
		'numberOfLaps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipGame class >> withPlayers: somePlayers withGameboardLength: aLength withDice: aDiceCollection withLaps: anAmountOfLaps [

	^ self new
		  initializeWithPlayers: somePlayers
		  withGameboardLength: aLength
		  withDice: aDiceCollection
		  withLaps: anAmountOfLaps
]

{ #category : #initialization }
SpaceshipGame >> initializeWithPlayers: aCollectionOfPlayers withGameboardLength: aLength withDice: aDiceCollection withLaps: anAmountOfLaps [

	dice := Dice with: aDiceCollection copy.

	players := aCollectionOfPlayers collect: [ :playerName |
		           Spaceship
			           withName: playerName
			           withFuel: dice maxThrow * 2 ].
	gameboard := Gameboard numberOfSquares: aLength spaceships: players.
	numberOfLaps := anAmountOfLaps
]

{ #category : #'game logic' }
SpaceshipGame >> isOver [

	^ players anySatisfy: [ :aSpaceship |
		  aSpaceship lapsCompleted >= numberOfLaps ]
]

{ #category : #'game logic' }
SpaceshipGame >> nextPlayer [

	| currentPlayer |
	currentPlayer := players removeFirst.
	players addLast: currentPlayer.



	[ currentPlayer canPlay ] whileFalse: [
		currentPlayer lostATurn.
		currentPlayer := players removeFirst.
		players addLast: currentPlayer ].

	^ currentPlayer
]

{ #category : #'game controls' }
SpaceshipGame >> playTurn [

	| aNumber spaceshipToPlay |
	self verifyGameIsNotOver.
	aNumber := dice throw.
	spaceshipToPlay := self nextPlayer.
	spaceshipToPlay moveFoward: aNumber in: gameboard
]

{ #category : #'game logic' }
SpaceshipGame >> positionOf: aSpaceshipName [

	| aSpaceship |
	aSpaceship := players detect: [ :player |
		              player name = aSpaceshipName ].
	^ gameboard find: aSpaceship
]

{ #category : #'game logic' }
SpaceshipGame >> skipTurn [

	| currentPlayer |
	currentPlayer := self nextPlayer.
	currentPlayer refuel
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
