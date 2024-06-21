Class {
	#name : #Repeat,
	#superclass : #Instant,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Repeat >> applyFrom: aSpaceship target: otherSpaceshipName blockToApplyLastEffect: blockToApplyLastEffect [

	| target |
	target := players detect: [ :player |
		          player name = otherSpaceshipName ].
	blockToApplyLastEffect value: target
]
