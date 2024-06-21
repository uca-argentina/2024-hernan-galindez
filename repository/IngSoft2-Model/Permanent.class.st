Class {
	#name : #Permanent,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Permanent >> verifyCanBePlayed: isShipTurn [

	isShipTurn ifFalse: [ Error signal: 'You can only play this card when its your turn' ]
]
