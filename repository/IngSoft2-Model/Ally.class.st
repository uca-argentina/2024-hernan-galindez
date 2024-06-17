Class {
	#name : #Ally,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Ally >> applyFrom: aSpaceship to: otherSpaceships [

	otherSpaceships size = 1 ifFalse: [
		Error signal: 'This card can only be applied to one spaceship' ].

	aSpaceship allyWith: otherSpaceships first.
	otherSpaceships first allyWith: aSpaceship
]
