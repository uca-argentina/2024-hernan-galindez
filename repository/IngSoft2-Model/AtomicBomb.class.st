Class {
	#name : #AtomicBomb,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #'add/remove' }
AtomicBomb >> applyEffectTo: aSpaceship in: aGameboard [

	aGameboard moveAllToStart 
]

{ #category : #initialization }
AtomicBomb >> initializeWithBoard: board [

	gameboard := board
]
