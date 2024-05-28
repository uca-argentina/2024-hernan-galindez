Class {
	#name : #Gameboard,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'board',
		'spaceships',
		'parsecsPerSquare'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Gameboard class >> numberOfSquares: aNumberOfSquares spaceships: aSpaceshipCollection withParsecs: aNumberOfParsecs using: aDiceCollection [

	self verifyGreaterThanZero: aNumberOfSquares.


	^ self new
		  initializeWithNumberOfSquares: aNumberOfSquares
		  withSpaceships: aSpaceshipCollection
		  withParsecs: aNumberOfParsecs
		  withDice: aDiceCollection
]

{ #category : #accessing }
Gameboard class >> verifyGreaterThanZero: aLength [

	aLength > 0 ifFalse: [
		Error signal: 'Length must be greater than zero' ]
]

{ #category : #accessing }
Gameboard >> find: aTarget [

	^ board
		  detectIndex: [ :square | square includes: aTarget ]
		  ifNone: [ Error signal: 'spaceship not found' ]
]

{ #category : #initialization }
Gameboard >> initializeWithNumberOfSquares: aNumberOfSquares withSpaceships: spaceshipsCollection withParsecs: aNumberOfParsecs withDice: aDiceCollection [

	| normalCount blackHoleCount hyperGravityCount moonWalkCount hyperJumpCount atomicBombCount squaresList remainingSquares wormholePair wormhole anotherWormhole |
	remainingSquares := aNumberOfSquares - 2.

	spaceships := spaceshipsCollection.
	parsecsPerSquare := aNumberOfParsecs // aNumberOfSquares.

	normalCount := (remainingSquares * 0.40) floor.
	blackHoleCount := (remainingSquares * 0.20) floor.
	hyperGravityCount := (remainingSquares * 0.20) floor.
	moonWalkCount := (remainingSquares * 0.10) floor.
	hyperJumpCount := (remainingSquares * 0.08) floor.
	atomicBombCount := (remainingSquares * 0.02) floor.


	squaresList := OrderedCollection new.
	wormholePair := Wormhole newPair.
	wormhole := wormholePair at: 1.
	anotherWormhole := wormholePair at: 2.
	squaresList add: wormhole.
	squaresList add: anotherWormhole.


	normalCount timesRepeat: [ squaresList add: NormalSquare create ].
	blackHoleCount timesRepeat: [ squaresList add: (BlackHole in: self) ].
	hyperGravityCount timesRepeat: [
		squaresList add:
			(HyperGravity withExpectedNumber: aDiceCollection maxThrow atRandom) ].
	moonWalkCount timesRepeat: [
		squaresList add: (MoonWalk withSquaresToMove: 3 in: self) ].
	hyperJumpCount timesRepeat: [
		squaresList add: (HyperJump in: self withParsecs: parsecsPerSquare) ].
	atomicBombCount timesRepeat: [
		squaresList add: (AtomicBomb in: self) ].

	[ squaresList size < aNumberOfSquares ] whileTrue: [
		squaresList add: NormalSquare create ].

	squaresList := squaresList asSortedCollection: [ :a :b |
		               Random new next < 0.5 ].

	board := squaresList asOrderedCollection.

	self setPlayersAtFirstPosition: spaceships
]

{ #category : #accessing }
Gameboard >> move: aSpaceship with: aNumberOfSquares [

	| currentPosition nextPosition aNumberOfLaps |
	currentPosition := self find: aSpaceship.

	nextPosition := currentPosition - 1 + aNumberOfSquares \\ board size
	                + 1.

	aNumberOfLaps := currentPosition - 1 + aNumberOfSquares // board size.
	aSpaceship changeLapsBy: aNumberOfLaps.

	(board at: currentPosition) leaves: aSpaceship.
	(board at: nextPosition) land: aSpaceship
]

{ #category : #setting }
Gameboard >> moveAllBack: anAmountOfSquares except: aSpaceship [

	| playersToMove |
	playersToMove := spaceships select: [ :spaceship |
		                 spaceship ~= aSpaceship ].

	playersToMove do: [ :player |
		player move: anAmountOfSquares negated in: self ]
]

{ #category : #setting }
Gameboard >> moveAllToStart [

	spaceships do: [ :spaceship | self moveToStart: spaceship ]
]

{ #category : #setting }
Gameboard >> moveToStart: aSpaceship [

	| currentPosition |
	currentPosition := self find: aSpaceship.
	(board at: 1) land: aSpaceship.
	(board at: currentPosition) leaves: aSpaceship
]

{ #category : #setting }
Gameboard >> setPlayersAtFirstPosition: players [

	| firstSquare |
	firstSquare := board at:1.

	players do: [ :player | firstSquare keep: player ]
]

{ #category : #accessing }
Gameboard >> size [

	^ board size
]
