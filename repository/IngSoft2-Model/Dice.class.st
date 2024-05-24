Class {
	#name : #Dice,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'diceCollection'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Dice class >> with: anArrayMadeOfDice [

	^ self new initializeWith: anArrayMadeOfDice
]

{ #category : #initialization }
Dice >> initializeWith: anArrayMadeOfDice [

	diceCollection := anArrayMadeOfDice
]

{ #category : #accessing }
Dice >> maxThrow [
	^ (diceCollection sum: [ :die | die maxThrow ])
]

{ #category : #initialization }
Dice >> throw [

	^ (diceCollection collect: [ :eachDie | eachDie throw ] )sum
]
