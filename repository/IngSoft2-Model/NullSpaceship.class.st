Class {
	#name : #NullSpaceship,
	#superclass : #Spaceship,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
NullSpaceship >> goBackToStartIn: gameboard [

	^ self
]

{ #category : #accessing }
NullSpaceship >> takeFuel: anAmountOfFuel [

	^ 0
]
