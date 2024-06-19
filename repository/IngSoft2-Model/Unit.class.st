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
	self class = aUnit class ifTrue: [ ^ value ].
	ratioToUnit := self find: {
			               self class.
			               aUnit class }.
	^ value * ratioToUnit
]

{ #category : #'as yet unclassified' }
Unit >> find: aConversionRate [

	^(unitsRatio at: aConversionRate ifAbsent: [ 1 / unitsRatio at: { aConversionRate second . aConversionRate first } ])
]

{ #category : #'as yet unclassified' }
Unit >> initialize [

	unitsRatio := Dictionary new.
	unitsRatio add: {
			Parsecs.
			LightYears } -> 3
]
