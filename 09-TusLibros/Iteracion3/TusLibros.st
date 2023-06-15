!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'ARM 6/10/2023 15:05:16'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	debitBehavior := [ :anAmount :aCreditCard | self fail.].

	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'ARM 6/10/2023 14:52:45'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'ARM 6/10/2023 15:15:54'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: self creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = self creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'ARM 6/10/2023 15:16:11'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !

!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #RestInterfaceTest category: 'TusLibros'!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: 'testObjectsFactory debitBehavior currentTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'tests' stamp: 'TS 6/12/2023 21:41:36'!
defaultInterface

	^ RestInterface
		authenticatingWith: self
		acceptingItemsFrom: testObjectsFactory defaultCatalog
		debitingFrom: self
		usingClock: self! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TS 6/12/2023 20:33:04'!
test01ValidUserCreatesEmptyCarts

	| id interface |
	
	interface := self defaultInterface.
	id := interface
		createCartBy: testObjectsFactory defaultUser
		authenticatedWith: testObjectsFactory correctPassword.
	
	self assert: (interface listCartWithId: id) isEmpty! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TS 6/12/2023 20:33:08'!
test02InvalidUserCantCreateCarts

	| interface |
	
	interface := self defaultInterface.

	self
		should: [
			interface
				createCartBy: testObjectsFactory defaultUser
				authenticatedWith: testObjectsFactory incorrectPassword ]
		raise: Error - MessageNotUnderstood
		withMessageText: RestInterface invalidCredentialsErrorDescription! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TS 6/12/2023 20:33:04'!
test03MulitpleCartsCreatedHaveDifferentIDs

	| interface id1 id2 |
	
	interface := self defaultInterface.
	id1 := interface
		createCartBy: testObjectsFactory defaultUser
		authenticatedWith: testObjectsFactory correctPassword.
	id2 := interface
		createCartBy: testObjectsFactory defaultUser
		authenticatedWith: testObjectsFactory correctPassword.
		
	self assert: id1 ~= id2
! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TS 6/12/2023 20:33:04'!
test04ListingCartItemsShowsAddedItems

	| interface id item itemList |
	
	interface := self defaultInterface.
	id := interface
		createCartBy: testObjectsFactory defaultUser
		authenticatedWith: testObjectsFactory correctPassword.

	item := testObjectsFactory itemSellByTheStore.
	interface addToCart: id item: item quantity: 1.
	
	itemList := interface listCartWithId: id.
	self assert: 1 equals: itemList size.
	self assert: itemList includes: item! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TS 6/12/2023 20:33:04'!
test05CannotListCartItemsOfAnInvalidCartID

	| interface |
	
	interface := self defaultInterface.
	
	self
		should: [interface listCartWithId: 1]
		raise: Error - MessageNotUnderstood 
		withMessageText: RestInterface invalidCartIdErrorDescription! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TS 6/12/2023 20:33:04'!
test06DifferentIDsPointToDifferentCarts

	| interface id1 id2 |
	
	interface := self defaultInterface.
	id1 := interface
		createCartBy: testObjectsFactory defaultUser
		authenticatedWith: testObjectsFactory correctPassword.
	id2 := interface
		createCartBy: testObjectsFactory defaultUser
		authenticatedWith: testObjectsFactory correctPassword.

	interface addToCart: id1 item: testObjectsFactory itemSellByTheStore quantity: 1.
	
	self assert: (interface listCartWithId: id2) isEmpty! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TS 6/12/2023 20:38:00'!
test07CannotAddItemsToInvalidID

	| interface |
	
	interface := self defaultInterface.

	self
		should: [ interface addToCart: 0 item: testObjectsFactory itemSellByTheStore quantity: 1 ]
		raise: Error - MessageNotUnderstood
		withMessageText: RestInterface invalidCartIdErrorDescription! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TS 6/12/2023 21:11:00'!
test08CheckoutOfValidIdWorksCorrectly

	| interface id amountDebited creditCardDebitedFrom creditCard |
	
	interface := self defaultInterface.
	id := interface
		createCartBy: testObjectsFactory defaultUser
		authenticatedWith: testObjectsFactory correctPassword.

	interface addToCart: id item: testObjectsFactory itemSellByTheStore quantity: 1.
	
	debitBehavior := [ :anAmount :aCreditCard |
		amountDebited := anAmount.
		creditCardDebitedFrom := aCreditCard.
	].

	creditCard := testObjectsFactory notExpiredCreditCard.

	interface
		checkoutCart: id
		withCreditCard: creditCard number
		ownedBy: creditCard owner
		expiringOn: creditCard expirationDate.

	self assert: testObjectsFactory itemSellByTheStorePrice equals: amountDebited.
	self assert: creditCard equals: creditCardDebitedFrom.
! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TS 6/12/2023 21:14:26'!
test09CannotCheckoutCartUsingInvalidId

	| interface creditCard hasDebited |
	
	interface := self defaultInterface.

	hasDebited := false.
	debitBehavior := [ :anAmount :aCreditCard |
		hasDebited := true.
	].

	creditCard := testObjectsFactory notExpiredCreditCard.
	self
		should: [ interface
				checkoutCart: 0
				withCreditCard: creditCard number
				ownedBy: creditCard owner
				expiringOn: creditCard expirationDate ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: RestInterface invalidCartIdErrorDescription equals: anError messageText.
			self deny: hasDebited
		]
! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TS 6/12/2023 21:15:45'!
test10CannotCheckoutEmptyCart

	| interface creditCard hasDebited id |
	
	interface := self defaultInterface.
	id := interface
		createCartBy: testObjectsFactory defaultUser
		authenticatedWith: testObjectsFactory correctPassword.

	hasDebited := false.
	debitBehavior := [ :anAmount :aCreditCard |
		hasDebited := true.
	].

	creditCard := testObjectsFactory notExpiredCreditCard.
	self
		should: [ interface
				checkoutCart: id
				withCreditCard: creditCard number
				ownedBy: creditCard owner
				expiringOn: creditCard expirationDate ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: RestInterface cannotCheckoutEmptyCartErrorDescription equals: anError messageText.
			self deny: hasDebited
		]
! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TS 6/12/2023 21:28:41'!
test11SuccessfulCheckoutRemovesTheCartFromInterface

	| interface creditCard id |
	
	interface := self defaultInterface.
	id := interface
		createCartBy: testObjectsFactory defaultUser
		authenticatedWith: testObjectsFactory correctPassword.
	interface addToCart: id item: testObjectsFactory itemSellByTheStore quantity: 1.

	creditCard := testObjectsFactory notExpiredCreditCard.
	interface
		checkoutCart: id
		withCreditCard: creditCard number
		ownedBy: creditCard owner
		expiringOn: creditCard expirationDate.

	self
		should: [ interface listCartWithId: id ]
		raise: Error - MessageNotUnderstood
		withMessageText: RestInterface invalidCartIdErrorDescription
! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TS 6/15/2023 14:40:02'!
test12CannotAccessCartAfterTimeout

	| interface id |
	
	interface := self defaultInterface.
	id := interface
		createCartBy: testObjectsFactory defaultUser
		authenticatedWith: testObjectsFactory correctPassword.
	interface addToCart: id item: testObjectsFactory itemSellByTheStore quantity: 1.

	currentTime := currentTime + RestInterface timeoutDuration.
	
	self
		should: [ interface listCartWithId: id ]
		raise: Error - MessageNotUnderstood
		withMessageText: RestInterface cannotAccessCartAfterTimeoutErrorDescription! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TS 6/12/2023 21:51:04'!
test13CanAccessCartIfTimeoutHasntPassedSinceLastAccess

	| interface id halfTimeoutDuration |
	
	interface := self defaultInterface.
	id := interface
		createCartBy: testObjectsFactory defaultUser
		authenticatedWith: testObjectsFactory correctPassword.
	interface addToCart: id item: testObjectsFactory itemSellByTheStore quantity: 1.

	halfTimeoutDuration := RestInterface timeoutDuration / 2.
	currentTime := currentTime + halfTimeoutDuration.
	
	interface addToCart: id item: testObjectsFactory itemSellByTheStore quantity: 1.	
	
	currentTime := currentTime + halfTimeoutDuration.
	
	self
		shouldnt: [ interface listCartWithId: id ]
		raise: Error! !


!RestInterfaceTest methodsFor: 'authentication system protocol' stamp: 'TS 6/12/2023 19:51:00'!
canUserAccess: aUser withPassword: aPassword 

	^ aUser = testObjectsFactory defaultUser and: aPassword = testObjectsFactory correctPassword! !


!RestInterfaceTest methodsFor: 'setup' stamp: 'TS 6/12/2023 21:48:14'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	currentTime := testObjectsFactory today.
	debitBehavior := [ :anAmount :aCreditCard | ].! !


!RestInterfaceTest methodsFor: 'clock protocol' stamp: 'TS 6/12/2023 21:48:21'!
getTime

	^ currentTime! !


!RestInterfaceTest methodsFor: 'merchant processor protocol' stamp: 'TS 6/12/2023 20:39:36'!
debit: anAmount from: aCreditCard 

	^ debitBehavior value: anAmount value: aCreditCard! !


!classDefinition: #AccessTimeoutDictionary category: 'TusLibros'!
Object subclass: #AccessTimeoutDictionary
	instanceVariableNames: 'clock timeoutDuration values lastAccessTimes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AccessTimeoutDictionary methodsFor: 'initialization' stamp: 'TS 6/15/2023 14:25:12'!
initializeWithClock: aClock andTimeoutDuration: aDuration 

	clock := aClock.
	timeoutDuration := aDuration.

	values := Dictionary new.
	lastAccessTimes := Dictionary new.! !


!AccessTimeoutDictionary methodsFor: 'accessing' stamp: 'TS 6/15/2023 14:38:50'!
at: aKey ifAbsent: absentBlock ifTimeout: timeoutBlock

	(self hasTimeoutPassedFor: aKey ifAbsent: absentBlock) ifTrue: timeoutBlock	.

	self updateLastAccessFor: aKey.

	^ values at: aKey! !

!AccessTimeoutDictionary methodsFor: 'accessing' stamp: 'TS 6/15/2023 14:38:32'!
at: aKey put: aValue

	values at: aKey put: aValue.
	self updateLastAccessFor: aKey
! !

!AccessTimeoutDictionary methodsFor: 'accessing' stamp: 'TS 6/15/2023 14:39:01'!
hasTimeoutPassedFor: aKey ifAbsent: absentBlock

	^ clock getTime >= ((lastAccessTimes at: aKey ifAbsent: absentBlock) + timeoutDuration)! !

!AccessTimeoutDictionary methodsFor: 'accessing' stamp: 'TS 6/15/2023 14:38:32'!
updateLastAccessFor: aKey

	^ lastAccessTimes at: aKey put: clock getTime! !


!AccessTimeoutDictionary methodsFor: 'removing' stamp: 'TS 6/15/2023 14:33:05'!
removeKey: aKey 

	values removeKey: aKey.
	lastAccessTimes removeKey: aKey! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccessTimeoutDictionary class' category: 'TusLibros'!
AccessTimeoutDictionary class
	instanceVariableNames: ''!

!AccessTimeoutDictionary class methodsFor: 'instance creation' stamp: 'TS 6/15/2023 14:23:20'!
withClock: aClock andTimeoutDuration: aDuration 

	^self new initializeWithClock: aClock andTimeoutDuration: aDuration ! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:04'!
catalog
	
	^ catalog! !

!Cart methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:05'!
itemsDo: aBlock
	
	^items do: aBlock ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'total' stamp: 'ARM 6/10/2023 15:44:10'!
total

	^ items sum: [ :anItem | catalog at: anItem ifAbsent: [self shouldNotHappenBecause: #assertIsValidItem:] ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:42'!
initializeToCheckout: aCart charging: aCreditCard registeringOn: aSalesBook
	
	cart := aCart.
	creditCart := aCreditCard.
	salesBook := aSalesBook! !


!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'ARM 6/10/2023 14:50:24'!
createSale

	^ total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'TS 6/12/2023 21:10:15'!
= anotherCreditCard

	"El número debería ser un identificador único de la tarjeta de crédito"
	^ number = anotherCreditCard number! !

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

!CreditCard methodsFor: 'initialization' stamp: 'TS 6/12/2023 20:55:53'!
initializeWithNumber: aCreditCardNumber ownedBy: anOwner expiringOn: aMonth 

	number := aCreditCardNumber.
	owner := anOwner.
	expiration := aMonth.! !


!CreditCard methodsFor: 'accessing' stamp: 'TS 6/12/2023 20:54:02'!
expirationDate

	^ expiration! !

!CreditCard methodsFor: 'accessing' stamp: 'TS 6/12/2023 20:53:36'!
number

	^ number! !

!CreditCard methodsFor: 'accessing' stamp: 'TS 6/12/2023 20:53:50'!
owner

	^ owner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !

!CreditCard class methodsFor: 'instance creation' stamp: 'TS 6/12/2023 20:55:19'!
number: aCreditCardNumber owner: anOwner expiringOn: aMonth 
	
	^self new initializeWithNumber: aCreditCardNumber ownedBy: anOwner expiringOn: aMonth! !


!classDefinition: #RestInterface category: 'TusLibros'!
Object subclass: #RestInterface
	instanceVariableNames: 'authenticationSystem nextId idToCartMapping catalog merchantProcessor salesBook idToLastAccessTimeMapping clock carts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'initialization' stamp: 'TS 6/15/2023 14:22:59'!
initializeAuthenticatingWith: anAuthenticationSystem acceptingItemsFrom: aCatalog debitingFrom: aMerchantProcessor usingClock: aClock   

	authenticationSystem := anAuthenticationSystem.
	merchantProcessor := aMerchantProcessor.
	catalog := aCatalog.
	clock := aClock.

	nextId := 0.
	carts := AccessTimeoutDictionary withClock: aClock andTimeoutDuration: self class timeoutDuration.
	salesBook := OrderedCollection new! !


!RestInterface methodsFor: 'cart' stamp: 'TS 6/12/2023 20:38:31'!
addToCart: aCartId item: anItem quantity: anAmount 

	(self getCartWithId: aCartId) add: anAmount of: anItem! !

!RestInterface methodsFor: 'cart' stamp: 'TS 6/15/2023 14:19:58'!
createCartBy: aUser authenticatedWith: aPassword

	| id |
	self assertThat: aUser canAuthenticateUsing: aPassword.

	id := self getNextId.

	carts at: id put: self createNewCart.

	^ id! !

!RestInterface methodsFor: 'cart' stamp: 'TS 6/12/2023 20:31:55'!
listCartWithId: aCartId
	
	| itemList |
	
	itemList := OrderedCollection new.

	(self getCartWithId: aCartId) itemsDo: [ :anItem | itemList add: anItem ].
	
	^ itemList! !


!RestInterface methodsFor: 'cart - private' stamp: 'TS 6/12/2023 20:28:52'!
createNewCart

	^ Cart acceptingItemsOf: catalog! !

!RestInterface methodsFor: 'cart - private' stamp: 'TS 6/15/2023 14:40:02'!
getCartWithId: aCartId

	^ carts
		at: aCartId
		ifAbsent: [ self error: self class invalidCartIdErrorDescription ]
		ifTimeout: [ self error: self class cannotAccessCartAfterTimeoutErrorDescription ].

! !

!RestInterface methodsFor: 'cart - private' stamp: 'TS 6/12/2023 19:35:41'!
getNextId

	| id |

	id := nextId.
	nextId := nextId + 1.

	^ id! !

!RestInterface methodsFor: 'cart - private' stamp: 'TS 6/15/2023 14:18:47'!
removeCartWithId: aCartId

	^ carts removeKey: aCartId! !


!RestInterface methodsFor: 'validation' stamp: 'TS 6/15/2023 14:22:09'!
assertThat: aUser canAuthenticateUsing: aPassword

	^ (authenticationSystem canUserAccess: aUser withPassword: aPassword)
		ifFalse: [ self error: self class invalidCredentialsErrorDescription ]! !


!RestInterface methodsFor: 'checkout' stamp: 'TS 6/12/2023 21:47:21'!
checkoutCart: aCartId withCreditCard: creditCardNumber ownedBy: creditCardOwner expiringOn: creditCardExpirationDate 

	(Cashier 
		toCheckout: (self getCartWithId: aCartId)
		charging: (CreditCard number: creditCardNumber owner: creditCardOwner expiringOn: creditCardExpirationDate)
		throught: merchantProcessor
		on: self currentTime
		registeringOn: salesBook) checkOut.

	self removeCartWithId: aCartId! !


!RestInterface methodsFor: 'time' stamp: 'TS 6/12/2023 21:47:50'!
currentTime

	^ clock getTime! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: 'TusLibros'!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'instance creation' stamp: 'TS 6/12/2023 21:41:24'!
authenticatingWith: anAuthenticationSystem acceptingItemsFrom: aCatalog debitingFrom: aMerchantProcessor usingClock: aClock    

	^ self new
		initializeAuthenticatingWith: anAuthenticationSystem
		acceptingItemsFrom: aCatalog
		debitingFrom: aMerchantProcessor
		usingClock: aClock! !


!RestInterface class methodsFor: 'error descriptions' stamp: 'TS 6/15/2023 14:40:02'!
cannotAccessCartAfterTimeoutErrorDescription

	^ 'No se puede acceder al carro después del timeout'! !

!RestInterface class methodsFor: 'error descriptions' stamp: 'TS 6/12/2023 21:18:37'!
cannotCheckoutEmptyCartErrorDescription

	^ Cashier cartCanNotBeEmptyErrorMessage! !

!RestInterface class methodsFor: 'error descriptions' stamp: 'TS 6/12/2023 20:04:38'!
invalidCartIdErrorDescription
	
	^ 'La ID del carro no es válida'! !

!RestInterface class methodsFor: 'error descriptions' stamp: 'TS 6/12/2023 19:20:58'!
invalidCredentialsErrorDescription

	 ^ 'Las credenciales utilizadas son inválidas'! !


!RestInterface class methodsFor: 'timeout' stamp: 'TS 6/12/2023 21:34:16'!
timeoutDuration

	^ Duration minutes: 30! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'TS 6/12/2023 20:56:50'!
expiredCreditCard
	
	^ CreditCard
		number: 1000
		owner: 'HERNAN A WILKINSON'
		expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'TS 6/12/2023 20:56:58'!
notExpiredCreditCard
	
	^ CreditCard
		number: 1000
		owner: 'HERNAN A WILKINSON'
		expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'ARM 6/10/2023 15:34:30'!
initialize

	today := DateAndTime year: 2010 day: 365 hour: 0 minute: 0 second: 0! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'interface' stamp: 'TS 6/12/2023 19:23:46'!
correctPassword

	^ '1234'! !

!StoreTestObjectsFactory methodsFor: 'interface' stamp: 'TS 6/12/2023 19:23:34'!
defaultUser

	^ 'Hernán'! !

!StoreTestObjectsFactory methodsFor: 'interface' stamp: 'TS 6/12/2023 19:24:57'!
incorrectPassword
	
	^ '4321'! !
