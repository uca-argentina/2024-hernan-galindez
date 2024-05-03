Class {
	#name : #Gameboard,
	#superclass : #OrderedCollection,
	#type : #variable,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Gameboard class >> verifyGreaterThanZero: aLength [
	aLength > 0 ifFalse: [ Error signal: 'Length must be greater than zero' ]
]

{ #category : #accessing }
Gameboard class >> withLength: aNumberOfSquares [
	self verifyGreaterThanZero: aNumberOfSquares.
	
	^self new: aNumberOfSquares
]

{ #category : #initialization }
Gameboard >> initializeWithLength: aLength [

grid:= OrderedCollection new: aLength withAll: '-'
]
