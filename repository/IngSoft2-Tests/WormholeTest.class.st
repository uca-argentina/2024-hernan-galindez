Class {
	#name : #WormholeTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
WormholeTest >> testWormholeCreation [

	| wormholePair aWormhole anotherWormhole |
	wormholePair := Wormhole newPair.
	aWormhole := wormholePair at: 1.
	anotherWormhole := wormholePair at: 2.

	self assert: aWormhole connection equals: anotherWormhole.
	self assert: anotherWormhole connection equals: aWormhole.
]
