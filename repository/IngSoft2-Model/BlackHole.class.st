Class {
	#name : #BlackHole,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #'add/remove' }
BlackHole >> applyEffectTo: aSpaceship in: aGameboard [

	aSpaceship move: -4 in: aGameboard
]
