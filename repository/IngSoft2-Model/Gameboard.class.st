Class {
	#name : #Gameboard,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'board',
		'spaceships',
		'lapCounter',
		'measurement',
		'measurmentPerSquare',
		'lastSquareLandedOn',
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Gameboard class >> numberOfSquares: aNumberOfSquares spaceships: aSpaceshipCollection withParsecs: aNumberOfParsecs using: aDiceCollection generator: squareGenerator cards: cardCollection [


	self verifyGreaterThanZero: aNumberOfSquares.

	^ self new
		  initializeWithNumberOfSquares: aNumberOfSquares
		  withSpaceships: aSpaceshipCollection
		  withParsecs: aNumberOfParsecs
		  withDice: aDiceCollection
		  withGenerator: squareGenerator

		  withCards: cardCollection
]

{ #category : #accessing }
Gameboard class >> verifyGreaterThanZero: aLength [

	aLength > 0 ifFalse: [
		Error signal: 'Length must be greater than zero' ]
]

{ #category : #accessing }
Gameboard >> applyEffectTo: aSpaceship [

	| currentPosition currentSquare |
	currentPosition := self find: aSpaceship.
	currentSquare := board at: currentPosition.
	currentSquare applyEffectTo: aSpaceship in: self.
	lastSquareLandedOn := currentSquare
]

{ #category : #accessing }
Gameboard >> applyLastEffectTo: aSpaceship [

	lastSquareLandedOn applyEffectTo: aSpaceship in: self
]

{ #category : #accessing }
Gameboard >> find: aTarget [

	^ board
		  detectIndex: [ :square | square includes: aTarget ]
		  ifNone: [ Error signal: 'spaceship not found' ]
]

{ #category : #initialization }
Gameboard >> initializeWithNumberOfSquares: aNumberOfSquares withSpaceships: spaceshipsCollection withParsecs: aNumberOfParsecs withDice: aDiceCollection withGenerator: squareGenerator withCards: cardCollection [


	spaceships := spaceshipsCollection.
	lapCounter := Dictionary
		              newFromKeys: spaceships
		              andValues:
		              (OrderedCollection new: spaceships size withAll: 0).

	measurement := aNumberOfParsecs.
	measurmentPerSquare := Parsecs of:
		                       aNumberOfParsecs // aNumberOfSquares.
	cards := cardCollection.
	board := squareGenerator generateSquares: aNumberOfSquares.
	lastSquareLandedOn := NormalSquare create.
	self setPlayersAtFirstPosition: spaceships
]

{ #category : #accessing }
Gameboard >> lapsCompletedOf: aSpaceship [

	^ lapCounter at: aSpaceship
]

{ #category : #initialization }
Gameboard >> measurementPerSquare [

	^ measurmentPerSquare 
]

{ #category : #accessing }
Gameboard >> move: aSpaceship with: aNumberOfSquares [

	| currentPosition nextPosition currentLaps lapsCompleted |
	currentPosition := self find: aSpaceship.

	nextPosition := currentPosition - 1 + aNumberOfSquares \\ self size
	                + 1.

	currentLaps := lapCounter at: aSpaceship.
	lapsCompleted := currentPosition - 1 + aNumberOfSquares // board size.
	lapCounter at: aSpaceship put: currentLaps + lapsCompleted.


	(board at: currentPosition) leaves: aSpaceship.
	(board at: nextPosition) keep: aSpaceship
]

{ #category : #setting }
Gameboard >> moveAllBack: anAmountOfSquares except: aSpaceship [

	| playersToMove |
	playersToMove := spaceships select: [ :spaceship |
		                 spaceship ~= aSpaceship ].

	playersToMove do: [ :player |
		player move: anAmountOfSquares negated in: self ]
]

{ #category : #setting }
Gameboard >> moveAllToStart [

	spaceships do: [ :spaceship | self moveToStart: spaceship ]
]

{ #category : #setting }
Gameboard >> moveToStart: aSpaceship [

	| currentPosition |
	currentPosition := self find: aSpaceship.
	(board at: 1) keep: aSpaceship.
	(board at: currentPosition) leaves: aSpaceship
]

{ #category : #accessing }
Gameboard >> possibleCards [
	^ cards

]

{ #category : #setting }
Gameboard >> setPlayersAtFirstPosition: players [

	| firstSquare |
	firstSquare := board at:1.

	players do: [ :player | firstSquare keep: player ]
]

{ #category : #accessing }
Gameboard >> size [

	^ board size
]
