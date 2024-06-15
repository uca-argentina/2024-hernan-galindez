Class {
	#name : #SpecificGenerator,
	#superclass : #EffectsGenereator,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpecificGenerator class >> with: squareClassAndPosition [

	^ self new initializeWith: squareClassAndPosition
]

{ #category : #initialization }
SpecificGenerator >> generateSquares: anAmountOfSquares [

	| board effect position |
	board := OrderedCollection new.
	anAmountOfSquares timesRepeat: [ board add: NormalSquare create ].
	distribution do: [ :each |
		effect := each key .
		position := each value.
		board at: position put: effect ].
	^ board
]

{ #category : #initialization }
SpecificGenerator >> initializeWith: squareClassAndPosition [

	distribution := squareClassAndPosition
]
