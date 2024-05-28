Class {
	#name : #BlackHole,
	#superclass : #Square,
	#instVars : [
		'gameboard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #evaluating }
BlackHole class >> in: board [

	^ self new initializeWithBoard: board
]

{ #category : #'add/remove' }
BlackHole >> initializeWithBoard: board [

	gameboard := board
]

{ #category : #'add/remove' }
BlackHole >> land: aSpaceship [


	aSpaceship move: -4 in: gameboard.
	gameboard implementEffectOn: aSpaceship
]
