Class {
	#name : #NullCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
NullCard >> applyFrom: aSpaceship target: otherSpaceships blockToApplyLastEffect: lastSquareLandedOn [

	Error signal: 'This card has not been used'
]
