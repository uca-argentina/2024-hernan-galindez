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
GameboardTest >> testBoardCannotBeCreatedWithLengthLessThanZero [

	self
		should: [ Gameboard numberOfSquares: -1 withWormholeAt: 1 and: 2 ]
		raise: Error
		withMessage: 'Length must be greater than zero'
]

{ #category : #tests }
GameboardTest >> testBoardCannotBeCreatedWithWormholeAtLastSquare [

	self
		should: [ Gameboard numberOfSquares: 10 withWormholeAt: 1 and: 10 ]
		raise: Error
		withMessage:
		'Wormholes must be between the first and the second to last square'
]

{ #category : #tests }
GameboardTest >> testBoardCannotBeCreatedWithWormholeAtPositionsGreaterThanBoardSize [

	self
		should: [ Gameboard numberOfSquares: 10 withWormholeAt: 1 and: 12 ]
		raise: Error
		withMessage: 'Wormholes must be between the first and the second to last square'
]
