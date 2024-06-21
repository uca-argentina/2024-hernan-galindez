Class {
	#name : #DefaultSquareGenerator,
	#superclass : #SquareGenereator,
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
DefaultSquareGenerator class >> distributions: effectDistributions [

	^ self new initilizeWithDistributions: effectDistributions 
]

{ #category : #initialization }
DefaultSquareGenerator >> generateSquares: anAmountOfSquares [

	| squareCollection board firstWormholePosition secondWormholePosition|
	
	squareCollection := distribution collect: [ :eachSquare |
		                    self
			                    squareCollection:
			                    (eachSquare value * 100) asInteger
			                    with: eachSquare key  ].
	squareCollection := squareCollection flattened.

	board := OrderedCollection new.
	anAmountOfSquares timesRepeat: [
		board add: squareCollection atRandom ].

	firstWormholePosition := anAmountOfSquares atRandom.
	secondWormholePosition := firstWormholePosition
	                          + anAmountOfSquares atRandom
	                          % anAmountOfSquares + 1.

	Wormhole
		newPairIn: board
		at: firstWormholePosition
		and: secondWormholePosition.



	^ board
]

{ #category : #initialization }
DefaultSquareGenerator >> initilizeWithDistributions: effectDistributions [

	distribution := effectDistributions
]

{ #category : #initialization }
DefaultSquareGenerator >> squareCollection: anAmountOfSquares with: aBlockOfCode [

	| collection |
	collection := OrderedCollection new.
	anAmountOfSquares timesRepeat: [ collection add: aBlockOfCode value ].

	^ collection
]
