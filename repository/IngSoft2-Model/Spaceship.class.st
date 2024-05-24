Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'name',
		'laps',
		'maxCapacity',
		'currentFuel'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance initialization' }
Spaceship class >> withName: aName withFuel: fuelCapacity [

	^ self new initializeWithName: aName withFuel: fuelCapacity.
]

{ #category : #accessing }
Spaceship >> addLaps: aNumberOfLaps [

	laps := laps + aNumberOfLaps 
]

{ #category : #initialization }
Spaceship >> initializeWithName: aName withFuel: fuelCapacity [

	name := aName.
	currentFuel := fuelCapacity.
	maxCapacity:= fuelCapacity.
	laps := 0
]

{ #category : #accessing }
Spaceship >> lapsCompleted [
	^laps.
]

{ #category : #'as yet unclassified' }
Spaceship >> move: anAmountOfSquares in: aGameboard [

	currentFuel > anAmountOfSquares ifTrue: [
		currentFuel := currentFuel - anAmountOfSquares.
		aGameboard move: self with: anAmountOfSquares. 
	] ifFalse:[
		aGameboard moveToStart: self.
		currentFuel:= maxCapacity 
	]
]

{ #category : #accessing }
Spaceship >> name [ 
	^name
]
