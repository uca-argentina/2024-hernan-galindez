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
Gameboard class >> numberOfSquares: aNumberOfSquares spaceships: aSpaceshipCollection withParsecs: aNumberOfParsecs [

	self verifyGreaterThanZero: aNumberOfSquares.


	^ self new
		  initializeWithNumberOfSquares: aNumberOfSquares
		  withSpaceships: aSpaceshipCollection
		  withParsecs: aNumberOfParsecs
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

{ #category : #'instance creation' }
Gameboard >> initializeWithNumberOfSquares: aNumberOfSquares withSpaceships: spaceshipsCollection withParsecs: aNumberOfParsecs [

	| wormholePair aWormhole anotherWormhole hyperGravity moonWalk blackHole anotherBlackHole atomicBomb hyperJump |
	spaceships := spaceshipsCollection.

	board := (Array new: aNumberOfSquares) collect: [ :square |
		         NormalSquare create ].

	parsecsPerSquare := aNumberOfParsecs // board size.

	wormholePair := Wormhole newPair.
	aWormhole := wormholePair at: 1.
	anotherWormhole := wormholePair at: 2.
	hyperGravity := HyperGravity withExpectedNumber: 4.
	moonWalk := MoonWalk withSquaresToMove: 3 in: self.
	blackHole := BlackHole in: self.
	anotherBlackHole := BlackHole in: self.
	atomicBomb := AtomicBomb in: self.
	hyperJump := HyperJump in: self withParsecs: parsecsPerSquare.


	board
		at: 3 put: anotherBlackHole;
		at: 4 put: aWormhole;
		at: 5 put: anotherWormhole;
		at: 6 put: hyperGravity;
		at: 7 put: moonWalk;
		at: 8 put: blackHole;
		at: 9 put: atomicBomb;
		at: 10 put: hyperJump.


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

	players do: [ :player | firstSquare land: player ]
]

{ #category : #accessing }
Gameboard >> size [

	^ board size
]
