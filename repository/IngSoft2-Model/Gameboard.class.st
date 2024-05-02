Class {
	#name : #Gameboard,
	#superclass : #Object,
	#instVars : [
		'grid'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Gameboard class >> length: aLength [
	self verifyGreaterThanZero: aLength.
	
	^(self new) initializeWithLength: 10.
]

{ #category : #accessing }
Gameboard class >> verifyGreaterThanZero: aLength [
	aLength > 0 ifFalse: [ Error signal: 'Length must be greater than zero' ]
]

{ #category : #accessing }
Gameboard >> board [
	^ grid.
]

{ #category : #initialization }
Gameboard >> initializeWithLength: aLength [

grid:= OrderedCollection new: aLength withAll: '-'
]
