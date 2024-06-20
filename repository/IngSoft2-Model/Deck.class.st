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

	cardsInHand := cards asOrderedCollection.
	appliedCards := OrderedCollection new
]

{ #category : #removing }
Deck >> removeCard: cardToBeRemoved [
	"[ Error signal: 'This spaceship does not have this card' ]"

"	| index x |
	index := cardsInHand
		         detectIndex: [ :card | card = cardToBeRemoved ]
		         ifNone: [ 1 ].
	x := cardsInHand at: index.
"
	^ cardsInHand
		  remove: cardToBeRemoved
		  ifAbsent: [
		  Error signal: 'This spaceship does not have this card' ]
]

{ #category : #initialization }
Deck >> removeCardEffect: cardToBeRemoved [
	appliedCards remove: cardToBeRemoved ifAbsent: [Error signal: 'This card was not used on this spaceship'] 
]

{ #category : #initialization }
Deck >> usedCard: card [

	appliedCards add: card
]
