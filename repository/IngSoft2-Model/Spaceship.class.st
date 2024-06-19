Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'name',
		'maxCapacity',
		'currentFuel',
		'needsToThrow',
		'lostTurns',
		'deck',
		'ally'
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

{ #category : #accessing }
Spaceship >> allyWith: aSpaceship [

	ally := aSpaceship
]

{ #category : #'as yet unclassified' }
Spaceship >> applyCard: card [

	deck usedCard: card.
]

{ #category : #setting }
Spaceship >> applyPenaltyIn: gameboard [

	gameboard moveToStart: self.
	currentFuel := maxCapacity.
	lostTurns := 2
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

{ #category : #'as yet unclassified' }
Spaceship >> changeTotalThrowBy: aNumber [

	diceAdjustment := diceAdjustment + aNumber.
]

{ #category : #initialization }
Spaceship >> initializeWithName: aName withFuel: fuelCapacity [

	name := aName.
	currentFuel := fuelCapacity.
	maxCapacity := fuelCapacity.
	needsToThrow := 0.
	lostTurns := 0.
	ally := NullSpaceship new.
	deck := Deck with: #().
]

{ #category : #initialization }
Spaceship >> initializeWithName: aName withFuel: fuelCapacity withCards: deckOfCards [

	name := aName.
	currentFuel := fuelCapacity.
	maxCapacity := fuelCapacity.
	deck := deckOfCards.
	needsToThrow := 0.
	lostTurns := 0.
	ally := NullSpaceship new.
	deck := Deck with: deckOfCards .
]

{ #category : #'game logic' }
Spaceship >> lostATurn [
	lostTurns := lostTurns - 1.

]

{ #category : #accessing }
Spaceship >> move: anAmountOfSquares in: aGameboard [

	| squaresToMove diceAdjustment |
	diceAdjustment := deck diceAdjustment.
	squaresToMove := anAmountOfSquares + diceAdjustment.

	self useAllyFuelIfNecessary: squaresToMove in: aGameboard.

	currentFuel > squaresToMove abs
		ifTrue: [
			currentFuel := currentFuel - squaresToMove abs.
			aGameboard move: self with: squaresToMove ]
		ifFalse: [ self applyPenaltyIn: aGameboard ]
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
Spaceship >> removeEffect: cardToBeRemoved [
	deck removeCardEffect: cardToBeRemoved
]

{ #category : #accessing }
Spaceship >> takeFuel: anAmountOfFuel [

	anAmountOfFuel > currentFuel ifTrue: [ ^ 0 ].

	currentFuel := currentFuel - anAmountOfFuel.

	^ anAmountOfFuel
]

{ #category : #setting }
Spaceship >> use: cardName to: otherSpaceships [

	(deck removeCard: cardName) applyFrom: self to: otherSpaceships
]

{ #category : #setting }
Spaceship >> use: cardName to: otherSpaceships blockToApplyLastEffect: aBlockOfCode [ 

	(deck removeCard: cardName) applyFrom: self to: otherSpaceships blockToApplyLastEffect: aBlockOfCode
]

{ #category : #accessing }
Spaceship >> useAllyFuelIfNecessary: squaresToMove in: gameboard [

	| allyFuel |
	currentFuel <= squaresToMove abs ifFalse: [ ^ self ].

	allyFuel := ally takeFuel: squaresToMove - currentFuel + 1.

	currentFuel := currentFuel + allyFuel.

	currentFuel <= squaresToMove abs ifTrue: [
		ally applyPenaltyIn: gameboard ]
]
