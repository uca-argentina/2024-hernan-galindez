Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cardsInHand',
		'cardsUsed'
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

{ #category : #initialization }
Deck >> initializeWith: cards [

	cardsInHand := cards asOrderedCollection.
	cardsUsed := OrderedCollection new
]

{ #category : #removing }
Deck >> removeCard: card [

	^ cardsInHand
		  remove: card
		  ifAbsent: [
		  Error signal: 'This spaceship does not have this card' ]
]

{ #category : #initialization }
Deck >> usedCard: card [

	cardsUsed add: card
]
