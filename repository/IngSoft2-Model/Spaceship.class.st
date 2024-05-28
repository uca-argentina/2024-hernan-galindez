Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'name',
		'laps',
		'maxCapacity',
		'currentFuel',
		'needsToThrow',
		'lostTurns'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Spaceship class >> withName: aName withFuel: fuelCapacity [

	^ self new initializeWithName: aName withFuel: fuelCapacity
]

{ #category : #testing }
Spaceship >> canPlay [

	^ lostTurns = 0
]

{ #category : #setting }
Spaceship >> changeLapsBy: aNumberOfLaps [

	laps := laps + aNumberOfLaps 
]

{ #category : #initialization }
Spaceship >> initializeWithName: aName withFuel: fuelCapacity [

	name := aName.
	currentFuel := fuelCapacity.
	maxCapacity := fuelCapacity.
	laps := 0.
	needsToThrow := 0.
	lostTurns := 0.
]

{ #category : #accessing }
Spaceship >> lapsCompleted [
	^laps.
]

{ #category : #'game logic' }
Spaceship >> lostATurn [
	lostTurns := lostTurns - 1.

]

{ #category : #accessing }
Spaceship >> move: anAmountOfSquares in: aGameboard withEffects: aBoolean [

	currentFuel > anAmountOfSquares abs
		ifTrue: [
			currentFuel := currentFuel - anAmountOfSquares abs.
			aGameboard move: self with: anAmountOfSquares withEffects: aBoolean ]
		ifFalse: [
			aGameboard moveToStart: self.
			currentFuel := maxCapacity.
			lostTurns := 2 ]
]

{ #category : #accessing }
Spaceship >> moveFoward: anAmountOfSquares in: aGameboard withEffects: aBoolean [

	anAmountOfSquares abs < needsToThrow ifTrue: [ ^ self ].
	needsToThrow := 0.
	self move: anAmountOfSquares in: aGameboard withEffects: aBoolean
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
