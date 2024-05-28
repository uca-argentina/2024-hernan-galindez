Class {
	#name : #LoadedSpaceshipGame,
	#superclass : #SpaceshipGame,
	#type : #variable,
	#category : #'IngSoft2-Tests'
}

{ #category : #initialization }
LoadedSpaceshipGame >> initializeWithPlayers: aCollectionOfPlayers withGameboardLength: aLength withDice: aDiceCollection withLaps: anAmountOfLaps withParsecs: aNumberOfParsecs [

	dice := Dice with: aDiceCollection copy.

	players := aCollectionOfPlayers collect: [ :playerName |
		           Spaceship
			           withName: playerName
			           withFuel: dice maxThrow * 2 ].
	gameboard := LoadedGameboard
		             numberOfSquares: aLength
		             spaceships: players
		             withParsecs: aNumberOfParsecs
		             using: dice.
	numberOfLaps := anAmountOfLaps
]
