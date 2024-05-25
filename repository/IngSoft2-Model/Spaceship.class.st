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

{ #category : #setting }
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

{ #category : #accessing }
Spaceship >> move: anAmountOfSquares in: aGameboard [

	currentFuel > anAmountOfSquares
		ifTrue: [
			currentFuel := currentFuel - anAmountOfSquares.
			aGameboard move: self with: anAmountOfSquares.
			^ 0 ]
		ifFalse: [
			aGameboard moveToStart: self.
			currentFuel := maxCapacity.
			^ 2]
		
	
]

{ #category : #accessing }
Spaceship >> name [ 
	^name
]

{ #category : #setting }
Spaceship >> refuel [

	currentFuel := maxCapacity
]
