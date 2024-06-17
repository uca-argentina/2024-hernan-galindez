Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'name',
		'maxCapacity',
		'currentFuel',
		'needsToThrow',
		'lostTurns',
		'diceAdjustment',
		'deck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Spaceship class >> withName: aName withFuel: fuelCapacity [

	^ self new initializeWithName: aName withFuel: fuelCapacity
]

{ #category : #initialization }
Spaceship class >> withName: aName withFuel: fuelCapacity withCards: deckOfCards [

	^ self new initializeWithName: aName withFuel: fuelCapacity withCards: deckOfCards
]

{ #category : #testing }
Spaceship >> canPlay [

	^ lostTurns = 0
]

{ #category : #accessing }
Spaceship >> changeFuelCapacityBy: anAmount [

	maxCapacity := maxCapacity + anAmount.
	currentFuel := maxCapacity min: currentFuel
]

{ #category : #setting }
Spaceship >> changeTotalThrowBy: aNumber [

	diceAdjustment := diceAdjustment + aNumber
]

{ #category : #initialization }
Spaceship >> initializeWithName: aName withFuel: fuelCapacity [

	name := aName.
	currentFuel := fuelCapacity.
	maxCapacity := fuelCapacity.
	needsToThrow := 0.
	lostTurns := 0.
	diceAdjustment := 0
]

{ #category : #initialization }
Spaceship >> initializeWithName: aName withFuel: fuelCapacity withCards: deckOfCards [

	name := aName.
	currentFuel := fuelCapacity.
	maxCapacity := fuelCapacity.
	deck := deckOfCards.
	needsToThrow := 0.
	lostTurns := 0.
	diceAdjustment := 0
]

{ #category : #'game logic' }
Spaceship >> lostATurn [
	lostTurns := lostTurns - 1.

]

{ #category : #accessing }
Spaceship >> move: anAmountOfSquares in: aGameboard [

	| squaresToMove |
	squaresToMove := anAmountOfSquares + diceAdjustment.

	currentFuel > squaresToMove abs
		ifTrue: [
			currentFuel := currentFuel - squaresToMove abs.
			aGameboard move: self with: squaresToMove ]
		ifFalse: [
			aGameboard moveToStart: self.
			currentFuel := maxCapacity.
			lostTurns := 2 ]
]

{ #category : #accessing }
Spaceship >> name [ 
	^name
]

{ #category : #initialization }
Spaceship >> needsToThrow: expectedNumber [

	needsToThrow := expectedNumber.
]

{ #category : #accessing }
Spaceship >> playWith: anAmountOfSquares in: aGameboard [
	
	anAmountOfSquares abs < needsToThrow ifTrue: [ ^ self ].
	needsToThrow := 0.
	self move: anAmountOfSquares in: aGameboard
]

{ #category : #setting }
Spaceship >> refuel [

	currentFuel := maxCapacity
]

{ #category : #setting }
Spaceship >> use: cardName to: otherSpaceships [

	deck applyTo: otherSpaceships
]
