Class {
	#name : #Acceleration,
	#superclass : #Permanent,
	#instVars : [
		'affectedSpaceships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Acceleration >> applyFrom: aSpaceship target: otherSpaceshipsNames blockToApplyLastEffect: blockOfCode [

	players do: [ :spaceship |
		spaceship applyCard: self.
		spaceship changeTotalThrowBy: 1 ]
]

{ #category : #initialization }
Acceleration >> initialize [
	affectedSpaceships := OrderedCollection new.
]

{ #category : #initialization }
Acceleration >> initializeWith: playersCollection [

	players := playersCollection.
	affectedSpaceships := OrderedCollection new
]

{ #category : #initialization }
Acceleration >> removeEffects [

	players do: [ :player | player changeTotalThrowBy: 1 negated ]
]
