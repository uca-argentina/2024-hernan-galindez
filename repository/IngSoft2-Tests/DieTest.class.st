Class {
	#name : #DieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DieTest >> should: anErrorBlock raise: exceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: exceptionClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #asserting }
DieTest >> testDieCannotBeCreatedWithLessThanTwoFaces [

	self
		should: [ Die of: 2 ]
		raise: Error
		withMessage: 'Faces should be more than 2'
]

{ #category : #tests }
DieTest >> testMaxThrowIsNumberOfFaces [

	| aDie |
	aDie := Die of: 4.

	self assert: (aDie maxThrow) equals: 4
]

{ #category : #tests }
DieTest >> testReturnsAValueBetweenOneAndNumberOfFacesOfDie [

	| aDie |
	aDie := Die of: 4.

	self assert: (aDie throw between: 1 and: 4)
]

{ #category : #tests }
DieTest >> testWhenDieIsThrownThenValueIsBetweenOneAndNumberOfFaces [

	| aDie |
	aDie := Die of: 5.

	self assert: (aDie throw between: 1 and: 5)
]
