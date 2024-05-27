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
MoonWalk >> initializeWithSquaresToMove: anAmountOfSquares in: aBoard [

	squaresToMove := anAmountOfSquares.
	board:= aBoard. 
]

{ #category : #'add/remove' }
MoonWalk >> land: aSpaceschip [

	occupiedBy add: aSpaceschip.
	board moveAllBack: squaresToMove except: aSpaceschip.
	
]
