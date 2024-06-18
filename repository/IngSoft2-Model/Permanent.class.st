Class {
	#name : #Permanent,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Permanent >> verifyCanBePlayedAtAnyMoment [
	Error signal: 'You cannot play this card' 
	
]
