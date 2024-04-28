Class {
	#name : #SpaceshipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
SpaceshipTest >> should: anErrorBlock raise: exceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: exceptionClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
SpaceshipTest >> testBanana [ 

self
	should: [ Spaceship withName: '' ]
	raise: Error
	withMessage: 'Name length must be greater than zero'
]

{ #category : #tests }
SpaceshipTest >> testCreateASpaceshipWithName [
|aSpaceship|

aSpaceship := Spaceship withName: 'A'.

self assert: (aSpaceship name) equals: 'A'
]
