Class {
	#name : #SpaceshipGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'gameboard',
		'dice',
		'numberOfLaps',
		'turnHandler'
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

	turnHandler := Dictionary
		               newFromKeys: players
		               andValues:
		               (OrderedCollection new: players size withAll: 0).

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

	[ (turnHandler at: currentPlayer) = 0 ] whileFalse: [
		turnHandler at: currentPlayer update: [ :x | x + 1 ].
		currentPlayer refuel.
		currentPlayer := players removeFirst.
		players addLast: currentPlayer ].

	^ currentPlayer
]

{ #category : #'game controls' }
SpaceshipGame >> playTurn [

	| aNumber spaceshipToPlay lostTurns |
	self verifyGameIsNotOver.
	aNumber := dice throw.
	spaceshipToPlay := self nextPlayer.
	lostTurns := spaceshipToPlay move: aNumber in: gameboard.
	turnHandler at: spaceshipToPlay update: [ :x | x - lostTurns ]
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
	currentPlayer := players removeFirst.
	players addLast: currentPlayer.

	turnHandler at: currentPlayer update: [ :aNumber | aNumber - 1 ]
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
