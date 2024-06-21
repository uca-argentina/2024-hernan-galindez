Class {
	#name : #Instant,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
Instant >> canBeReDone [
	^ true
]

{ #category : #removing }
Instant >> removeEffects [
	Error signal: 'An Instantenous card cant be removed'
]

{ #category : #'as yet unclassified' }
Instant >> verifyCanBePlayed: isShipTurn [

	^ true
]
