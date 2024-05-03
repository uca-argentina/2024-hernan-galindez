Class {
	#name : #GameboardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameboardTest >> should: anErrorBlock raise: exceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: exceptionClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
GameboardTest >> testCreateGameboard [

| aGameboard miTablero |

aGameboard := Gameboard numberOfSquares:10.
miTablero := Array  new: 10. 

aGameboard withIndexDo: [ :aSquare :i | self assert: aSquare equals: (miTablero at:i)] 


]

{ #category : #tests }
GameboardTest >> testErrorWhenLengthIsNotGreaterThanZero [ 

	self
	should: [ Gameboard numberOfSquares: -1 ]
	raise: Error 
	withMessage: 'Length must be greater than zero'
]
