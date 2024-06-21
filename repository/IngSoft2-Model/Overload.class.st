Class {
	#name : #Overload,
	#superclass : #Permanent,
	#instVars : [
		'affectedSpaceship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Overload class >> createWith: playersCollection [
	^ self new initializeWith: playersCollection
]

{ #category : #operations }
Overload >> applyFrom: aSpaceship target: otherSpaceshipsNames blockToApplyLastEffect: lastSquareLandedOn [

	affectedSpaceship := players
		                     detect: [ :player |
		                     player name = otherSpaceshipsNames ]
		                     ifNone: [
		                     Error signal:
			                     'Overload card target must be a player name' ].

	affectedSpaceship applyCard: self
]

{ #category : #'as yet unclassified' }
Overload >> diceAdjustment [

	^ 2 negated
]

{ #category : #removing }
Overload >> initialize [

	affectedSpaceship := NullSpaceship new
]

{ #category : #removing }
Overload >> removeEffects [

	"affectedSpaceship removeEffect: self"
]
