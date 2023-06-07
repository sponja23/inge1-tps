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

!CartTest methodsFor: 'tests' stamp: 'TS 6/7/2023 16:27:19'!
test04MultipleOfTheSameValidISBNCanBeAddedToCart

	| cart bookInventory isbn |
	isbn := '0321146530'.
	bookInventory := Inventory with: { isbn. isbn. isbn. isbn }.
	cart := Cart for: bookInventory.

	cart add: 4 of: isbn.

	self assert: 4 equals: (cart listItems occurrencesOf: isbn)! !

!CartTest methodsFor: 'tests' stamp: 'TS 6/7/2023 16:27:19'!
test05MissingISBNCantBeAddedToCart

	| cart bookInventory isbn |
	isbn := '0321146530'.
	bookInventory := Inventory with: {}.
	cart := Cart for: bookInventory.

	self
		should: [ cart add: 1 of: isbn ]
		raise: Error - MessageNotUnderstood
		withMessageText: Inventory missingISBNErrorDescription! !

!CartTest methodsFor: 'tests' stamp: 'TS 6/7/2023 16:27:19'!
test06ISBNWithoutEnoughStockCantBeAddedToCart

	| cart bookInventory isbn |
	isbn := '0321146530'.
	bookInventory := Inventory with: { isbn }.
	cart := Cart for: bookInventory.

	self
		should: [ cart add: 2 of: isbn ]
		raise: Error - MessageNotUnderstood
		withMessageText: Inventory notEnoughStockErrorDescription! !


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


!Cart methodsFor: 'adding' stamp: 'TS 6/7/2023 16:21:42'!
add: anAmount of: anItem 

	inventory assertHas: anAmount of: anItem.

	items add: anItem withOccurrences: anAmount! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'TS 6/6/2023 16:59:58'!
for: anInventory

	^self new initializeFor: anInventory ! !



!classDefinition: #Inventory category: 'TusLibros'!
Object subclass: #Inventory
	instanceVariableNames: 'items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Inventory methodsFor: 'initialization' stamp: 'TS 6/7/2023 16:27:11'!
initializeWith: aCollectionOfItems 

	items := aCollectionOfItems asBag.! !


!Inventory methodsFor: 'stock' stamp: 'TS 6/7/2023 16:23:21'!
assertHas: anAmount of: anItem 

	(items includes: anItem) ifFalse: [ self error: self class missingISBNErrorDescription ].
	((items occurrencesOf: anItem) >= anAmount) ifFalse: [ self error: self class notEnoughStockErrorDescription ]! !

!Inventory methodsFor: 'stock' stamp: 'TS 6/7/2023 16:16:03'!
hasStockOf: anItem 

	^ items includes: anItem! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Inventory class' category: 'TusLibros'!
Inventory class
	instanceVariableNames: ''!

!Inventory class methodsFor: 'instance creation' stamp: 'TS 6/6/2023 16:59:15'!
with: aCollectionOfISBNs 

	^self new initializeWith: aCollectionOfISBNs ! !


!Inventory class methodsFor: 'error descriptions' stamp: 'TS 6/7/2023 16:17:56'!
missingISBNErrorDescription

	^ 'El ISBN no se encuentra en el inventario'! !

!Inventory class methodsFor: 'error descriptions' stamp: 'TS 6/7/2023 16:20:33'!
notEnoughStockErrorDescription

	^ 'No hay suficiente stock del ítem deseado'! !
