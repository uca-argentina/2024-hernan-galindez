Class {
	#name : #Gameboard,
	#superclass : #Array,
	#type : #variable,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Gameboard class >> numberOfSquares: aNumberOfSquares [
	self verifyGreaterThanZero: aNumberOfSquares.
	
	^(self new: aNumberOfSquares)
]

{ #category : #accessing }
Gameboard class >> verifyGreaterThanZero: aLength [
	aLength > 0 ifFalse: [ Error signal: 'Length must be greater than zero' ]
]

{ #category : #accessing }
Gameboard >> move: aSpaceship with: aNumberOfSquares [ 
	|currentPosition target|
	currentPosition := self indexOf: aSpaceship.
	target := currentPosition + aNumberOfSquares.
	
	self at: currentPosition put: nil.
	self at: target put: aSpaceship 

]

{ #category : #initialization }
Gameboard >> setPlayers: players [

self at: 1 put: players


]
