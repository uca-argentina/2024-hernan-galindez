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
MoonWalk class >> withSquaresToMove: anAmountOfSquares in: aBoard [

	^ (self new) initializeWithSquaresToMove: anAmountOfSquares in: aBoard.
]

{ #category : #initialization }
MoonWalk >> initializeWithSquaresToMove: anAmountOfSquares in: aBoard [

	squaresToMove := anAmountOfSquares.
	board:= aBoard. 
]

{ #category : #'add/remove' }
MoonWalk >> land: aSpaceschip [

	board moveAllBack: squaresToMove except: aSpaceschip.
	
]
