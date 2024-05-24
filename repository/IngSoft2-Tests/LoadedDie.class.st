Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'sequence',
		'faces'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
LoadedDie class >> sequence: anArrayOfValues [
	self verifyGreaterThanTwo: anArrayOfValues .
	^ self new initializeSequence: anArrayOfValues.
]

{ #category : #'instance creation' }
LoadedDie class >> verifyGreaterThanTwo: anArrayOfValues [

	anArrayOfValues min > 2 ifFalse: [
		Error signal: 'Faces should be more than 2' ]
]

{ #category : #accessing }
LoadedDie >> throw [

	| currentThrow |
	currentThrow := sequence removeFirst.
	sequence addLast: currentThrow.
	^ currentThrow
]
