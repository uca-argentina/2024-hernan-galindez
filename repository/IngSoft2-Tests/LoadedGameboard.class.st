Class {
	#name : #LoadedGameboard,
	#superclass : #Gameboard,
	#type : #variable,
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
LoadedGameboard >> initializeWithNumberOfSquares: aNumberOfSquares withSpaceships: spaceshipsCollection withParsecs: aNumberOfParsecs withDice: aDiceCollection [

	| wormholePair aWormhole anotherWormhole hyperGravity moonWalk blackHole anotherBlackHole atomicBomb hyperJump |
	spaceships := spaceshipsCollection.
	lapCounter := Dictionary newFromKeys: spaceships  andValues:  (OrderedCollection new: spaceships size withAll: 0).

	board := (Array new: aNumberOfSquares) collect: [ :square |
		         NormalSquare create ].

	parsecsPerSquare := aNumberOfParsecs // board size.

	wormholePair := Wormhole newPair.
	aWormhole := wormholePair at: 1.
	anotherWormhole := wormholePair at: 2.
	hyperGravity := HyperGravity withExpectedNumber: 4.
	moonWalk := MoonWalk withSquaresToMove: 3 in: self.
	blackHole := BlackHole in: self.
	anotherBlackHole := BlackHole in: self.
	atomicBomb := AtomicBomb in: self.
	hyperJump := HyperJump in: self withParsecs: parsecsPerSquare.


	board
		at: 3 put: anotherBlackHole;
		at: 4 put: aWormhole;
		at: 5 put: anotherWormhole;
		at: 6 put: hyperGravity;
		at: 7 put: moonWalk;
		at: 8 put: blackHole;
		at: 9 put: atomicBomb;
		at: 10 put: hyperJump.


	self setPlayersAtFirstPosition: spaceships
]
