!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'SG 6/10/2023 15:31:35'!
test01NewCartsAreCreatedEmpty

	| cart |
	cart :=  testObjectFactory createCart.

	self assert: cart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'SG 6/10/2023 15:31:35'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart :=  testObjectFactory createCart.
	
	self 
		should: [ cart add: testObjectFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'SG 6/10/2023 15:31:35'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart :=  testObjectFactory createCart.
	
	cart add: testObjectFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'SG 6/10/2023 15:31:50'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart :=  testObjectFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'SG 6/10/2023 15:31:56'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart :=  testObjectFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'SG 6/10/2023 15:32:36'!
test06CartRemembersAddedItems

	| cart item |
	
	cart :=  testObjectFactory createCart.
	item := testObjectFactory itemSellByTheStore.
	
	cart add: item.
	self assert: (cart includes: testObjectFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'SG 6/10/2023 15:32:59'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart :=  testObjectFactory createCart.
	
	self deny: (cart includes: testObjectFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'SG 6/10/2023 15:33:26'!
test08CartRemembersTheNumberOfAddedItems

	| cart item |
	
	cart :=  testObjectFactory createCart.
	item := testObjectFactory itemSellByTheStore.
	
	cart add: 2 of: item.
	self assert: (cart occurrencesOf: item) = 2! !


!CartTest methodsFor: 'setUp/tearDown' stamp: 'SG 6/10/2023 15:29:41'!
setUp

	testObjectFactory := StoreTestFactory new! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'SG 6/10/2023 16:36:17'!
test01CannotCheckoutEmptyCart

	| cart cashier |
	cart :=  testObjectFactory createCart.
	
	cashier := testObjectFactory createCashier.
	
	self
		should: [ cashier checkout: cart withCreditCard: ( ( testObjectFactory defaultCreditCard)) ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier cantCheckoutEmptyCartErrorDescription! !

!CashierTest methodsFor: 'tests' stamp: 'SG 6/10/2023 16:36:29'!
test02CheckoutPriceOfCartWithSingleItemIsThatItemsPrice

	| cart cashier |
	cart :=  testObjectFactory createCart.
	cart add: testObjectFactory itemSellByTheStore.
	
	cashier := testObjectFactory createCashier.
	
	self assert: testObjectFactory priceOfItemSoldByStore equals: (cashier checkout: cart withCreditCard: testObjectFactory defaultCreditCard).! !

!CashierTest methodsFor: 'tests' stamp: 'SG 6/10/2023 16:36:36'!
test03CheckoutPriceOfCartWithMultipleOfTheSameItemIsCalculatedCorrectly

	| cart cashier |
	cart :=  testObjectFactory createCart.
	cart add: testObjectFactory itemSellByTheStore.
	cart add: testObjectFactory itemSellByTheStore.
	
	cashier := testObjectFactory createCashier.
	
	self
		assert: 2 * testObjectFactory priceOfItemSoldByStore
		equals: (cashier checkout: cart withCreditCard: testObjectFactory defaultCreditCard).! !

!CashierTest methodsFor: 'tests' stamp: 'SG 6/10/2023 16:36:42'!
test04CheckoutPriceOfCartWithMultipleDifferentItemsIsCalculatedCorrectly

	| cart cashier |
	cart :=  testObjectFactory createCart.
	cart add: testObjectFactory itemSellByTheStore.
	cart add: testObjectFactory otherItemSellByTheStore.
	
	cashier := testObjectFactory createCashier.
	
	self
		assert: testObjectFactory priceOfItemSoldByStore + testObjectFactory priceOfOtherItemSellByTheStore
		equals: (cashier checkout: cart withCreditCard: testObjectFactory defaultCreditCard).! !

!CashierTest methodsFor: 'tests' stamp: 'SG 6/10/2023 16:36:49'!
test05CheckoutFailsIfCreditCardHasExpired

	| cart cashier |
	cart :=  testObjectFactory createCart.
	cart add: testObjectFactory itemSellByTheStore.
	cart add: testObjectFactory otherItemSellByTheStore.
	
	cashier := testObjectFactory createCashier.
	
	self 
		should: [cashier checkout: cart withCreditCard: (testObjectFactory createCreditCardThatExpiresOn: testObjectFactory pastDate) ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier cantCheckoutUsingExpiredCreditCardErrorDescription! !

!CashierTest methodsFor: 'tests' stamp: 'SG 6/10/2023 16:46:15'!
test06CheckoutChargesSaleAmountFromCreditCardUsingMerchantProcessor

	| cart cashier creditCard merchantProcessor price |
	cart :=  testObjectFactory createCart.
	cart add: testObjectFactory itemSellByTheStore.
	cart add: testObjectFactory otherItemSellByTheStore.

	creditCard := testObjectFactory defaultCreditCard.
	merchantProcessor := testObjectFactory defaultMerchantProcessor.
	cashier := testObjectFactory createCashierChargingFrom: merchantProcessor.

	price := cashier checkout: cart withCreditCard: creditCard.

	self assert: (merchantProcessor hasCharged: price from: creditCard)! !

!CashierTest methodsFor: 'tests' stamp: 'SG 6/10/2023 16:46:34'!
test07CheckoutFailsIfMerchantProcessorIsDown

	| cart cashier creditCard merchantProcessor |
	cart :=  testObjectFactory createCart.
	cart add: testObjectFactory itemSellByTheStore.
	cart add: testObjectFactory otherItemSellByTheStore.

	creditCard := testObjectFactory defaultCreditCard.
	merchantProcessor := testObjectFactory defaultMerchantProcessor.
	cashier := testObjectFactory createCashierChargingFrom: merchantProcessor.

	merchantProcessor simulateServiceOutage.

	self
		should: [ cashier checkout: cart withCreditCard: creditCard ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: MerchantProcessor outOfServiceErrorDescription equals: anError messageText.
			self deny: (merchantProcessor hasCharged: creditCard)
		]! !

!CashierTest methodsFor: 'tests' stamp: 'SG 6/10/2023 16:37:22'!
test08CheckoutFailsIfCreditCardDoesntHaveEnoughBalance

	| cart cashier creditCard merchantProcessor |
	cart :=  testObjectFactory createCart.
	cart add: testObjectFactory itemSellByTheStore.
	cart add: testObjectFactory otherItemSellByTheStore.

	creditCard := testObjectFactory defaultCreditCard.
	merchantProcessor := MockMerchantProcessor withBalances: { creditCard -> 5 }.
	cashier := testObjectFactory createCashierChargingFrom: merchantProcessor.

	self
		should: [ cashier checkout: cart withCreditCard: creditCard ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: MerchantProcessor notEnoughBalanceForTransactionErrorDescription equals: anError messageText.
			self deny: (merchantProcessor hasCharged: creditCard)
		]! !

!CashierTest methodsFor: 'tests' stamp: 'SG 6/10/2023 16:55:50'!
test09CashierRegistersSalesOnSalesBook

	| cart cashier salesBook price |
	cart := testObjectFactory createCart.
	cart add: testObjectFactory itemSellByTheStore.
	cart add: testObjectFactory otherItemSellByTheStore.
	
	salesBook := OrderedCollection new.
	cashier := testObjectFactory createCashierRegisteringSalesOn: salesBook.
	
	price := cashier checkout: cart withCreditCard: testObjectFactory defaultCreditCard.

	self assert: salesBook includes: 	price! !


!CashierTest methodsFor: 'setUp/tearDown' stamp: 'SG 6/10/2023 15:39:23'!
setUp

	testObjectFactory := StoreTestFactory new! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'SG 6/10/2023 15:15:39'!
test01CreditCardNumberMustBeAStrictlyPositiveInteger

	
	self
		should: [ CreditCard number: -1 owner: 'HERNAN A WILKINSON' expirationDate: (January of: 2000) ]
		raise: Error - MessageNotUnderstood
		withMessageText: CreditCard invalidCreditCardNumberErrorDescription.
		
	self
		should: [ CreditCard number: 1/2 owner: 'HERNAN A WILKINSON' expirationDate: (January of: 2000) ]
		raise: Error - MessageNotUnderstood
		withMessageText: CreditCard invalidCreditCardNumberErrorDescription! !

!CreditCardTest methodsFor: 'tests' stamp: 'SG 6/10/2023 15:15:39'!
test02CreditCardOwnerMustBeANonEmptyString

	self
		should: [ CreditCard number: 1 owner: '' expirationDate: (January of: 2000) ]
		raise: Error - MessageNotUnderstood
		withMessageText: CreditCard emptyCreditCardOwnerErrorDescription.
! !

!CreditCardTest methodsFor: 'tests' stamp: 'SG 6/10/2023 15:15:39'!
test03CreditCardOwnerCantHaveMoreThan30Characters

	self
		should: [ CreditCard number: 1 owner: (String new: 31 withAll: $a ) expirationDate: (January of: 2000) ]
		raise: Error - MessageNotUnderstood
		withMessageText: CreditCard creditCardOwnerOverCharacterLimitErrorDescription.
! !

!CreditCardTest methodsFor: 'tests' stamp: 'SG 6/10/2023 15:45:08'!
test04CreditCardHasntExpiredBeforeExpirationDate

	| creditCard |
	creditCard :=  CreditCard number: 1234 owner: 'HERNAN A WILKINSON' expirationDate: (January of: 2000).

	self deny: (creditCard hasExpiredBy: (December of: 1999)).! !

!CreditCardTest methodsFor: 'tests' stamp: 'SG 6/10/2023 15:45:50'!
test05CreditCardHasExpiredAfterExpirationDate

	| creditCard |
	creditCard :=  CreditCard number: 1234 owner: 'HERNAN A WILKINSON' expirationDate: (January of: 2000).

	self assert: (creditCard hasExpiredBy: (February of: 2000))! !


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
	instanceVariableNames: 'currentDate merchantProcessor salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'SG 6/10/2023 16:59:41'!
initializeOnDate: aDate chargingFrom: aMerchantProcessor registeringSalesOn: aSalesBook

	currentDate := aDate.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.! !


!Cashier methodsFor: 'validation' stamp: 'SG 6/9/2023 23:28:20'!
assertCreditCardHasNotExpired: aCreditCard

	^ (aCreditCard hasExpiredBy: currentDate) ifTrue: [ self error: self class cantCheckoutUsingExpiredCreditCardErrorDescription ]! !

!Cashier methodsFor: 'validation' stamp: 'SG 6/9/2023 22:21:55'!
assertIsValidCart: aCart

	^ aCart isEmpty ifTrue: [ self error: self class cantCheckoutEmptyCartErrorDescription ]! !


!Cashier methodsFor: 'checkout' stamp: 'SG 6/9/2023 22:33:13'!
calculateTotalPrice: aCart
	
	^ aCart calculateSubtotal! !

!Cashier methodsFor: 'checkout' stamp: 'SG 6/10/2023 17:00:47'!
checkout: aCart withCreditCard: aCreditCard 

	| price |
	self assertIsValidCart: aCart.
	self assertCreditCardHasNotExpired: aCreditCard.

	price := self calculateTotalPrice: aCart.
	
	merchantProcessor charge: price from: aCreditCard.
	salesBook add: price.
	
	^ price! !

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


!Cashier class methodsFor: 'instance creation' stamp: 'SG 6/10/2023 16:58:43'!
onDate: aDate chargingFrom: aMerchantProcessor registeringSalesOn: aSalesBook

	^self new
		initializeOnDate: aDate
		chargingFrom: aMerchantProcessor
		registeringSalesOn: aSalesBook! !


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


!CreditCard methodsFor: 'comparing' stamp: 'SG 6/10/2023 16:38:56'!
= otherCreditCard

	^ number = otherCreditCard number
		and: [ owner = otherCreditCard owner ]
		and: [ expirationDate = otherCreditCard expirationDate ]! !

!CreditCard methodsFor: 'comparing' stamp: 'SG 6/10/2023 16:42:56'!
hash

	^ (number hash bitXor: owner hash) bitXor: expirationDate hash! !


!CreditCard methodsFor: 'accessing' stamp: 'SG 6/10/2023 16:39:44'!
expirationDate

	^ expirationDate! !

!CreditCard methodsFor: 'accessing' stamp: 'SG 6/10/2023 16:39:31'!
number

	^ number! !

!CreditCard methodsFor: 'accessing' stamp: 'SG 6/10/2023 16:39:38'!
owner

	^ owner! !

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


!CreditCard class methodsFor: 'instance creation' stamp: 'SG 6/10/2023 15:15:39'!
number: aCreditCardNumber owner: anOwner expirationDate: aMonthOfYear  

	^self new initializeWithNumber: aCreditCardNumber andOwner: anOwner andExpirationDate: aMonthOfYear! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'charging' stamp: 'SG 6/10/2023 16:16:46'!
charge: anAmount from: aCreditCard 

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: 'TusLibros'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'error descriptions' stamp: 'SG 6/10/2023 16:32:15'!
notEnoughBalanceForTransactionErrorDescription

	^ 'La cuenta no tiene saldo suficiente para la transacción'! !

!MerchantProcessor class methodsFor: 'error descriptions' stamp: 'SG 6/10/2023 16:11:44'!
outOfServiceErrorDescription

	^ 'El Merchant Processor está caído'! !


!classDefinition: #MockMerchantProcessor category: 'TusLibros'!
MerchantProcessor subclass: #MockMerchantProcessor
	instanceVariableNames: 'working creditCardCharges balances'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MockMerchantProcessor methodsFor: 'validation' stamp: 'SG 6/10/2023 17:02:20'!
assertCreditCard: aCreditCard hasBalanceOfAtLeast: anAmount

	(balances at: aCreditCard) < anAmount ifTrue: [ self error: self class notEnoughBalanceForTransactionErrorDescription ].
! !

!MockMerchantProcessor methodsFor: 'validation' stamp: 'SG 6/10/2023 17:01:34'!
assertWorking

	^ working ifFalse: [ self error: self class outOfServiceErrorDescription ]! !


!MockMerchantProcessor methodsFor: 'charging' stamp: 'SG 6/10/2023 17:02:47'!
charge: anAmount from: aCreditCard

	self assertWorking.
	self assertCreditCard: aCreditCard hasBalanceOfAtLeast: anAmount.

	creditCardCharges add: aCreditCard -> anAmount
! !

!MockMerchantProcessor methodsFor: 'charging' stamp: 'SG 6/10/2023 16:47:06'!
hasCharged: aCreditCard 

	^ creditCardCharges anySatisfy: [:anAssociation | anAssociation key = aCreditCard ]! !

!MockMerchantProcessor methodsFor: 'charging' stamp: 'SG 6/10/2023 16:47:06'!
hasCharged: price from: creditCard 

	^ creditCardCharges includes: creditCard -> price! !


!MockMerchantProcessor methodsFor: 'simulation' stamp: 'SG 6/10/2023 16:11:05'!
simulateServiceOutage

	working := false! !


!MockMerchantProcessor methodsFor: 'initialization' stamp: 'SG 6/10/2023 16:47:06'!
initializeWithBalances: aMappingOfCreditCardsToBalances 

	working := true.
	balances := aMappingOfCreditCardsToBalances asDictionary.
	creditCardCharges := OrderedCollection new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MockMerchantProcessor class' category: 'TusLibros'!
MockMerchantProcessor class
	instanceVariableNames: ''!

!MockMerchantProcessor class methodsFor: 'instance creation' stamp: 'SG 6/10/2023 16:30:07'!
withBalances: aMappingOfCreditCardsToBalances

	^self new initializeWithBalances: aMappingOfCreditCardsToBalances! !


!classDefinition: #StoreTestFactory category: 'TusLibros'!
Object subclass: #StoreTestFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestFactory methodsFor: 'catalog' stamp: 'SG 6/10/2023 15:19:19'!
defaultCatalog
	
	^ {
		self itemSellByTheStore -> self priceOfItemSoldByStore.
		self otherItemSellByTheStore -> self priceOfOtherItemSellByTheStore.
	} asDictionary! !

!StoreTestFactory methodsFor: 'catalog' stamp: 'SG 6/10/2023 15:33:52'!
itemNotSellByTheStore
	
	^ 'invalidBook'! !

!StoreTestFactory methodsFor: 'catalog' stamp: 'SG 6/10/2023 15:19:29'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestFactory methodsFor: 'catalog' stamp: 'SG 6/10/2023 15:20:00'!
otherItemSellByTheStore

	^ 'other valid item'! !

!StoreTestFactory methodsFor: 'catalog' stamp: 'SG 6/10/2023 15:19:43'!
priceOfItemSoldByStore

	^ 10! !

!StoreTestFactory methodsFor: 'catalog' stamp: 'SG 6/10/2023 15:20:11'!
priceOfOtherItemSellByTheStore

	^ 5! !


!StoreTestFactory methodsFor: 'cart' stamp: 'SG 6/10/2023 15:21:12'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !


!StoreTestFactory methodsFor: 'credit card' stamp: 'SG 6/10/2023 15:21:36'!
createCreditCardThatExpiresOn: aMonthOfYear

	^ CreditCard number: 1234 owner: 'HERNAN A WILKINSON' expirationDate: aMonthOfYear! !

!StoreTestFactory methodsFor: 'credit card' stamp: 'SG 6/10/2023 16:37:33'!
defaultCreditCard

	^ self createCreditCardThatExpiresOn: self futureDate! !


!StoreTestFactory methodsFor: 'dates' stamp: 'SG 6/10/2023 15:21:53'!
currentDate

	^ January of: 2000! !

!StoreTestFactory methodsFor: 'dates' stamp: 'SG 6/10/2023 15:22:01'!
futureDate

	^ February of: 2000! !

!StoreTestFactory methodsFor: 'dates' stamp: 'SG 6/10/2023 15:22:07'!
pastDate

	^ December of: 1999! !


!StoreTestFactory methodsFor: 'cashier' stamp: 'SG 6/10/2023 16:02:53'!
createCashier

	^ self createCashierChargingFrom: self defaultMerchantProcessor! !

!StoreTestFactory methodsFor: 'cashier' stamp: 'SG 6/10/2023 16:57:45'!
createCashierChargingFrom: aMerchantProcessor

	^ Cashier
		onDate: self currentDate
		chargingFrom: aMerchantProcessor
		registeringSalesOn: OrderedCollection new! !

!StoreTestFactory methodsFor: 'cashier' stamp: 'SG 6/10/2023 16:57:24'!
createCashierRegisteringSalesOn: aSalesBook 

	^ Cashier
		onDate: self currentDate
		chargingFrom: self defaultMerchantProcessor
		registeringSalesOn: aSalesBook! !

!StoreTestFactory methodsFor: 'cashier' stamp: 'SG 6/10/2023 16:35:29'!
defaultMerchantProcessor

	^ MockMerchantProcessor withBalances: { self defaultCreditCard -> 1000 }! !
