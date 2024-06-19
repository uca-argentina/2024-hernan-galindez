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
Redo class >> instance [

	^ instance ifNil: [ instance := self basicNew ]
]

{ #category : #operations }
Redo class >> new [

	^ instance ifNil: [ instance := self basicNew ]
]

{ #category : #operations }
Redo class >> recreate [
	instance :=  nil.
	^ self new initialize
]

{ #category : #operations }
Redo >> applyFrom: aSpaceship to: otherSpaceships blockToApplyLastEffect: lastSquareLandedOn [

	lastUsedCard
		applyFrom: aSpaceship
		to: otherSpaceships
		blockToApplyLastEffect: lastSquareLandedOn
]

{ #category : #initialization }
Redo >> initialize [
	lastUsedCard := NullCard new.
]

{ #category : #operations }
Redo >> lastUsedCard: aCard [

	aCard class = self class ifTrue: [ ^ self ].
	lastUsedCard := aCard
]

{ #category : #operations }
Redo >> verifyCanBePlayedAtAnyMoment [
	lastUsedCard verifyCanBePlayedAtAnyMoment
]
