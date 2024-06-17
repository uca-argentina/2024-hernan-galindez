Class {
	#name : #Acceleration,
	#superclass : #Card,
	#instVars : [
		'accelerate'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Acceleration class >> with: aNumber [

	^ self new initializeWith: aNumber
]

{ #category : #operations }
Acceleration >> applyFrom: aSpaceship to: otherSpaceships [

	otherSpaceships do: [ :spaceship |
		spaceship changeTotalThrowBy: accelerate ]
]

{ #category : #initialization }
Acceleration >> initializeWith: aNumber [

	accelerate := aNumber.
	name := 'Overload'
]
