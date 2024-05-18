Class {
	#name : #NormalSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #'add/remove' }
NormalSquare >> land: aSpaceship [

	occupiedBy add: aSpaceship
]

{ #category : #'add/remove' }
NormalSquare >> remove: aSpaceship [

	occupiedBy remove: aSpaceship
]
