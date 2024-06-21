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
Overload >> applyFrom: aSpaceship to: otherSpaceshipsNames blockToApplyLastEffect: lastSquareLandedOn [

	| otherSpaceships |
	"otherSpaceshipsNames size = 1 ifFalse: [
		Error signal: 'This card can only be applied to one spaceship' ]."

	otherSpaceships := otherSpaceshipsNames collect: [ :playerName |
		                   players detect: [ :player |
			                   player name = playerName ] ].

	affectedSpaceship := otherSpaceships first.
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

{ #category : #initialization }
Overload >> initializeWith: playersCollection [

	players := playersCollection
]

{ #category : #removing }
Overload >> removeEffects [

	
]
