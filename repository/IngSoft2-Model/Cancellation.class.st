Class {
	#name : #Cancellation,
	#superclass : #Instantaneous,
	#instVars : [
		'cardToBeCancelled'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Cancellation class >> with: card [

	^self new initializeWith: card
]

{ #category : #operations }
Cancellation >> applyFrom: aSpaceship to: otherSpaceships [

	otherSpaceships first removeEffect: cardToBeCancelled.	
	cardToBeCancelled removeEffects.
]

{ #category : #initialization }
Cancellation >> initializeWith: card [

	cardToBeCancelled := card.
	
	
]
