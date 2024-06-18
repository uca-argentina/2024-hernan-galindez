Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cardsInHand',
		'appliedCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> with: cards [

	^self new initializeWith: cards
]

{ #category : #operations }
Deck >> applyFrom: aSpaceship to: otherSpaceships [

	cardsInHand applyFrom: aSpaceship to: otherSpaceships
]

{ #category : #'as yet unclassified' }
Deck >> diceAdjustment [
	^ (appliedCards collect: [ :card | card diceAdjustment ]) sumNumbers
]

{ #category : #initialization }
Deck >> initializeWith: cards [

	cardsInHand := cards asOrderedCollection.
	appliedCards := OrderedCollection new
]

{ #category : #removing }
Deck >> removeCard: card [

	^ cardsInHand
		  remove: card
		  ifAbsent: [
		  Error signal: 'This spaceship does not have this card' ]
]

{ #category : #initialization }
Deck >> removeCardEffect: cardToBeRemoved [
	appliedCards remove: cardToBeRemoved ifAbsent: [Error signal: 'This card cant be cancelled'].
]

{ #category : #initialization }
Deck >> usedCard: card [

	appliedCards add: card
]