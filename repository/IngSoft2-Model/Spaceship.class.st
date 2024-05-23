Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'name',
		'laps'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Spaceship class >> withName: aName [

	^ self new initializeWithName: aName
]

{ #category : 'initialization' }
Spaceship >> addLaps: aNumberOfLaps [

	laps := laps + aNumberOfLaps 
]

{ #category : 'initialization' }
Spaceship >> initializeWithName: aName [

	name := aName.
	laps := 0
]

{ #category : 'as yet unclassified' }
Spaceship >> lapsCompleted [
	^laps.
]

{ #category : 'accessing' }
Spaceship >> name [ 
	^name
]
