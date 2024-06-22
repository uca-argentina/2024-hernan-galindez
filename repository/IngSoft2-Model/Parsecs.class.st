Class {
	#name : #Parsecs,
	#superclass : #Unit,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Parsecs class >> of: aNumber [

	^ self new initializeWith: aNumber.
]

{ #category : #initialization }
Parsecs >> initializeWith: aNumber [

	value := aNumber
]
