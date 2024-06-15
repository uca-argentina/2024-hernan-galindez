Class {
	#name : #HyperJump,
	#superclass : #Square,
	#instVars : [
		'parsecs',
		'listOfValues'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #evaluating }
HyperJump class >> in: board withParsecs: aNumberOfParsecs [

	^self new initializeWithBoard: board withParsecs: aNumberOfParsecs
]

{ #category : #'add/remove' }
HyperJump >> applyEffectTo: aSpaceship in: aGameboard [

	| numberOfParsecsToMove squaresToMove |
	parsecs := aGameboard parsecsPerSquare.
	numberOfParsecsToMove := listOfValues removeFirst.
	listOfValues addLast: numberOfParsecsToMove.
	squaresToMove := numberOfParsecsToMove // parsecs.

	squaresToMove = 0 ifTrue: [ ^ self ].
	aSpaceship move: squaresToMove in: aGameboard
]

{ #category : #'add/remove' }
HyperJump >> initialize [

	occupiedBy := OrderedCollection new.
	listOfValues := #( 4 11 10 ) asOrderedCollection
]

{ #category : #'add/remove' }
HyperJump >> initializeWithBoard: board withParsecs: aNumberOfParsecs [

	gameboard := board.
	parsecs := aNumberOfParsecs.
	listOfValues := #(4 11 10) asOrderedCollection 
]
