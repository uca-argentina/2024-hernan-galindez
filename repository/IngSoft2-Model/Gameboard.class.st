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

	| normalCount blackHoleCount hyperGravityCount moonWalkCount hyperJumpCount atomicBombCount squaresList wormholePair wormhole anotherWormhole firstWormholePosition secondWormholePositions |
	spaceships := spaceshipsCollection.
	parsecsPerSquare := aNumberOfParsecs // aNumberOfSquares.

	normalCount := (aNumberOfSquares * 0.40) rounded.
	blackHoleCount := (aNumberOfSquares * 0.20) rounded.
	hyperGravityCount := (aNumberOfSquares * 0.20) rounded.
	moonWalkCount := (aNumberOfSquares * 0.10) rounded.
	hyperJumpCount := (aNumberOfSquares * 0.08) rounded.
	atomicBombCount := (aNumberOfSquares * 0.02) rounded.


	squaresList := OrderedCollection new.
	normalCount timesRepeat: [ squaresList add: NormalSquare create ].
	blackHoleCount timesRepeat: [ squaresList add: (BlackHole in: self) ].
	hyperGravityCount timesRepeat: [
		squaresList add: (HyperGravity withExpectedNumber: 4) ].
	moonWalkCount timesRepeat: [
		squaresList add: (MoonWalk withSquaresToMove: 3 in: self) ].
	hyperJumpCount timesRepeat: [
		squaresList add: (HyperJump in: self withParsecs: parsecsPerSquare) ].
	atomicBombCount timesRepeat: [
		squaresList add: (AtomicBomb in: self) ].

	squaresList := squaresList asSortedCollection: [ :a :b |
		               Random new next < 0.5 ].


	wormholePair := Wormhole newPair.
	wormhole := wormholePair first.
	anotherWormhole := wormholePair second.
	firstWormholePosition := aNumberOfSquares atRandom.
	secondWormholePositions := firstWormholePosition
	                           + aNumberOfSquares atRandom
	                           % aNumberOfSquares.



	board := squaresList asArray.

	board
		at: firstWormholePosition put: wormhole;
		at: secondWormholePositions put: anotherWormhole.

	self setPlayersAtFirstPosition: spaceships
]

{ #category : #accessing }
Gameboard >> move: aSpaceship with: aNumberOfSquares withEffects: aBoolean [

	| currentPosition nextPosition aNumberOfLaps |
	currentPosition := self find: aSpaceship.

	nextPosition := currentPosition - 1 + aNumberOfSquares \\ board size
	                + 1.

	aNumberOfLaps := currentPosition - 1 + aNumberOfSquares // board size.
	aSpaceship changeLapsBy: aNumberOfLaps.

	(board at: currentPosition) leaves: aSpaceship.
	aBoolean
		ifTrue: [ (board at: nextPosition) land: aSpaceship ]
		ifFalse: [ (board at: nextPosition) keep: aSpaceship ]
]

{ #category : #setting }
Gameboard >> moveAllBack: anAmountOfSquares except: aSpaceship [

	| playersToMove |
	playersToMove := spaceships select: [ :spaceship |
		                 spaceship ~= aSpaceship ].

	playersToMove do: [ :player |
		player move: anAmountOfSquares negated in: self withEffects: false ]
]

{ #category : #setting }
Gameboard >> moveAllToStart [

	spaceships do: [ :spaceship | self moveToStart: spaceship ]
]

{ #category : #setting }
Gameboard >> moveToStart: aSpaceship [

	| currentPosition |
	currentPosition := self find: aSpaceship.
	(board at: 1) keep: aSpaceship.
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
