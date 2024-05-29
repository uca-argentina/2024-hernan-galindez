Class {
	#name : #AtomicBomb,
	#superclass : #Square,
	#instVars : [
		'gameboard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #evaluating }
AtomicBomb class >> in: board [

	^ self new initializeWithBoard: board
]

{ #category : #initialization }
AtomicBomb >> initializeWithBoard: board [

	gameboard := board
]

{ #category : #'add/remove' }
AtomicBomb >> land: aSpaceship [

	gameboard moveAllToStart 
]
