Class {
	#name : #Gameboard,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Gameboard class >> numberOfSquares: aNumberOfSquares withWormholeAt: firstWormholePosition and: secondWormholePosition [

	self verifyGreaterThanZero: aNumberOfSquares.
	self
		verifyThereAreNoWormholesOutOfBounds: aNumberOfSquares
		withPositions: firstWormholePosition
		and: secondWormholePosition.


	^ self new
		  initializeWithNumberOfSquares: aNumberOfSquares
		  withWormholeAt: firstWormholePosition
		  and: secondWormholePosition
]

{ #category : #accessing }
Gameboard class >> verifyGreaterThanZero: aLength [

	aLength > 0 ifFalse: [
		Error signal: 'Length must be greater than zero' ]
]

{ #category : #accessing }
Gameboard class >> verifyThereAreNoWormholesOutOfBounds: numberOfSquares withPositions: firstPosition and: secondPosition [

	(firstPosition >= numberOfSquares or:
		 secondPosition >= numberOfSquares) ifTrue: [
		Error signal:
			'Wormholes must be between the first and the second to last square' ]
]

{ #category : #accessing }
Gameboard >> find: aTarget [

	^ board
		  detectIndex: [ :square | square includes: aTarget ]
		  ifNone: [ Error signal: 'spaceship not found' ]
]

{ #category : #'instance creation' }
Gameboard >> initializeWithNumberOfSquares: aNumberOfSquares withWormholeAt: firstWormholePosition and: secondWormholePosition [

	| wormholePair aWormhole anotherWormhole |
	board := (Array new: aNumberOfSquares) collect: [ :square |
		         NormalSquare create ].
	wormholePair := Wormhole newPair.
	aWormhole := wormholePair at: 1.
	anotherWormhole := wormholePair at: 2.

	board
		at: firstWormholePosition put: aWormhole;
		at: secondWormholePosition put: anotherWormhole
]

{ #category : #accessing }
Gameboard >> move: aSpaceship with: aNumberOfSquares [

	| currentPosition nextPosition aNumberOfLaps |
	currentPosition := self find: aSpaceship.

	nextPosition := currentPosition + aNumberOfSquares % board size.
	nextPosition := nextPosition = 0
		                ifTrue: [ board size ]
		                ifFalse: [ nextPosition ].

	aNumberOfLaps := currentPosition + aNumberOfSquares // board size.
	aSpaceship addLaps: aNumberOfLaps.

	(board at: currentPosition) leaves: aSpaceship.
	(board at: nextPosition) land: aSpaceship
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
