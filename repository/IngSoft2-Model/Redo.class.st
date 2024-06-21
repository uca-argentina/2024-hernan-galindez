Class {
	#name : #Redo,
	#superclass : #Card,
	#instVars : [
		'lastUsedCard'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Redo class >> create [
	^ self new initializeWith
]

{ #category : #operations }
Redo class >> createWith: playersCollection [

	^ instance ifNil: [ instance := self new initialize ]
]

{ #category : #'as yet unclassified' }
Redo class >> deleteInstance [
	instance := nil
]

{ #category : #operations }
Redo class >> instance [

	^ instance ifNil: [ instance := self basicNew ]
]

{ #category : #operations }
Redo class >> recreate [
	instance :=  self new initialize.
	^ instance
]

{ #category : #operations }
Redo >> applyFrom: aSpaceship to: otherSpaceships blockToApplyLastEffect: lastSquareLandedOn [

	lastUsedCard 
		applyFrom: aSpaceship
		to: otherSpaceships
		blockToApplyLastEffect: lastSquareLandedOn
]

{ #category : #testing }
Redo >> canBeReDone [
	^false
]

{ #category : #initialization }
Redo >> initialize [
	lastUsedCard := NullCard new.
]

{ #category : #initialization }
Redo >> initializeWith [
	lastUsedCard := NullCard new.
]

{ #category : #operations }
Redo >> lastUsedCard: aCard [

	aCard = self ifTrue: [ ^ self ].
	lastUsedCard := aCard
]

{ #category : #'as yet unclassified' }
Redo >> verifyCanBePlayed: isShipTurn [

	lastUsedCard verifyCanBePlayed: isShipTurn 
]

{ #category : #operations }
Redo >> verifyCanBePlayedAtAnyMoment [
	lastUsedCard verifyCanBePlayedAtAnyMoment
]
