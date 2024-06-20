Class {
	#name : #Permanent,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
Permanent >> canBeReDone [
	^ true
]

{ #category : #'as yet unclassified' }
Permanent >> verifyCanBePlayed: isShipTurn [

	isShipTurn ifFalse: [ Error signal: 'You cannot play this card' ]
]

{ #category : #'as yet unclassified' }
Permanent >> verifyCanBePlayedAtAnyMoment [
	Error signal: 'You cannot play this card' 
	
]
