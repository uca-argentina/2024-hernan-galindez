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

{ #category : #initialization }
Deck >> addCard: aCard [

	cardsInHand add: aCard
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

	cardsInHand := cards copy.
	appliedCards := OrderedCollection new
]

{ #category : #removing }
Deck >> removeCard: cardToBeRemoved [

	| cardIndex card |
	cardIndex := cardsInHand
		             indexOf: cardToBeRemoved
		             ifAbsent: [
		             Error signal: 'This spaceship does not have this card' ].
	card := cardsInHand at: cardIndex.
	cardsInHand remove: cardToBeRemoved.

	^ card
]

{ #category : #initialization }
Deck >> removeCardEffect: cardToBeRemoved [

	| cardIndex card |
	cardIndex := appliedCards
		             indexOf: cardToBeRemoved
		             ifAbsent: [
		             Error signal:
			             'This card was not used on this spaceship' ].
	card := appliedCards at: cardIndex.
	appliedCards remove: cardToBeRemoved.

	^ card
]

{ #category : #initialization }
Deck >> usedCard: card [

	appliedCards add: card
]
