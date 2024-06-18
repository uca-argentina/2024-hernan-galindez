Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Card class >> create [

	^ self new initialize
]

{ #category : #comparing }
Card >> = anotherCard [

	^(anotherCard isKindOf: self class)
]

{ #category : #operations }
Card >> applyFrom: aSpaceship to: otherSpaceships [

	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
Card >> diceAdjustment [

	^ 0
]
