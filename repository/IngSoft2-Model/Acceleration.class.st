Class {
	#name : #Acceleration,
	#superclass : #Permanent,
	#instVars : [
		'affectedSpaceships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Acceleration class >> create [

	^ self new initialize
]

{ #category : #operations }
Acceleration >> applyFrom: aSpaceship to: otherSpaceshipsNames blockToApplyLastEffect: lastSquareLandedOn [

	players do: [ :spaceship | spaceship applyCard: self ]
]

{ #category : #'as yet unclassified' }
Acceleration >> diceAdjustment [

	^ 1
]

{ #category : #initialization }
Acceleration >> initialize [
	affectedSpaceships := OrderedCollection new.
]

{ #category : #initialization }
Acceleration >> removeEffects [
	^ self
]
