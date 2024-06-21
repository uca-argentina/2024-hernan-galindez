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
Cancellation >> applyFrom: aSpaceship target: cardToBeCancelled blockToApplyLastEffect: blockOfCode [

	(aSpaceship removeEffect: cardToBeCancelled) removeEffects
]
