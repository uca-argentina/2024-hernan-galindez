Class {
	#name : #Acceleration,
	#superclass : #Card,
	#instVars : [
		'affectedSpaceships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Acceleration >> applyFrom: aSpaceship to: otherSpaceships [

	affectedSpaceships := otherSpaceships.
	affectedSpaceships do: [ :spaceship |
		spaceship changeTotalThrowBy: 1 ]
]

{ #category : #initialization }
Acceleration >> removeEffects [

	affectedSpaceships do: [ :spaceship | spaceship changeTotalThrowBy: 1 negated ] .
	
]
