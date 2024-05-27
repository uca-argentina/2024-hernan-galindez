Class {
	#name : #Gameboard,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'board',
		'spaceships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Gameboard class >> numberOfSquares: aNumberOfSquares spaceships: aSpaceshipCollection [

	self verifyGreaterThanZero: aNumberOfSquares.


	^ self new initializeWithNumberOfSquares: aNumberOfSquares withSpaceships: aSpaceshipCollection
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
Gameboard >> initializeWithNumberOfSquares: aNumberOfSquares withSpaceships: spaceshipsCollection [

	| wormholePair aWormhole anotherWormhole hyperGravity moonWalk blackHole anotherBlackHole atomicBomb |
	spaceships := spaceshipsCollection.

	board := (Array new: aNumberOfSquares) collect: [ :square |
		         NormalSquare create ].
	wormholePair := Wormhole newPair.
	aWormhole := wormholePair at: 1.
	anotherWormhole := wormholePair at: 2.
	hyperGravity := HyperGravity withExpectedNumber: 4.
	moonWalk := MoonWalk withSquaresToMove: 3 in: self.
	blackHole := BlackHole in: self.
	anotherBlackHole := BlackHole in: self.
	atomicBomb := AtomicBomb in: self.


	board
		at: 3 put: anotherBlackHole;
		at: 4 put: aWormhole;
		at: 5 put: anotherWormhole;
		at: 6 put: hyperGravity;
		at: 7 put: moonWalk;
		at: 8 put: blackHole;
		at: 9 put: atomicBomb.


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

	players do: [ :player | firstSquare land: player ]
]

{ #category : #accessing }
Gameboard >> size [

	^ board size
]
