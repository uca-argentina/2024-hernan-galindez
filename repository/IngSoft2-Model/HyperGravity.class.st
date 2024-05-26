Class {
	#name : #HyperGravity,
	#superclass : #Square,
	#instVars : [
		'dice',
		'expectedNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'add/remove' }
HyperGravity >> initializeWithExpectedNumber: aNumber [

	expectedNumber := aNumber
]

{ #category : #'add/remove' }
HyperGravity >> land: aSpaceship [

	aSpaceship needsToThrow: expectedNumber.
	occupiedBy add: aSpaceship
]
