Class {
	#name : #Cancellation,
	#superclass : #Instant,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Cancellation >> applyFrom: aSpaceship target: cardToBeCancelled blockToApplyLastEffect: blockOfCode [

	(aSpaceship removeEffect: cardToBeCancelled) 
]
