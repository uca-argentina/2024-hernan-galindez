Class {
	#name : #Overload,
	#superclass : #Permanent,
	#instVars : [
		'affectedSpaceship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Overload >> applyFrom: aSpaceship target: otherSpaceshipsName blockToApplyLastEffect: lastSquareLandedOn [

	affectedSpaceship := players
		                     detect: [ :player |
		                     player name = otherSpaceshipsName ]
		                     ifNone: [
		                     Error signal:
			                     'Overload card target must be a player name' ].

	affectedSpaceship applyCard: self.
	affectedSpaceship changeTotalThrowBy: 2 negated
]

{ #category : #removing }
Overload >> initialize [

	affectedSpaceship := NullSpaceship new
]

{ #category : #removing }
Overload >> removeEffects [
	"affectedSpaceship removeEffect: self"

	affectedSpaceship changeTotalThrowBy: 2
]
