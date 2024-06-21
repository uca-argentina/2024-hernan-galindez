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

{ #category : #initialization }
Deck >> cardApplied: card [

	appliedCards add: card
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
		             Error signal: 'This spaceship does not have ' , cardToBeRemoved class asString , ' card' ].
	card := cardsInHand at: cardIndex.
	cardsInHand remove: cardToBeRemoved.

	^ card
]

{ #category : #initialization }
Deck >> removeCardEffect: cardToBeRemoved [

	| cardIndex card |
	cardIndex := appliedCards indexOf: cardToBeRemoved ifAbsent: [
		             Error signal: cardToBeRemoved class asString
			             , ' card was not used on this spaceship' ].
	card := appliedCards at: cardIndex.
	card removeEffects.
	appliedCards remove: cardToBeRemoved.

	^ card
]
