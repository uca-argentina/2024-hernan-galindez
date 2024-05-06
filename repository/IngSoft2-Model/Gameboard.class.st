Class {
	#name : #Gameboard,
	#superclass : #Array,
	#type : #variable,
	#category : 'IngSoft2-Model'
}

{ #category : #accessing }
Gameboard class >> numberOfSquares: aNumberOfSquares [
	|anArray|
	
	self verifyGreaterThanZero: aNumberOfSquares.
	anArray := self new: aNumberOfSquares.
	
	1 to: aNumberOfSquares do: [ :index | anArray at: index put: Square newSquare ].
	^anArray.
]

{ #category : #accessing }
Gameboard class >> verifyGreaterThanZero: aLength [
	aLength > 0 ifFalse: [ Error signal: 'Length must be greater than zero' ]
]

{ #category : #accessing }
Gameboard >> find: aTarget [

self withIndexDo: [ :aSquare :index | 
	(aSquare includes: aTarget) ifTrue: [ ^ index ] 
	 ]


]

{ #category : #accessing }
Gameboard >> move: aSpaceship with: aNumberOfSquares [ 
	|currentPosition targetSquare sum |
	currentPosition := self find: aSpaceship.
	sum := currentPosition + aNumberOfSquares.
	targetSquare := self verifySumNotOutOfBounds: sum.

	
	(self at: currentPosition) remove: aSpaceship.
	(self at: targetSquare) land: aSpaceship. 


]

{ #category : #initialization }
Gameboard >> setPlayers: players [

| firstSquare |
firstSquare := self at: 1.

players do: [ :eachPlayer | firstSquare land: eachPlayer ]


]

{ #category : #accessing }
Gameboard >> verifySumNotOutOfBounds: sum [

 ^ (sum < self size) ifFalse:[self size] ifTrue:[sum]
]
