Class {
	#name : #Gameboard,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'board',
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Gameboard class >> numberOfSquares: aNumberOfSquares usingDice: aDiceCollection [

	self verifyGreaterThanZero: aNumberOfSquares.


	^ self new
		  initializeWithNumberOfSquares: aNumberOfSquares
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

{ #category : #'instance creation' }
Gameboard >> initializeWithNumberOfSquares: aNumberOfSquares withDice: aDiceCollection [

	| wormholePair aWormhole anotherWormhole hyperGravity |
	board := (Array new: aNumberOfSquares) collect: [ :square |
		         NormalSquare create ].
	dice := aDiceCollection.
	wormholePair := Wormhole newPair.
	hyperGravity := HyperGravity withDice: aDiceCollection withExpectedNumber: 4.
	aWormhole := wormholePair at: 1.
	anotherWormhole := wormholePair at: 2.

	board
		at: 4 put: aWormhole;
		at: 5 put: anotherWormhole;
		at: 6 put: hyperGravity
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
