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
Card >> applyFrom: aSpaceship to: otherSpaceships blockToApplyLastEffect: lastSquareLandedOn [

	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
Card >> diceAdjustment [

	^ 0
]

{ #category : #'as yet unclassified' }
Card >> lastUsedCard: aCard [

	^ self
]

{ #category : #removing }
Card >> removeEffects [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
Card >> verifyCanBePlayed: isShipTurn [

	self subclassResponsibility
]
