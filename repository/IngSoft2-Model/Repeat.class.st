Class {
	#name : #Repeat,
	#superclass : #Instant,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Repeat >> applyFrom: aSpaceship to: otherSpaceshipsNames blockToApplyLastEffect: blockToApplyLastEffect [

	| affectedSpaceship target |
	target := otherSpaceshipsNames collect: [ :playerName |
		          players detect: [ :player | player name = playerName ] ].
	affectedSpaceship := target first.
	blockToApplyLastEffect value: affectedSpaceship
]
