Class {
	#name : #NullSpaceship,
	#superclass : #Spaceship,
	#category : #'IngSoft2-Model'
}

{ #category : #setting }
NullSpaceship >> applyPenaltyIn: gameboard [

	^ self
]

{ #category : #setting }
NullSpaceship >> removeEffect: cardToBeRemoved [
	Error signal: 'This card has not been used on this spaceship'
]

{ #category : #accessing }
NullSpaceship >> takeFuel: anAmountOfFuel [

	^ 0
]
