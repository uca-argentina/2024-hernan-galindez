Class {
	#name : #SpaceshipGame,
	#superclass : #Object,
	#instVars : [
		'players'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'accesing - defaults' }
SpaceshipGame class >> withPlayers: aSpaceship [ 
	^ (self new) initializeWithPlayers: aSpaceship 
]

{ #category : #initialization }
SpaceshipGame >> initializeWithPlayers: aSpaceship [

players := aSpaceship 
 
]

{ #category : #testing }
SpaceshipGame >> isOver [
	^ false
]

{ #category : #accessing }
SpaceshipGame >> players [
	^ players
]
