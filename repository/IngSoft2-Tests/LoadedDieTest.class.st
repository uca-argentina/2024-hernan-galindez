Class {
	#name : #LoadedDieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
LoadedDieTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [ 
	self should: anErrorBlock raise: anErrorClass withExceptionDo: [:error | self assert: error messageText equals: anErrorMessage].
]

{ #category : #tests }
LoadedDieTest >> testDieIsCreatedWithAnAmountOfFaces [

	| aDie |
	aDie := LoadedDie sequence: #( 3 ).

	self assert: aDie throw equals: 3
]

{ #category : #tests }
LoadedDieTest >> testWhenDieIsThrownThenValueIsNumberOfFaces [

	| aDie |
	aDie := LoadedDie sequence: #( 5 ).

	self assert: aDie throw equals: 5
]
