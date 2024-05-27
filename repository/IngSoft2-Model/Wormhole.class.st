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

{ #category : #'public - line' }
Wormhole >> connectTo: anotherWormhole [

	connection := anotherWormhole
]

{ #category : #'add/remove' }
Wormhole >> land: aSpaceship [

	connection keep: aSpaceship
]
