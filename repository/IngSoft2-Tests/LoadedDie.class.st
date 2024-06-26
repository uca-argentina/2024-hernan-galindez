Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'sequence'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
LoadedDie class >> sequence: anArrayOfValues [
	^ self new initializeSequence: anArrayOfValues.
]

{ #category : #initialization }
LoadedDie >> initializeSequence: anArrayOfValues [

	sequence := anArrayOfValues asOrderedCollection
]

{ #category : #accessing }
LoadedDie >> maxThrow [

	^ sequence max
]

{ #category : #accessing }
LoadedDie >> throw [

	| currentThrow |
	currentThrow := sequence removeFirst.
	sequence addLast: currentThrow.
	^ currentThrow
]
