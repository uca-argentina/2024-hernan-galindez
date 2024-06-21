Class {
	#name : #CardSquare,
	#superclass : #Square,
	#instVars : [
		'expectedNumber',
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'add/remove' }
CardSquare >> applyEffectTo: aSpaceship in: aGameboard [

	aSpaceship giveCard: (aGameboard possibleCards) atRandom
]
