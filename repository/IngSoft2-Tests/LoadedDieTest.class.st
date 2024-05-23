Class {
	#name : 'LoadedDieTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
LoadedDieTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [ 
	self should: anErrorBlock raise: anErrorClass withExceptionDo: [:error | self assert: error messageText equals: anErrorMessage].
]

{ #category : 'tests' }
LoadedDieTest >> testDieCannotBeCreatedWithLessThanTwoFaces [

	self
		should: [ LoadedDie of: 2 ]
		raise: Error
		withMessage: 'Faces should be more than 2'
]

{ #category : 'tests' }
LoadedDieTest >> testDieIsCreatedWithAnAmountOfFaces [

	| aDie |
	aDie := LoadedDie of: 5.

	self assert: aDie throw equals: 5
]

{ #category : 'tests' }
LoadedDieTest >> testWhenDieIsThrownThenValueIsNumberOfFaces [ 

| aDie |

aDie := LoadedDie of: 5.

self assert: aDie throw equals: 5.
]
