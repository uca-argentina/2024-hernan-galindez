Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Spaceship class >> verifyLengthGreaterThanZero: aName [

aName isEmpty ifTrue: [ Error signal: 'Name length must be greater than zero' ]
]

{ #category : #'instance creation' }
Spaceship class >> withName: aName [

self verifyLengthGreaterThanZero: aName.
^(self new) initializeWithName: aName
]

{ #category : #initialization }
Spaceship >> initializeWithName: aName [

name := aName
]

{ #category : #initialization }
Spaceship >> name [

^name
]
