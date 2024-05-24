Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Die class >> of: anAmountOfFaces [

	self verifyGreaterThanTwo: anAmountOfFaces.
	^ self new initializeOf: anAmountOfFaces
]

{ #category : #'instance creation' }
Die class >> verifyGreaterThanTwo: anAmountOfFaces [

	anAmountOfFaces > 2 ifFalse: [
		Error signal: 'Faces should be more than 2' ]
]

{ #category : #initialization }
Die >> initializeOf: anAmountOfFaces [

	faces := anAmountOfFaces
]

{ #category : #accessing }
Die >> maxThrow [

^ faces
]

{ #category : #initialization }
Die >> throw [

	^ faces atRandom
]
