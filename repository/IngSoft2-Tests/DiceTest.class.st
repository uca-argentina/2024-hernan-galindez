Class {
	#name : 'DiceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceTest >> testWhenCreateDiceWithThreeLoadedDieAndSixLoadedDieItThrowsNine [

	| aThreeLoadedDie aSixLoadedDie aDice someDice |
	aThreeLoadedDie := LoadedDie of: 3.
	aSixLoadedDie := LoadedDie of: 6.
	someDice := OrderedCollection
		            with: aThreeLoadedDie
		            with: aSixLoadedDie.
	aDice := Dice with: someDice.
	self assert: aDice throw equals: 9
]

{ #category : 'tests' }
DiceTest >> testWhenDiceAreThrownThenItsRollIsTheSumOfEachDie [

	| aDice |
	aDice := Dice with:
		         (OrderedCollection with: (LoadedDie of: 6) with: (LoadedDie of: 3)).
	self assert: aDice throw equals: 9
]
