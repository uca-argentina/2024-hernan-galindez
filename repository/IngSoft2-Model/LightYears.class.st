Class {
	#name : #LightYears,
	#superclass : #Unit,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LightYears class >> of: aNumber [

	^ self new initializeWith: aNumber
]

{ #category : #initialization }
LightYears >> initializeWith: aNumber [

	value := aNumber
]
