Class {
	#name : #HyperGravity,
	#superclass : #Square,
	#instVars : [
		'dice',
		'expectedNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
HyperGravity class >> withDice: aDiceCollection withExpectedNumber: aNumber [

	^ self new
		  initializeWithDice: aDiceCollection
		  withExpectedNumber: aNumber
]

{ #category : #'add/remove' }
HyperGravity >> initializeWithDice: aDiceCollection withExpectedNumber: aNumber [

	dice := aDiceCollection.
	expectedNumber := aNumber
]

{ #category : #'add/remove' }
HyperGravity >> land: aSpaceship [

	| numberThrown |
	numberThrown := dice throw.
	occupiedBy add: aSpaceship.
	numberThrown >= expectedNumber ifFalse: [ ^ self ].
	aSpaceship move: numberThrown
]
