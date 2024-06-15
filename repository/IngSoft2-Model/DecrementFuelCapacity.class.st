Class {
	#name : #DecrementFuelCapacity,
	#superclass : #Rewards,
	#instVars : [
		'decrement'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DecrementFuelCapacity class >> by: anAmount [
	
	^ self new initializeWith: anAmount
	
]

{ #category : #operations }
DecrementFuelCapacity >> applyTo: aSpaceship [

	aSpaceship changeFuelCapacityBy: decrement negated. 	

]

{ #category : #operations }
DecrementFuelCapacity >> initializeWith: anAmount [

	decrement := anAmount.
]
