Class {
	#name : #SquareTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SquareTest >> testCreationOfSquareWIthSpaceship [

	| aSquare aSpaceship |
	aSquare := NormalSquare create.
	aSpaceship := 'Delepa'.
	aSquare land: aSpaceship.

	self assert: (aSquare currentPlayers includes: aSpaceship)
]

{ #category : #tests }
SquareTest >> testCreationOfSquareWithMoreThanOneSpaceship [

	| aSquare aSpaceship aSpaceship2 |
	aSquare := NormalSquare create.
	aSpaceship := 'Delepa'.
	aSpaceship2 := 'Juan'.
	aSquare land: aSpaceship.
	aSquare land: aSpaceship2.

	self assert: (aSquare currentPlayers includes: aSpaceship).
	self assert: (aSquare currentPlayers includes: aSpaceship2)
]

{ #category : #tests }
SquareTest >> testCreationOfSquareWithNoSpaceship [ 

| aSquare |
aSquare := NormalSquare create.

self assert: (aSquare currentPlayers isEmpty).

]

{ #category : #tests }
SquareTest >> testRemoveSpaceshipFromSquare [

	| aSquare aSpaceship |
	aSquare := NormalSquare create.
	aSpaceship := 'Delepa'.
	aSquare land: aSpaceship.
	aSquare remove: aSpaceship.

	self deny: (aSquare currentPlayers includes: aSpaceship)
]
