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
SpaceshipGame class >> withPlayers: somePlayers withGameboardLength: aLength withDice: aDiceCollection withLaps: anAmountOfLaps withParsecs: aNumberOfParsecs squareGenerator: sqaureGenerator [

	^ self new
		  initializeWithPlayers: somePlayers
		  withGameboardLength: aLength
		  withDice: aDiceCollection
		  withLaps: anAmountOfLaps
		  withParsecs: aNumberOfParsecs
		  withSquareGenerator: sqaureGenerator
]

{ #category : #initialization }
SpaceshipGame >> initializeWithPlayers: aCollectionOfPlayers withGameboardLength: aLength withDice: aDiceCollection withLaps: anAmountOfLaps withParsecs: aNumberOfParsecs withSquareGenerator: squareGenerator [

	dice := Dice with: aDiceCollection .

	players := aCollectionOfPlayers collect: [ :playerName |
		           Spaceship
			           withName: playerName
			           withFuel: dice maxThrow * 2 ].

	gameboard := Gameboard
		             numberOfSquares: aLength
		             spaceships: players
		             withParsecs: aNumberOfParsecs
		             using: dice
		             generator: squareGenerator.
	numberOfLaps := anAmountOfLaps
]

{ #category : #'game logic' }
SpaceshipGame >> isOver [

	^ players anySatisfy: [ :aSpaceship |
		  (gameboard lapsCompletedOf: aSpaceship) >= numberOfLaps ]
]

{ #category : #accessing }
SpaceshipGame >> lapsCompletedOf: aSpaceshipName [

	| aSpaceship |
	aSpaceship := players detect: [ :player |
		              player name = aSpaceshipName ].


	^ gameboard lapsCompletedOf: aSpaceship
]

{ #category : #accessing }
SpaceshipGame >> lapsCompletedOf: aSpaceshipName [

	| aSpaceship |
	aSpaceship := players detect: [ :player |
		              player name = aSpaceshipName ].


	^ aSpaceship lapsCompleted
]

{ #category : #accessing }
SpaceshipGame >> lapsCompletedOf: aSpaceshipName [

	| aSpaceship |
	aSpaceship := players detect: [ :player |
		              player name = aSpaceshipName ].


	^ aSpaceship lapsCompleted
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
	spaceshipToPlay playWith: aNumber in: gameboard.
	gameboard implementEffectOn: spaceshipToPlay.
]

{ #category : #'game logic' }
SpaceshipGame >> positionOf: aSpaceshipName [

	| aSpaceship |
	aSpaceship := players detect: [ :player |
		              player name = aSpaceshipName ].
	^ gameboard find: aSpaceship
]

{ #category : #'game logic' }
SpaceshipGame >> rankings [

	| comparisonBlock sortedCollection playerPosition playerLap playerPositionArray |
	self isOver ifFalse: [ Error signal: 'Game is not over' ].

	comparisonBlock := [ :a :b | a second >= b second ].

	sortedCollection := SortedCollection sortBlock: comparisonBlock.

	players do: [ :player |
		playerPosition := gameboard find: player.
		playerLap := gameboard lapsCompletedOf: player.
		playerPositionArray := OrderedCollection
			                       with: player
			                       with: playerLap @ playerPosition.
		sortedCollection add: playerPositionArray ].


	^ sortedCollection collect: [ :position | position first name ]
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

	| raceWinner |
	raceWinner := players
		              detect: [ :player |
		              (gameboard lapsCompletedOf: player) >= numberOfLaps ]
		              ifNone: [ Error signal: 'There is no winner yet' ].
	^ raceWinner name
]
