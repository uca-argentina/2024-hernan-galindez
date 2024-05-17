Class {
	#name : #Gameboard,
	#superclass : #Array,
	#type : #variable,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Gameboard class >> numberOfSquares: aNumberOfSquares withWormholeAt: firstWormholePosition and: secondWormholePosition [

	| anArray wormholePair aWormhole anotherWormhole |
	self verifyGreaterThanZero: aNumberOfSquares.
	self
		verifyThereAreNoWormholesOutOfBounds: aNumberOfSquares
		withPositions: firstWormholePosition
		and: secondWormholePosition.
	anArray := self new: aNumberOfSquares.
	wormholePair := Wormhole newPair.
	aWormhole := wormholePair at: 1.
	anotherWormhole := wormholePair at: 2.

	1 to: aNumberOfSquares do: [ :index |
	anArray at: index put: Square create ].

	anArray
		at: firstWormholePosition put: aWormhole;
		at: secondWormholePosition put: anotherWormhole.

	^ anArray
]

{ #category : #accessing }
Gameboard class >> verifyGreaterThanZero: aLength [
	aLength > 0 ifFalse: [ Error signal: 'Length must be greater than zero' ]
]

{ #category : #accessing }
Gameboard class >> verifyThereAreNoWormholesOutOfBounds: numberOfSquares withPositions: firstPosition and: secondPosition [

	(firstPosition >= numberOfSquares or: secondPosition >= numberOfSquares)
		ifTrue: [ Error signal: 'Wormholes must be between the first and the second to last square' ]
]

{ #category : #accessing }
Gameboard >> find: aTarget [

	^ self detectIndex: [ :square | square includes: aTarget ]
]

{ #category : #accessing }
Gameboard >> move: aSpaceship with: aNumberOfSquares [

	| currentPosition targetSquare sum |
	currentPosition := self find: aSpaceship.
	sum := currentPosition + aNumberOfSquares.
	targetSquare := self validMoveOf: sum.

	(self at: currentPosition) remove: aSpaceship.
	(self at: targetSquare) land: aSpaceship
]

{ #category : #initialization }
Gameboard >> setPlayers: players [

	| firstSquare |
	firstSquare := self at: 1.

	players do: [ :player | firstSquare land: player ]
]

{ #category : #accessing }
Gameboard >> validMoveOf: anAmountOfSquaresToMove [

	^ anAmountOfSquaresToMove < self size
		  ifFalse: [ self size ]
		  ifTrue: [ anAmountOfSquaresToMove ]
]
