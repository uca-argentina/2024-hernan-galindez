Class {
	#name : #DecrementCurrentFuel,
	#superclass : #Rewards,
	#instVars : [
		'decrement'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DecrementCurrentFuel class >> by: anAmount [
	
	^ self new initializeWith: anAmount
	
]

{ #category : #operations }
DecrementCurrentFuel >> applyTo: aSpaceship [

	aSpaceship changeCurrentFuelBy: decrement . 	

]

{ #category : #operations }
DecrementCurrentFuel >> initializeWith: anAmount [

	decrement := anAmount.
]
