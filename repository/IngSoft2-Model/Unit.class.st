Class {
	#name : #Unit,
	#superclass : #Object,
	#instVars : [
		'value',
		'unitsRatio'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #arithmetic }
Unit >> // anotherUnit [

	| conversion |
	conversion := anotherUnit convertTo: self.

	^ value // conversion
]

{ #category : #private }
Unit >> convertTo: aUnit [

	| ratioToUnit |
	ratioToUnit := self find: {self class . aUnit class}.
	^ value * ratioToUnit
]

{ #category : #'as yet unclassified' }
Unit >> find: aConversionRate [

	^(unitsRatio at: aConversionRate) 
]

{ #category : #'as yet unclassified' }
Unit >> initialize [

	unitsRatio := Dictionary new.
	unitsRatio add: {
			Parsecs.
			LightYears } -> 3.
	unitsRatio add: {
			LightYears.
			Parsecs } -> (1 / 3).
	unitsRatio add: {
			Parsecs.
			Parsecs } -> 1.
	unitsRatio add: {
			LightYears.
			LightYears } -> 1
]
