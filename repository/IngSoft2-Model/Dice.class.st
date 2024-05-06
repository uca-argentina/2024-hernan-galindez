Class {
	#name : #Dice,
	#superclass : #Array,
	#type : #variable,
	#category : 'IngSoft2-Model'
}

{ #category : #initialization }
Dice >> throw [
^(self collect:[:eachDie | eachDie throw]) sum.
]
