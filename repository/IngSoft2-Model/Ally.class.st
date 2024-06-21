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
Ally >> applyFrom: aSpaceship target: targetName blockToApplyLastEffect: lastSquareLandedOn [

	| otherSpaceship |
	otherSpaceship := players
		                  detect: [ :player |
		                  player name = targetName ]
		                  ifNone: [
		                  Error signal: 'Ally card target must be a player name' ].

	otherSpaceship applyCard: self.
	aSpaceship applyCard: self.

	aSpaceship allyWith: otherSpaceship.
	otherSpaceship allyWith: aSpaceship.

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
