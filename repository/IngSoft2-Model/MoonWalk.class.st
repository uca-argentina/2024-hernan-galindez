Class {
	#name : #MoonWalk,
	#superclass : #Square,
	#instVars : [
		'squaresToMove',
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
MoonWalk class >> withSquaresToMove: anAmountOfSquares [ 

	^ (self new) initializeWithSquaresToMove: anAmountOfSquares .
]

{ #category : #'add/remove' }
MoonWalk >> applyEffectTo: aSpaceship in: aGameboard [

	aGameboard moveAllBack: squaresToMove except: aSpaceship
]

{ #category : #initialization }
MoonWalk >> initializeWithSquaresToMove: anAmountOfSquares [

	squaresToMove := anAmountOfSquares.

]
