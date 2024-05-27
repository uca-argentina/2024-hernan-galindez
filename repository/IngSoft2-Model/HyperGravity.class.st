Class {
	#name : #HyperGravity,
	#superclass : #Square,
	#instVars : [
		'expectedNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
HyperGravity class >> withExpectedNumber: aNumber [

	^ self new initializeWithExpectedNumber: aNumber
]

{ #category : #'add/remove' }
HyperGravity >> initializeWithExpectedNumber: aNumber [

	expectedNumber := aNumber
]

{ #category : #'add/remove' }
HyperGravity >> land: aSpaceship [

	aSpaceship needsToThrow: expectedNumber.
	occupiedBy add: aSpaceship
]
