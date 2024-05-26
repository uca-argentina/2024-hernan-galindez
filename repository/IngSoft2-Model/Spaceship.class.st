Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'name',
		'laps',
		'maxCapacity',
		'currentFuel',
		'needsToThrow'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Spaceship class >> withName: aName withFuel: fuelCapacity [

	^ self new initializeWithName: aName withFuel: fuelCapacity
]

{ #category : #setting }
Spaceship >> addLaps: aNumberOfLaps [

	laps := laps + aNumberOfLaps 
]

{ #category : #initialization }
Spaceship >> initializeWithName: aName withFuel: fuelCapacity [

	name := aName.
	currentFuel := fuelCapacity.
	maxCapacity := fuelCapacity.
	laps := 0.
	needsToThrow := 0.
]

{ #category : #accessing }
Spaceship >> lapsCompleted [
	^laps.
]

{ #category : #accessing }
Spaceship >> move: anAmountOfSquares in: aGameboard [

	| lostTurns |
	lostTurns := 0.
	anAmountOfSquares < needsToThrow ifTrue: [ ^ lostTurns ].
	needsToThrow := 0.
	currentFuel > anAmountOfSquares
		ifTrue: [
			currentFuel := currentFuel - anAmountOfSquares.
			aGameboard move: self with: anAmountOfSquares ]
		ifFalse: [
			aGameboard moveToStart: self.
			currentFuel := maxCapacity.
			lostTurns := 2 ].
	^ lostTurns
]

{ #category : #accessing }
Spaceship >> name [ 
	^name
]

{ #category : #initialization }
Spaceship >> needsToThrow: expectedNumber [

	needsToThrow := expectedNumber.
]

{ #category : #setting }
Spaceship >> refuel [

	currentFuel := maxCapacity
]
