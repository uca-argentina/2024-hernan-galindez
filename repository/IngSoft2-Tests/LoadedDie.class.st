Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : 'IngSoft2-Tests'
}

{ #category : #'instance creation' }
LoadedDie class >> of: anArrayOfValues [
	self verifyGreaterThanTwo: anArrayOfValues .
	^ self new initializeOf: anArrayOfValues.
]

{ #category : #'instance creation' }
LoadedDie class >> verifyGreaterThanTwo: anArrayOfValues [

anArrayOfValues > 2 ifFalse: [ Error signal: 'Faces should be more than 2'].
]

{ #category : #initialization }
LoadedDie >> initializeOf: anAmountOfFaces [
	faces := anAmountOfFaces.
]

{ #category : #'as yet unclassified' }
LoadedDie >> throw [
	^faces.
]
