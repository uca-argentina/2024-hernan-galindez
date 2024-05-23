Class {
	#name : 'Dice',
	#superclass : 'Object',
	#type : 'variable',
	#instVars : [
		'diceArray'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Dice class >> with: anArrayMadeOfDice [

	^ self new initializeWith: anArrayMadeOfDice
]

{ #category : 'initialization' }
Dice >> initializeWith: anArrayMadeOfDice [

	diceArray := anArrayMadeOfDice
]

{ #category : 'initialization' }
Dice >> throw [

	^ diceArray sum: [ :die | die throw ]
]
