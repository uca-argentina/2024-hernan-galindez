Class {
	#name : #Repeat,
	#superclass : #Instant,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Repeat >> applyFrom: aSpaceship to: otherSpaceships blockToApplyLastEffect: blockToApplyLastEffect [

	| affectedSpaceship |
	affectedSpaceship := otherSpaceships first.
	blockToApplyLastEffect value: affectedSpaceship.
]
