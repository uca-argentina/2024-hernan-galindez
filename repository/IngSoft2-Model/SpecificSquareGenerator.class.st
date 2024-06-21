Class {
	#name : #SpecificSquareGenerator,
	#superclass : #SquareGenereator,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpecificSquareGenerator class >> with: squareClassAndPosition [

	^ self new initializeWith: squareClassAndPosition
]

{ #category : #initialization }
SpecificSquareGenerator >> generateSquares: anAmountOfSquares [

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
SpecificSquareGenerator >> initializeWith: squareClassAndPosition [

	distribution := squareClassAndPosition
]
