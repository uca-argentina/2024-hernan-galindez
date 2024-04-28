Class {
	#name : #SpaceshipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

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
