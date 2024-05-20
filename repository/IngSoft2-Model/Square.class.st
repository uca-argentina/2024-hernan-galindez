Class {
	#name : #Square,
	#superclass : #Object,
	#instVars : [
		'occupiedBy'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Square class >> create [

	^ self new initialize
]

{ #category : #accessing }
Square >> includes: aSpaceship [

	^ occupiedBy includes: aSpaceship
]

{ #category : #initialization }
Square >> initialize [

	occupiedBy := OrderedCollection new
]

{ #category : #'add/remove' }
Square >> land: aSpaceship [

	occupiedBy add: aSpaceship
]

{ #category : #'add/remove' }
Square >> remove: aSpaceship [

	occupiedBy remove: aSpaceship
]
