!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'TS 6/7/2023 15:46:53'!
test01NewCartStartsOutEmpty

	| cart |
	cart := Cart for: nil.
	
	self assert: cart listItems isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'TS 6/8/2023 15:44:19'!
test02ValidItemCanBeAddedToCart

	| cart inventory item |
	item := '0321146530'.
	inventory := Inventory with: { item }.
	cart := Cart for: inventory.

	cart add: 1 of: item.

	self assert: cart listItems includes: item! !

!CartTest methodsFor: 'tests' stamp: 'TS 6/8/2023 15:44:37'!
test03MultipleDifferentValidItemsCanBeAddedToCart

	| cart inventory item1 item2 |
	item1 := '0321146530'.
	item2 := '0117841327'.
	inventory := Inventory with: { item1. item2 }.
	cart := Cart for: inventory.

	cart add: 1 of: item1.
	cart add: 1 of: item2.

	self assert: cart listItems includes: item1.
	self assert: cart listItems includes: item2! !

!CartTest methodsFor: 'tests' stamp: 'TS 6/8/2023 15:44:48'!
test04MultipleOfTheSameValidItemCanBeAddedToCart

	| cart inventory item |
	item := '0321146530'.
	inventory := Inventory with: { item }.
	cart := Cart for: inventory.

	cart add: 4 of: item.

	self assert: 4 equals: (cart listItems occurrencesOf: item)! !

!CartTest methodsFor: 'tests' stamp: 'TS 6/8/2023 15:45:00'!
test05MissingItemCantBeAddedToCart

	| cart inventory item |
	item := '0321146530'.
	inventory := Inventory with: {}.
	cart := Cart for: inventory.

	self
		should: [ cart add: 1 of: item ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cart missingISBNErrorDescription! !

!CartTest methodsFor: 'tests' stamp: 'TS 6/8/2023 15:45:10'!
test06CantAddNonPositiveNumberOfItemsToCart

	| cart inventory item |
	item := '0321146530'.
	inventory := Inventory with: { item }.
	cart := Cart for: inventory.

	self
		should: [ cart add: 0 of: item ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cart nonPositiveItemAmountErrorDescription! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'inventory items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'TS 6/7/2023 15:45:47'!
listItems

	^ items! !


!Cart methodsFor: 'initialization' stamp: 'TS 6/7/2023 16:24:07'!
initializeFor: anInventory 

	items := Bag new.
	inventory := anInventory.! !


!Cart methodsFor: 'validation' stamp: 'TS 6/8/2023 14:47:59'!
assertItemInInventory: anItem

	^ (inventory hasItem: anItem) ifFalse: [ self error: self class missingISBNErrorDescription ]! !

!Cart methodsFor: 'validation' stamp: 'TS 6/8/2023 14:55:47'!
assertValidAmount: anAmount

	^ (anAmount strictlyPositive) ifFalse: [ self error: self class nonPositiveItemAmountErrorDescription ]! !


!Cart methodsFor: 'adding' stamp: 'TS 6/8/2023 14:55:47'!
add: anAmount of: anItem 

	self assertItemInInventory: anItem.
	self assertValidAmount: anAmount.

	items add: anItem withOccurrences: anAmount! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'TS 6/6/2023 16:59:58'!
for: anInventory

	^self new initializeFor: anInventory ! !


!Cart class methodsFor: 'error descriptions' stamp: 'TS 6/8/2023 14:45:53'!
missingISBNErrorDescription

	^ 'El ítem no se encuentra en el inventario'! !

!Cart class methodsFor: 'error descriptions' stamp: 'TS 6/8/2023 14:54:13'!
nonPositiveItemAmountErrorDescription

	^ 'No se puede agregar una cantidad no positiva de ítems al carrito'! !


!classDefinition: #Inventory category: 'TusLibros'!
Object subclass: #Inventory
	instanceVariableNames: 'items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Inventory methodsFor: 'initialization' stamp: 'TS 6/7/2023 16:27:11'!
initializeWith: aCollectionOfItems 

	items := aCollectionOfItems asBag.! !


!Inventory methodsFor: 'stock' stamp: 'TS 6/8/2023 14:44:50'!
hasItem: anItem 

	^ items includes: anItem! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Inventory class' category: 'TusLibros'!
Inventory class
	instanceVariableNames: ''!

!Inventory class methodsFor: 'instance creation' stamp: 'TS 6/6/2023 16:59:15'!
with: aCollectionOfISBNs 

	^self new initializeWith: aCollectionOfISBNs ! !
