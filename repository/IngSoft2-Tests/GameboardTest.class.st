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
		should: [
			Gameboard
				numberOfSquares: -1
				spaceships: #( 'Pancho' ) asOrderedCollection
				withParsecs: 100
				using: (Dice with: { (Die of: 4) })
				generator:
				(SpecificGenerator with: { (NormalSquare create -> 1) }) ]
		raise: Error
		withMessage: 'Length must be greater than zero'
]
