Class {
	#name : #CardSquare,
	#superclass : #Square,
	#instVars : [
		'expectedNumber',
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardSquare class >> with: aCardCollection [

	^ self new initializeWith: aCardCollection
]

{ #category : #'add/remove' }
CardSquare >> applyEffectTo: aSpaceship in: aGameboard [

	aSpaceship giveCard: cards atRandom .
]

{ #category : #'add/remove' }
CardSquare >> initializeWith: aCardClassCollection [

	cards := aCardClassCollection collect: [ :cardClass | cardClass new ]
]
