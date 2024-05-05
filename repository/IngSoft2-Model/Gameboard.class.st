Class {
	#name : 'Gameboard',
	#superclass : 'Array',
	#type : 'variable',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Gameboard class >> numberOfSquares: aNumberOfSquares [
	self verifyGreaterThanZero: aNumberOfSquares.
	
	^(self new: aNumberOfSquares)
]

{ #category : 'accessing' }
Gameboard class >> verifyGreaterThanZero: aLength [
	aLength > 0 ifFalse: [ Error signal: 'Length must be greater than zero' ]
]

{ #category : 'accessing' }
Gameboard >> move: aSpaceship with: aNumberOfSquares [ 
	|currentPosition targetSquare sum|
	currentPosition := self indexOf: aSpaceship.
	sum := currentPosition + aNumberOfSquares.
	targetSquare := self verifySumNotOutOfBounds: sum.
	
	self at: currentPosition put: nil.
	self at: targetSquare put: aSpaceship. 


]

{ #category : 'initialization' }
Gameboard >> setPlayers: players [

self at: 1 put: players


]

{ #category : 'accessing' }
Gameboard >> verifySumNotOutOfBounds: sum [

 ^ (sum < self size) ifFalse:[self size] ifTrue:[sum]
]
