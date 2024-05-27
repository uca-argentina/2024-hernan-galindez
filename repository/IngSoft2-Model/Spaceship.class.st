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

{ #category : #setting }
Spaceship >> addLaps: aNumberOfLaps [

	laps := laps + aNumberOfLaps 
]

{ #category : #testing }
Spaceship >> canPlay [

	^ lostTurns = 0
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
Spaceship >> move: anAmountOfSquares in: aGameboard [

	currentFuel > anAmountOfSquares abs
		ifTrue: [
			currentFuel := currentFuel - anAmountOfSquares.
			aGameboard move: self with: anAmountOfSquares ]
		ifFalse: [
			aGameboard moveToStart: self.
			currentFuel := maxCapacity.
			lostTurns := 2 ]
]

{ #category : #accessing }
Spaceship >> moveBack: anAmountOfSquares in: aGameboard [
	
	self move: anAmountOfSquares  in: aGameboard 

]

{ #category : #accessing }
Spaceship >> moveFoward: anAmountOfSquares in: aGameboard [

	lostTurns > 0 ifTrue: [
		lostTurns := lostTurns - 1.
		^ self ].
	anAmountOfSquares abs < needsToThrow ifTrue: [ ^ self ].
	needsToThrow := 0.
	self move: anAmountOfSquares in: aGameboard
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

{ #category : #'game logic' }
Spaceship >> skipTurns [

	lostTurns := lostTurns + 1.
]
