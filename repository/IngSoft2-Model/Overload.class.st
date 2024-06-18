Class {
	#name : #Overload,
	#superclass : #Card,
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
	affectedSpaceship changeTotalThrowBy: 2 negated.
	"affectedSpaceship applyCard: self"
]

{ #category : #removing }
Overload >> removeEffects [

	affectedSpaceship changeTotalThrowBy: 2.
]
