Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'name',
		'players'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Card class >> createWith: players [

	^ self new initializeWith: players
]

{ #category : #comparing }
Card >> = anotherCard [

	^(anotherCard isKindOf: self class)
]

{ #category : #operations }
Card >> applyFrom: aSpaceship target: otherSpaceships blockToApplyLastEffect: lastSquareLandedOn [

	self subclassResponsibility.
]

{ #category : #initialization }
Card >> initializeWith: playersCollection [
	players := playersCollection
]

{ #category : #removing }
Card >> removeEffects [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
Card >> verifyCanBePlayed: isShipTurn [

	self subclassResponsibility
]
