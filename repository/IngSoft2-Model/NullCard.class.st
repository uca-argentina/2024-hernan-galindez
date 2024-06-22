Class {
	#name : #NullCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
NullCard >> verifyCanBePlayed: isShipTurn [

	Error signal: 'There is no card to redo' 
]
