Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceTest >> testDiceWithMoreThanOneDie [
|aDice|
aDice:=Dice with:(LoadedDie of:6) with:(LoadedDie of:3).
self assert: aDice size equals:2.
]

{ #category : #tests }
DiceTest >> testWhenDiceAreThrownThenItsRollIsTheSumOfEachDie [ 
|aDice|
aDice:=Dice with:(LoadedDie of:6) with:(LoadedDie of:3).
self assert: (aDice throw) equals:9.
]
