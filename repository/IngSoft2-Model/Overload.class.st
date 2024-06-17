Class {
	#name : #Overload,
	#superclass : #Card,
	#instVars : [
		'penalty'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Overload class >> with: aNumber [

	^ self new initializeWith: aNumber
]

{ #category : #operations }
Overload >> applyTo: otherSpaceships [

	otherSpaceships size = 1 ifFalse: [
		Error signal: 'This card can only be applied to one spaceship' ].

	otherSpaceships do: [ :spaceship |
		spaceship changeTotalThrowBy: penalty negated ]
]

{ #category : #operations }
Overload >> initializeWith: aNumber [

	penalty := aNumber.
	name := 'Overload'
]
