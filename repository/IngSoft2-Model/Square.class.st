Class {
	#name : #Square,
	#superclass : #Object,
	#instVars : [
		'occupiedBy'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Square class >> newSquare [

^(self new) initialize
]

{ #category : #'as yet unclassified' }
Square >> currentPlayers [
	^occupiedBy.
]

{ #category : #'as yet unclassified' }
Square >> includes: aSpaceship [

^ occupiedBy includes: aSpaceship.


]

{ #category : #'as yet unclassified' }
Square >> initialize [ 

occupiedBy := OrderedCollection new.


]

{ #category : #'as yet unclassified' }
Square >> land: aSpaceship [

occupiedBy add: aSpaceship.


]

{ #category : #'as yet unclassified' }
Square >> remove: aSpaceship [

occupiedBy remove: aSpaceship.

]
