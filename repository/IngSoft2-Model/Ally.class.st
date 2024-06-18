Class {
	#name : #Ally,
	#superclass : #Permanent,
	#instVars : [
		'firstAlly',
		'secondAlly'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Ally >> applyFrom: aSpaceship to: otherSpaceships [

	| otherSpaceship |
	otherSpaceships size = 1 ifFalse: [
		Error signal: 'This card can only be applied to one spaceship' ].

	otherSpaceship := otherSpaceships first.

	aSpaceship allyWith: otherSpaceship.
	aSpaceship applyCard: self.
	otherSpaceship allyWith: aSpaceship.
	otherSpaceship applyCard: self.

	firstAlly := aSpaceship.
	secondAlly := otherSpaceship
]

{ #category : #initialization }
Ally >> initialize [
	firstAlly := NullSpaceship new.
	secondAlly := NullSpaceship new.
]

{ #category : #operations }
Ally >> removeEffects [

	firstAlly allyWith: NullSpaceship new.
	secondAlly allyWith: NullSpaceship new.
]
