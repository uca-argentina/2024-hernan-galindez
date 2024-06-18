Class {
	#name : #Overload,
	#superclass : #Permanent,
	#instVars : [
		'affectedSpaceship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Overload >> applyFrom: aSpaceship to: otherSpaceships [

	otherSpaceships size = 1 ifFalse: [
		Error signal: 'This card can only be applied to one spaceship' ].


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

{ #category : #removing }
Overload >> removeEffects [

	
]
