Class {
	#name : #Overload,
	#superclass : #Card,
	#instVars : [
		'penalty',
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Overload class >> with: aNumber [

	^ self new initializeWith: aNumber
]

{ #category : #operations }
Overload >> applyTo: otherSpaceships [

	otherSpaceships changeTotalThrowBy: penalty negated
]

{ #category : #operations }
Overload >> initializeWith: aNumber [

	penalty := aNumber.
	name := 'Overload'
]

{ #category : #operations }
Overload >> name [

	^ name.
]
