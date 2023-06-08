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

!CartTest methodsFor: 'tests' stamp: 'TS 6/7/2023 16:27:19'!
test02ValidISBNCanBeAddedToCart

	| cart bookInventory isbn |
	isbn := '0321146530'.
	bookInventory := Inventory with: { isbn }.
	cart := Cart for: bookInventory.

	cart add: 1 of: isbn.

	self assert: cart listItems includes: isbn! !

!CartTest methodsFor: 'tests' stamp: 'TS 6/7/2023 16:27:19'!
test03MultipleDifferentValidISBNsCanBeAddedToCart

	| cart bookInventory isbn1 isbn2 |
	isbn1 := '0321146530'.
	isbn2 := '0117841327'.
	bookInventory := Inventory with: { isbn1. isbn2 }.
	cart := Cart for: bookInventory.

	cart add: 1 of: isbn1.
	cart add: 1 of: isbn2.

	self assert: cart listItems includes: isbn1.
	self assert: cart listItems includes: isbn2! !

!CartTest methodsFor: 'tests' stamp: 'TS 6/8/2023 14:47:04'!
test04MultipleOfTheSameValidISBNCanBeAddedToCart

	| cart bookInventory isbn |
	isbn := '0321146530'.
	bookInventory := Inventory with: { isbn }.
	cart := Cart for: bookInventory.

	cart add: 4 of: isbn.

	self assert: 4 equals: (cart listItems occurrencesOf: isbn)! !

!CartTest methodsFor: 'tests' stamp: 'TS 6/8/2023 14:45:34'!
test05MissingISBNCantBeAddedToCart

	| cart bookInventory isbn |
	isbn := '0321146530'.
	bookInventory := Inventory with: {}.
	cart := Cart for: bookInventory.

	self
		should: [ cart add: 1 of: isbn ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cart missingISBNErrorDescription! !

!CartTest methodsFor: 'tests' stamp: 'TS 6/8/2023 14:55:14'!
test06CantAddNonPositiveNumberOfItemsToCart

	| cart bookInventory isbn |
	isbn := '0321146530'.
	bookInventory := Inventory with: { isbn }.
	cart := Cart for: bookInventory.

	self
		should: [ cart add: 0 of: isbn ]
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
