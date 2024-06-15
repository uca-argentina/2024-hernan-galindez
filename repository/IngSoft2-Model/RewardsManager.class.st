Class {
	#name : #RewardsManager,
	#superclass : #Object,
	#instVars : [
		'rewards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RewardsManager class >> with: rewardsCollection [

	^self new initializeWith: rewardsCollection.
]

{ #category : #initialization }
RewardsManager >> applyTo: aSpaceship [

	rewards atRandom applyTo: aSpaceship
]

{ #category : #initialization }
RewardsManager >> initializeWith: rewardsCollection [

	rewards := rewardsCollection collect: [ :each |
		              OrderedCollection
			              new: (each value * 100) asInteger
			              withAll: each key ].
	rewards := rewards flattened.
]
