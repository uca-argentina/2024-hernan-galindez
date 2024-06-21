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
Ally >> applyFrom: aSpaceship to: otherSpaceshipsNames blockToApplyLastEffect: lastSquareLandedOn [

	| otherSpaceship otherSpaceships |
	otherSpaceshipsNames size = 1 ifFalse: [
		Error signal: 'This card can only be applied to one spaceship' ].

	otherSpaceships := otherSpaceshipsNames collect: [ :playerName |
		                   players detect: [ :player |
			                   player name = playerName ] ].
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
