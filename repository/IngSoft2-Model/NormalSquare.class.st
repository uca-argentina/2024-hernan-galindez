Class {
	#name : #NormalSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
NormalSquare >> initialize [

	occupiedBy := OrderedCollection new.
]

{ #category : #'add/remove' }
NormalSquare >> land: aSpaceship [

	occupiedBy add: aSpaceship
]

{ #category : #'add/remove' }
NormalSquare >> remove: aSpaceship [

	occupiedBy remove: aSpaceship
]
