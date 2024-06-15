Class {
	#name : #Wormhole,
	#superclass : #Square,
	#instVars : [
		'connection'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Wormhole class >> newPair [

	| aWormhole anotherWormhole wormholePair |
	aWormhole := self new.
	anotherWormhole := self new.
	aWormhole connectTo: anotherWormhole.
	anotherWormhole connectTo: aWormhole.

	wormholePair := OrderedCollection
		                with: aWormhole
		                with: anotherWormhole.
	^ wormholePair
]

{ #category : #'instance creation' }
Wormhole class >> newPairIn: aBoard at: firstPosition and: secondPosition [

	| aWormhole anotherWormhole wormholePair |
	aWormhole := self new.
	anotherWormhole := self new.
	aWormhole connectTo: anotherWormhole.
	anotherWormhole connectTo: aWormhole.

	wormholePair := OrderedCollection
		                with: aWormhole
		                with: anotherWormhole.
	aBoard at: firstPosition put: aWormhole.
	aBoard at: secondPosition put: anotherWormhole
]

{ #category : #'add/remove' }
Wormhole >> applyEffectTo: aSpaceship in: aGameboard [

	occupiedBy remove: aSpaceship.
	connection keep: aSpaceship
]

{ #category : #'public - line' }
Wormhole >> connectTo: anotherWormhole [

	connection := anotherWormhole
]
