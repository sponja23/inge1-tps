!classDefinition: #StoreTest category: 'TusLibros'!
TestCase subclass: #StoreTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTest methodsFor: 'support' stamp: 'SG 6/9/2023 22:35:24'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTest methodsFor: 'support' stamp: 'SG 6/9/2023 23:15:39'!
createCreditCardThatExpiresOn: aMonthOfYear

	^ CreditCard withNumber: 1234 owner: 'HERNAN A WILKINSON' expirationDate: aMonthOfYear! !

!StoreTest methodsFor: 'support' stamp: 'SG 6/9/2023 23:16:49'!
currentDate

	^ January of: 2000! !

!StoreTest methodsFor: 'support' stamp: 'SG 6/9/2023 22:30:23'!
defaultCatalog
	
	^ {
		self itemSellByTheStore -> self priceOfItemSoldByStore.
		self otherItemSellByTheStore -> self priceOfOtherItemSellByTheStore.
	} asDictionary! !

!StoreTest methodsFor: 'support' stamp: 'SG 6/9/2023 23:17:10'!
futureDate

	^ February of: 2000! !

!StoreTest methodsFor: 'support' stamp: 'SG 6/9/2023 22:15:40'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTest methodsFor: 'support' stamp: 'SG 6/9/2023 22:15:42'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTest methodsFor: 'support' stamp: 'SG 6/9/2023 22:28:41'!
otherItemSellByTheStore

	^ 'another valid item'! !

!StoreTest methodsFor: 'support' stamp: 'SG 6/9/2023 23:17:00'!
pastDate

	^ December of: 1999! !

!StoreTest methodsFor: 'support' stamp: 'SG 6/9/2023 22:26:22'!
priceOfItemSoldByStore

	^ 10! !

!StoreTest methodsFor: 'support' stamp: 'SG 6/9/2023 22:29:37'!
priceOfOtherItemSellByTheStore

	^ 5! !


!classDefinition: #CartTest category: 'TusLibros'!
StoreTest subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !



!classDefinition: #CashierTest category: 'TusLibros'!
StoreTest subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'SG 6/9/2023 23:20:03'!
test01CannotCheckoutEmptyCart

	| cart cashier |
	cart := self createCart.
	
	cashier := self createCashier.
	
	self
		should: [ cashier checkout: cart withCreditCard: (self createCreditCardThatExpiresOn: self futureDate) ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier cantCheckoutEmptyCartErrorDescription! !

!CashierTest methodsFor: 'tests' stamp: 'SG 6/9/2023 23:20:16'!
test02CheckoutPriceOfCartWithSingleItemIsThatItemsPrice

	| cart cashier |
	cart := self createCart.
	cart add: self itemSellByTheStore.
	
	cashier := self createCashier.
	
	self assert: self priceOfItemSoldByStore equals: (cashier checkout: cart withCreditCard: ((self createCreditCardThatExpiresOn: self futureDate))).! !

!CashierTest methodsFor: 'tests' stamp: 'SG 6/9/2023 23:20:37'!
test03CheckoutPriceOfCartWithMultipleOfTheSameItemIsCalculatedCorrectly

	| cart cashier |
	cart := self createCart.
	cart add: self itemSellByTheStore.
	cart add: self itemSellByTheStore.
	
	cashier := self createCashier.
	
	self
		assert: 2 * self priceOfItemSoldByStore
		equals: (cashier checkout: cart withCreditCard: ((self createCreditCardThatExpiresOn: self futureDate))).! !

!CashierTest methodsFor: 'tests' stamp: 'SG 6/9/2023 23:20:47'!
test04CheckoutPriceOfCartWithMultipleDifferentItemsIsCalculatedCorrectly

	| cart cashier |
	cart := self createCart.
	cart add: self itemSellByTheStore.
	cart add: self otherItemSellByTheStore.
	
	cashier := self createCashier.
	
	self
		assert: self priceOfItemSoldByStore + self priceOfOtherItemSellByTheStore
		equals: (cashier checkout: cart withCreditCard: ((self createCreditCardThatExpiresOn: self futureDate))).! !

!CashierTest methodsFor: 'tests' stamp: 'SG 6/9/2023 23:22:05'!
test05CheckoutFailsIfCreditCardHasExpired

	| cart cashier |
	cart := self createCart.
	cart add: self itemSellByTheStore.
	cart add: self otherItemSellByTheStore.
	
	cashier := self createCashier.
	
	self 
		should: [cashier checkout: cart withCreditCard: (self createCreditCardThatExpiresOn: self pastDate) ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier cantCheckoutUsingExpiredCreditCardErrorDescription! !


!CashierTest methodsFor: 'support' stamp: 'SG 6/9/2023 23:23:23'!
createCashier

	^Cashier onDate: self currentDate! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
StoreTest subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'SG 6/9/2023 23:05:17'!
test01CreditCardNumberMustBeAStrictlyPositiveInteger

	
	self
		should: [ CreditCard withNumber: -1 owner: 'HERNAN A WILKINSON' expirationDate: (January of: 2000) ]
		raise: Error - MessageNotUnderstood
		withMessageText: CreditCard invalidCreditCardNumberErrorDescription.
		
	self
		should: [ CreditCard withNumber: 1/2 owner: 'HERNAN A WILKINSON' expirationDate: (January of: 2000) ]
		raise: Error - MessageNotUnderstood
		withMessageText: CreditCard invalidCreditCardNumberErrorDescription! !

!CreditCardTest methodsFor: 'tests' stamp: 'SG 6/9/2023 23:05:24'!
test02CreditCardOwnerMustBeANonEmptyString

	self
		should: [ CreditCard withNumber: 1 owner: '' expirationDate: (January of: 2000) ]
		raise: Error - MessageNotUnderstood
		withMessageText: CreditCard emptyCreditCardOwnerErrorDescription.
! !

!CreditCardTest methodsFor: 'tests' stamp: 'SG 6/9/2023 23:05:29'!
test03CreditCardOwnerCantHaveMoreThan30Characters

	self
		should: [ CreditCard withNumber: 1 owner: (String new: 31 withAll: $a ) expirationDate: (January of: 2000) ]
		raise: Error - MessageNotUnderstood
		withMessageText: CreditCard creditCardOwnerOverCharacterLimitErrorDescription.
! !

!CreditCardTest methodsFor: 'tests' stamp: 'SG 6/9/2023 23:16:29'!
test04CreditCardHasntExpiredBeforeExpirationDate

	| creditCard |
	creditCard := self createCreditCardThatExpiresOn: self currentDate.

	self deny: (creditCard hasExpiredBy: (self pastDate)).! !

!CreditCardTest methodsFor: 'tests' stamp: 'SG 6/9/2023 23:16:15'!
test05CreditCardHasExpiredAfterExpirationDate

	| creditCard |
	creditCard := self createCreditCardThatExpiresOn: self currentDate.

	self assert: (creditCard hasExpiredBy: (self futureDate)).! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'SG 6/9/2023 22:31:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'SG 6/9/2023 22:13:19'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new! !


!Cart methodsFor: 'queries' stamp: 'SG 6/9/2023 22:32:59'!
calculateSubtotal

	^ items sum: [ :anItem | catalog at: anItem ]! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'SG 6/9/2023 22:30:55'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'SG 6/9/2023 22:12:28'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity! !


!Cart methodsFor: 'enumeration' stamp: 'SG 6/9/2023 22:25:18'!
onItemsDo: aBlock

	items do: aBlock! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'currentDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'SG 6/9/2023 23:26:41'!
initializeOnDate: aDate 

	currentDate := aDate.! !


!Cashier methodsFor: 'validation' stamp: 'SG 6/9/2023 23:28:20'!
assertCreditCardHasNotExpired: aCreditCard

	^ (aCreditCard hasExpiredBy: currentDate) ifTrue: [ self error: self class cantCheckoutUsingExpiredCreditCardErrorDescription ]! !

!Cashier methodsFor: 'validation' stamp: 'SG 6/9/2023 22:21:55'!
assertIsValidCart: aCart

	^ aCart isEmpty ifTrue: [ self error: self class cantCheckoutEmptyCartErrorDescription ]! !


!Cashier methodsFor: 'checkout' stamp: 'SG 6/9/2023 22:33:13'!
calculateTotalPrice: aCart
	
	^ aCart calculateSubtotal! !

!Cashier methodsFor: 'checkout' stamp: 'SG 6/9/2023 23:28:20'!
checkout: aCart withCreditCard: aCreditCard 

	self assertIsValidCart: aCart.
	self assertCreditCardHasNotExpired: aCreditCard.

	^ self calculateTotalPrice: aCart! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error descriptions' stamp: 'SG 6/9/2023 22:18:45'!
cantCheckoutEmptyCartErrorDescription

	^ 'No se puede hacer checkout de un carrito vacío'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'SG 6/9/2023 23:27:14'!
cantCheckoutUsingExpiredCreditCardErrorDescription

	^ 'No se puede hacer checkout utilizando una tarjeta de crédito vencida'! !


!Cashier class methodsFor: 'instance creation' stamp: 'SG 6/9/2023 23:26:25'!
onDate: aDate

	^self new initializeOnDate: aDate! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number owner expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'SG 6/9/2023 22:58:21'!
assertIsValidOwner: anOwner

	anOwner isEmpty ifTrue: [ self error: self class emptyCreditCardOwnerErrorDescription ].
	(anOwner size > 30) ifTrue: [ self error: self class creditCardOwnerOverCharacterLimitErrorDescription ]! !

!CreditCard methodsFor: 'initialization' stamp: 'SG 6/9/2023 23:07:44'!
initializeWithNumber: aCreditCardNumber andOwner: anOwner andExpirationDate: aMonthOfYear  

	self assertIsValidCreditCardNumber: aCreditCardNumber.
	number := aCreditCardNumber.

	self assertIsValidOwner: anOwner.
	owner := anOwner.
	
	expirationDate := aMonthOfYear! !


!CreditCard methodsFor: 'validation' stamp: 'SG 6/9/2023 22:47:49'!
assertIsValidCreditCardNumber: anInteger

	anInteger isInteger ifFalse: [ self error: self class invalidCreditCardNumberErrorDescription ].
	anInteger strictlyPositive ifFalse: [ self error: self class invalidCreditCardNumberErrorDescription ]! !


!CreditCard methodsFor: 'queries' stamp: 'SG 6/9/2023 23:08:09'!
hasExpiredBy: aMonthOfYear

	^ aMonthOfYear >= expirationDate! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error descriptions' stamp: 'SG 6/9/2023 22:57:11'!
creditCardOwnerOverCharacterLimitErrorDescription

	^ 'El nombre del dueño de la tarjeta de crédito debe tener a lo sumo 30 caracteres'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'SG 6/9/2023 22:50:29'!
emptyCreditCardOwnerErrorDescription

	^ 'El dueño de la tarjeta de crédito no puede estar vacío'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'SG 6/9/2023 22:44:54'!
invalidCreditCardNumberErrorDescription

	^ 'El número de la tarjeta de crédito debe ser un entero positivo'! !


!CreditCard class methodsFor: 'instance creation' stamp: 'SG 6/9/2023 23:07:32'!
withNumber: aCreditCardNumber owner: anOwner expirationDate: aMonthOfYear  

	^self new initializeWithNumber: aCreditCardNumber andOwner: anOwner andExpirationDate: aMonthOfYear! !
