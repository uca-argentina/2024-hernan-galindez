Class {
	#name : #GameboardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameboardTest >> should: anErrorBlock raise: exceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: exceptionClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
GameboardTest >> testCreateGameboard [

| aGameBoard miTablero |

aGameBoard := Gameboard length: 10.
miTablero := OrderedCollection new: 10 withAll: '-'. 

self assert: (aGameBoard getGrid) equals: miTablero
]

{ #category : #tests }
GameboardTest >> testErrorWhenLengthIsNotGreaterThanZero [ 

	self
	should: [ Gameboard length: -1 ]
	raise: Error 
	withMessage: 'Length must be greater than zero'
]
