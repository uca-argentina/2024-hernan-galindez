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

{ #category : #initialization }
Acceleration >> initializeWith: aNumber [

	accelerate := aNumber.
	name := 'Overload'
]
