Class {
	#name : #ProbabilityGenerator,
	#superclass : #EffectsGenereator,
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
ProbabilityGenerator class >> distributions: effectDistributions [

	^ self new initilizeWithDistributions: effectDistributions 
]

{ #category : #initialization }
ProbabilityGenerator >> generateSquares: anAmountOfSquares [

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
ProbabilityGenerator >> initilizeWithDistributions: effectDistributions [

	distribution := effectDistributions
]

{ #category : #initialization }
ProbabilityGenerator >> squareCollection: anAmountOfSquares with: aBlockOfCode [

	| collection |
	collection := OrderedCollection new.
	anAmountOfSquares timesRepeat: [ collection add: aBlockOfCode value ].

	^ collection
]
