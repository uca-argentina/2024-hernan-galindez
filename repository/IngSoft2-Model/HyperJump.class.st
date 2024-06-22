Class {
	#name : #HyperJump,
	#superclass : #Square,
	#instVars : [
		'listOfValues'
	],
	#category : #'IngSoft2-Model'
}
{ #category : #'instance creation' }
HyperJump class >> with: aUnitsArray [

	^ self new initializeWith: aUnitsArray
]

{ #category : #'add/remove' }
HyperJump >> applyEffectTo: aSpaceship in: aGameboard [

	| amountToMove squaresToMove gameboardMeasurment |
	gameboardMeasurment := aGameboard measurementPerSquare.
	amountToMove := listOfValues removeFirst.
	listOfValues addLast: amountToMove.
	squaresToMove := amountToMove // gameboardMeasurment.
	squaresToMove = 0 ifTrue: [ ^ self ].
	aSpaceship move: squaresToMove in: aGameboard
]

{ #category : #'add/remove' }
HyperJump >> initialize [

	occupiedBy := OrderedCollection new.
	listOfValues := #( 4 11 10 ) asOrderedCollection
]

{ #category : #'add/remove' }
HyperJump >> initializeWith: aNumberArray [

	occupiedBy := OrderedCollection new.
	listOfValues := aNumberArray asOrderedCollection
]
