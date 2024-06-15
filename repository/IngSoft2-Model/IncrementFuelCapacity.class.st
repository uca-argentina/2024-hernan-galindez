Class {
	#name : #IncrementFuelCapacity,
	#superclass : #Rewards,
	#instVars : [
		'increment'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
IncrementFuelCapacity class >> by: anAmount [

	^ self new initializeWith: anAmount
]

{ #category : #operations }
IncrementFuelCapacity >> applyTo: aSpaceship [
	aSpaceship changeFuelCapacityBy: increment

]

{ #category : #initialization }
IncrementFuelCapacity >> initializeWith: anAmount [

	increment := anAmount
]
