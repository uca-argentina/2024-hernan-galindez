Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'name',
		'laps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance initialization' }
Spaceship class >> withName: aName [

	^ self new initializeWithName: aName
]

{ #category : #accessing }
Spaceship >> addLaps: aNumberOfLaps [

	laps := laps + aNumberOfLaps 
]

{ #category : #initialization }
Spaceship >> initializeWithName: aName [

	name := aName.
	laps := 0
]

{ #category : #accessing }
Spaceship >> lapsCompleted [
	^laps.
]

{ #category : #accessing }
Spaceship >> name [ 
	^name
]
