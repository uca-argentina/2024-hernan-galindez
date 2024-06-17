Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Card >> applyFrom: aSpaceship to: otherSpaceships [

	self subclassResponsibility.
]

{ #category : #operations }
Card >> applyTo: otherSpaceships [

	self subclassResponsibility
]

{ #category : #operations }
Card >> name [

	^ name.
]
