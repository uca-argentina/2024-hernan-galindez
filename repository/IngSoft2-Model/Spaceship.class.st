Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'name',
		'laps',
		'maxCapacity',
		'currentFuel',
		'gameboard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance initialization' }
Spaceship class >> withName: aName withFuel: fuelCapacity inGameboard: aGameboard [

	^ self new initializeWithName: aName withFuel: fuelCapacity inGameboard: aGameboard.
]

{ #category : #setting }
Spaceship >> addLaps: aNumberOfLaps [

	laps := laps + aNumberOfLaps 
]

{ #category : #initialization }
Spaceship >> initializeWithName: aName withFuel: fuelCapacity inGameboard: aGameboard [

	gameboard := aGameboard.
	name := aName.
	currentFuel := fuelCapacity.
	maxCapacity := fuelCapacity.
	laps := 0
]

{ #category : #accessing }
Spaceship >> lapsCompleted [
	^laps.
]

{ #category : #accessing }
Spaceship >> move: anAmountOfSquares [

	currentFuel > anAmountOfSquares
		ifTrue: [
			currentFuel := currentFuel - anAmountOfSquares.
			gameboard move: self with: anAmountOfSquares.
			^ 0 ]
		ifFalse: [
			gameboard moveToStart: self.
			currentFuel := maxCapacity.
			^ 2 ]
]

{ #category : #accessing }
Spaceship >> name [ 
	^name
]

{ #category : #setting }
Spaceship >> refuel [

	currentFuel := maxCapacity
]
