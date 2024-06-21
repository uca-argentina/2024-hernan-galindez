Class {
	#name : #Cancellation,
	#superclass : #Instant,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Cancellation class >> with: card [

	^self new initializeWith: card
]

{ #category : #operations }
Cancellation >> applyFrom: aSpaceship to: cardToBeCancelled blockToApplyLastEffect: lastSquareLandedOn [

	(aSpaceship removeEffect: cardToBeCancelled ) removeEffects
]

{ #category : #initialization }
Cancellation >> initializeWith: playersCollection [

"	cardToBeCancelled := NullCard new."
	players := playersCollection
]
