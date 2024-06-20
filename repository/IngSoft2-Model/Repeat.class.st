Class {
	#name : #Repeat,
	#superclass : #Instant,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Repeat >> applyFrom: aSpaceship to: otherSpaceships blockToApplyLastEffect: blockToApplyLastEffect [

	| affectedSpaceship |
	aSpaceship useCard: self.
	affectedSpaceship := otherSpaceships first.
	blockToApplyLastEffect value: affectedSpaceship.
]
