!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'setUp/tearDown' stamp: 'SG 5/15/2023 21:24:49'!
accountWithSingleDepositOf: anAmount

	^ self accountWithTransactions: {Deposit for: anAmount }! !

!PortfolioTest methodsFor: 'setUp/tearDown' stamp: 'SG 5/15/2023 21:23:46'!
accountWithTransactions: aCollectionOfTransactions

	| account |
	account := ReceptiveAccount new.
	
	aCollectionOfTransactions do: [:anTransaction | account register: anTransaction].
	
	^account.
	! !

!PortfolioTest methodsFor: 'setUp/tearDown' stamp: 'TS 5/21/2023 20:07:10'!
portfolioWithAssets: aCollectionOfAssets

	| portfolio |
	portfolio := Portfolio new.
	
	aCollectionOfAssets do: [:anAsset | portfolio addAsset: anAsset].
	
	^portfolio.
	! !


!PortfolioTest methodsFor: 'tests-portfolio hierarchy' stamp: 'TS 5/21/2023 20:26:46'!
test10PortfolioCantHaveItselfAsAnAsset

	| portfolio |

	portfolio := Portfolio new.
	
	self
		should: [ portfolio addAsset: portfolio ]
		raise: Error - MessageNotUnderstood
		withMessageText: Portfolio cantHaveRepeatedAssets! !

!PortfolioTest methodsFor: 'tests-portfolio hierarchy' stamp: 'TS 5/21/2023 20:48:47'!
test11PortfolioCantHaveAssetsThatItAlreadyHasAsDirectChildren

	| portfolio account |

	account := ReceptiveAccount new.
	portfolio := self portfolioWithAssets: { account }.
	
	self
		should: [ portfolio addAsset: account ]
		raise: Error - MessageNotUnderstood
		withMessageText: Portfolio cantHaveRepeatedAssets! !

!PortfolioTest methodsFor: 'tests-portfolio hierarchy' stamp: 'TS 5/21/2023 20:47:57'!
test12PortfolioCantHaveAssetsThatAreAlreadyInItsDirectChildrenAssets

	| account childPortfolio parentPortfolio |

	account := ReceptiveAccount new.
	childPortfolio := self portfolioWithAssets: { account }.
	parentPortfolio := self portfolioWithAssets: { childPortfolio }.
	
	self
		should: [ parentPortfolio addAsset: account ]
		raise: Error - MessageNotUnderstood
		withMessageText: Portfolio cantHaveRepeatedAssets! !

!PortfolioTest methodsFor: 'tests-portfolio hierarchy' stamp: 'TS 5/21/2023 20:55:04'!
test13PortfolioCantHaveAssetsThatAreAlreadyInItsDescendantAssets

	| account childPortfolio parentPortfolio grandchildPortfolio |

	account := ReceptiveAccount new.
	grandchildPortfolio := self portfolioWithAssets: { account }.
	childPortfolio := self portfolioWithAssets: { grandchildPortfolio }.
	parentPortfolio := self portfolioWithAssets: { childPortfolio }.
	
	self
		should: [ parentPortfolio addAsset: account ]
		raise: Error - MessageNotUnderstood
		withMessageText: Portfolio cantHaveRepeatedAssets! !

!PortfolioTest methodsFor: 'tests-portfolio hierarchy' stamp: 'TS 5/21/2023 22:56:27'!
test14PortfolioCantHaveAnAncestorAsAnAsset

	| childPortfolio parentPortfolio |

	childPortfolio := Portfolio new.
	parentPortfolio := self portfolioWithAssets: { childPortfolio }.
	
	self
		should: [ childPortfolio addAsset: parentPortfolio ]
		raise: Error - MessageNotUnderstood
		withMessageText: Portfolio cantHaveRepeatedAssets! !

!PortfolioTest methodsFor: 'tests-portfolio hierarchy' stamp: 'TS 5/21/2023 23:21:30'!
test15PortfolioWithSingleParentCantHaveASiblingAsAnAsset

	| parentPortfolio portfolio siblingPortfolio |

	portfolio := Portfolio new.
	siblingPortfolio := Portfolio new.
	parentPortfolio := self portfolioWithAssets: { portfolio. siblingPortfolio }.
	
	self
		should: [ portfolio addAsset: siblingPortfolio ]
		raise: Error - MessageNotUnderstood
		withMessageText: Portfolio cantHaveRepeatedAssets! !

!PortfolioTest methodsFor: 'tests-portfolio hierarchy' stamp: 'TS 5/21/2023 23:21:39'!
test16PortfolioWithMultipleParentsCantHaveASiblingAsAnAsset

	| portfolio siblingPortfolio parentPortfolio1 parentPortfolio2 |

	portfolio := Portfolio new.
	siblingPortfolio := Portfolio new.
	parentPortfolio1 := self portfolioWithAssets: { portfolio. siblingPortfolio }.
	parentPortfolio2 := self portfolioWithAssets: { portfolio }.
	
	self
		should: [ portfolio addAsset: siblingPortfolio ]
		raise: Error - MessageNotUnderstood
		withMessageText: Portfolio cantHaveRepeatedAssets! !

!PortfolioTest methodsFor: 'tests-portfolio hierarchy' stamp: 'TS 5/21/2023 23:35:08'!
test17PortfolioCantHaveDescendantOfAnAncestorAsAnAsset

	| portfolio cousinPortfolio grandparentPortfolio parentPortfolio unclePortfolio |

	portfolio := Portfolio new.
	parentPortfolio := self portfolioWithAssets: { portfolio }.
	cousinPortfolio := Portfolio new.
	unclePortfolio := self portfolioWithAssets: { cousinPortfolio }.
	grandparentPortfolio := self portfolioWithAssets: { parentPortfolio. unclePortfolio }.
	
	self
		should: [ portfolio addAsset: cousinPortfolio ]
		raise: Error - MessageNotUnderstood
		withMessageText: Portfolio cantHaveRepeatedAssets! !

!PortfolioTest methodsFor: 'tests-portfolio hierarchy' stamp: 'TS 5/21/2023 23:52:32'!
test18PortfolioCantAddPortfolioThatContainsOneOfItsChildren

	| portfolio account childPortfolio |

	account := ReceptiveAccount new.
	portfolio := self portfolioWithAssets: { account }.
	childPortfolio := self portfolioWithAssets: { account }.
	
	self
		should: [ portfolio addAsset: childPortfolio ]
		raise: Error - MessageNotUnderstood
		withMessageText: Portfolio cantHaveRepeatedAssets! !

!PortfolioTest methodsFor: 'tests-portfolio hierarchy' stamp: 'TS 5/21/2023 23:57:51'!
test19PortfolioCantAddPortfolioThatContainsOneOfItsDescendants

	| portfolio account childPortfolio1 childPortfolio2 |

	account := ReceptiveAccount new.
	childPortfolio1 := self portfolioWithAssets: { account }.
	portfolio := self portfolioWithAssets: { childPortfolio1 }.
	
	childPortfolio2 := self portfolioWithAssets: { account }.
	
	self
		should: [ portfolio addAsset: childPortfolio2 ]
		raise: Error - MessageNotUnderstood
		withMessageText: Portfolio cantHaveRepeatedAssets! !

!PortfolioTest methodsFor: 'tests-portfolio hierarchy' stamp: 'TS 5/22/2023 00:26:26'!
test20PortfolioCantAddPortfolioThatHasASiblingAsADescendant

	| portfolio otherParentOfSibling parentPortfolio sibling |

	sibling := ReceptiveAccount new.
	portfolio := Portfolio new.
	parentPortfolio := self portfolioWithAssets: { portfolio. sibling }.
	otherParentOfSibling := self portfolioWithAssets: { sibling }.
	
	self
		should: [ portfolio addAsset: otherParentOfSibling ]
		raise: Error - MessageNotUnderstood
		withMessageText: Portfolio cantHaveRepeatedAssets! !


!PortfolioTest methodsFor: 'tests-transactions' stamp: 'SG 5/15/2023 21:14:28'!
test05PortfolioWithNoAccountsHasNoTransactions

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: portfolio transactions isEmpty.! !

!PortfolioTest methodsFor: 'tests-transactions' stamp: 'TS 5/21/2023 20:06:59'!
test06PortfolioWithAccountsKnowsTheirTransactions

	| portfolio account1 account2 |
	
	account1 := self accountWithTransactions: { Deposit for: 50. Withdraw for: 20}.	
	account2 := self accountWithTransactions: { Deposit for: 40. Withdraw for: 10}.
	
	portfolio := self portfolioWithAssets: {account1. account2}.
	
	self assert: (account1 transactions, account2 transactions) asSet equals: portfolio transactions.! !

!PortfolioTest methodsFor: 'tests-transactions' stamp: 'TS 5/21/2023 20:08:20'!
test07PortfolioWithChildrenPortfoliosKnowsTheirTransactions

	| childPortfolio1 childPortfolio2 parentPortfolio |
	
	childPortfolio1 := self portfolioWithAssets: {
		self accountWithTransactions: { Deposit for: 50. Withdraw for: 20}.
		self accountWithTransactions: { Deposit for: 40. Withdraw for: 10}
	}.

	childPortfolio2 := self portfolioWithAssets: {
		self accountWithTransactions: { Deposit for: 10. Withdraw for: 5}.
		self accountWithTransactions: { Deposit for: 80. Withdraw for: 20}
	}.
	
	parentPortfolio := self portfolioWithAssets: { childPortfolio1. childPortfolio2 }.

	self assert: (childPortfolio1 transactions union: childPortfolio2 transactions) equals: parentPortfolio transactions.! !

!PortfolioTest methodsFor: 'tests-transactions' stamp: 'TS 5/21/2023 20:11:34'!
test08PortfolioWithNoAssetsHasNoTransactionsRegistered

	| portfolio transaction |

	portfolio := Portfolio new.
	transaction := Deposit for: 20.

	self deny: (portfolio hasRegistered: transaction)! !

!PortfolioTest methodsFor: 'tests-transactions' stamp: 'TS 5/21/2023 20:18:52'!
test09PortfolioWithAssetsHasTheirTransactionRegistered

	| portfolio transaction1 transaction2 |

	transaction1 := Deposit for: 20.
	transaction2 := Withdraw for: 10.
	
	portfolio := self portfolioWithAssets: {
		self accountWithTransactions: { transaction1. transaction2 }
	}.

	self assert: (portfolio hasRegistered: transaction1).
	self assert: (portfolio hasRegistered: transaction2)! !


!PortfolioTest methodsFor: 'tests-balance' stamp: 'SG 5/15/2023 20:14:32'!
test01PortfolioWithNoAccountsHasZeroBalance

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: 0 equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests-balance' stamp: 'TS 5/21/2023 20:06:59'!
test02PortfolioWithSingleAccountHasSameBalanceAsTheAccount

	| portfolio |
	
	portfolio := self portfolioWithAssets: {self accountWithSingleDepositOf: 50}.
	self assert: 50 equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests-balance' stamp: 'TS 5/21/2023 20:06:59'!
test03PortfolioWithMultipleAccountsHasBalanceEqualToTheSumOfTheAccountBalances

	| portfolio |
	
	portfolio := self portfolioWithAssets: {
	
		self accountWithSingleDepositOf: 50.
		self accountWithSingleDepositOf: 100
		
		}.
	
	self assert: 150 equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests-balance' stamp: 'TS 5/21/2023 20:08:41'!
test04PortfolioWithChildrenPortfoliosHasTheSumOfTheirBalancesAsItsBalance

	| parentPortfolio childPorfolio |
	
	childPorfolio := self portfolioWithAssets: {
		self accountWithSingleDepositOf: 50.
		self accountWithSingleDepositOf: 100
	}.
	
	parentPortfolio := self portfolioWithAssets: { childPorfolio }.
	
	self assert: childPorfolio balance equals: parentPortfolio balance.! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'SG 5/15/2023 19:43:15'!
addToTotalBalance: previousBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'SG 5/15/2023 21:21:45'!
for: aValue
	
	self subclassResponsibility ! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'SG 5/15/2023 19:45:35'!
addToTotalBalance: aBalance

	^ aBalance + self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'SG 5/15/2023 19:45:44'!
addToTotalBalance: aBalance

	^ aBalance - self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Asset category: 'Portfolio-Ejercicio'!
Object subclass: #Asset
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Asset methodsFor: 'balance' stamp: 'TS 5/21/2023 19:57:27'!
balance 
	
	self subclassResponsibility ! !


!Asset methodsFor: 'transactions' stamp: 'TS 5/21/2023 20:13:58'!
hasRegistered: aTransaction

	self subclassResponsibility
! !

!Asset methodsFor: 'transactions' stamp: 'TS 5/21/2023 19:57:59'!
transactions
	
	self subclassResponsibility! !


!Asset methodsFor: 'portfolio hierarchy-private' stamp: 'TS 5/22/2023 03:58:22'!
addToPortfolio: aPortfolio

	self subclassResponsibility! !

!Asset methodsFor: 'portfolio hierarchy-private' stamp: 'TS 5/22/2023 00:49:43'!
canBeAddedTo: aPortfolio

	self subclassResponsibility! !

!Asset methodsFor: 'portfolio hierarchy-private' stamp: 'TS 5/22/2023 04:01:34'!
isComposedOf: anAsset

	self subclassResponsibility! !

!Asset methodsFor: 'portfolio hierarchy-private' stamp: 'TS 5/22/2023 03:44:28'!
isInHierarchyOf: aPortfolio

	^ (aPortfolio isComposedOf: self) or:
	[aPortfolio anyAncestorHasAsset: self]! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Asset subclass: #Portfolio
	instanceVariableNames: 'assets parentPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'TS 5/21/2023 20:02:55'!
balance 
	
	^ (assets sum: [:anAsset | anAsset balance] ifEmpty: [ 0 ])! !


!Portfolio methodsFor: 'asset addition-private' stamp: 'TS 5/21/2023 23:22:59'!
addParentPortfolio: aParentPortfolio

	parentPortfolios add: aParentPortfolio! !

!Portfolio methodsFor: 'asset addition-private' stamp: 'TS 5/22/2023 03:57:23'!
addToPortfolio: aPortfolio

	self addParentPortfolio: aPortfolio! !


!Portfolio methodsFor: 'asset addition' stamp: 'TS 5/22/2023 03:57:46'!
addAsset: anAsset

	(anAsset canBeAddedTo: self) ifFalse: [ self error: self class cantHaveRepeatedAssets ].

	anAsset addToPortfolio: self.
	
	assets add: anAsset! !


!Portfolio methodsFor: 'initialization' stamp: 'TS 5/21/2023 23:22:59'!
initialize

	assets := Set new.
	parentPortfolios := Set new! !


!Portfolio methodsFor: 'transactions' stamp: 'TS 5/22/2023 03:25:03'!
addTransactionsTo: aCollectionTransactions

	assets do: [ :anAsset | anAsset addTransactionsTo: aCollectionTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'TS 5/21/2023 20:17:35'!
hasRegistered: aTransaction 
	
	^ self transactions includes: aTransaction! !

!Portfolio methodsFor: 'transactions' stamp: 'TS 5/22/2023 03:23:38'!
transactions
	
	| transactions |
	
	transactions := Set new.
	
	self addTransactionsTo: transactions.
	
	^ transactions! !


!Portfolio methodsFor: 'portfolio-private' stamp: 'TS 5/22/2023 03:46:31'!
allChildrenCanBeAddedTo: aPortfolio

	^ assets allSatisfy: [ :anAsset | anAsset canBeAddedTo: aPortfolio ]! !

!Portfolio methodsFor: 'portfolio-private' stamp: 'TS 5/22/2023 03:43:17'!
anyAncestorHasAsset: anAsset

	^ parentPortfolios anySatisfy: [:aParentPortfolio |
		(aParentPortfolio isComposedOf: anAsset) or: [ aParentPortfolio anyAncestorHasAsset: anAsset ]
	]! !

!Portfolio methodsFor: 'portfolio-private' stamp: 'TS 5/22/2023 03:45:47'!
anyChildIsComposedOf: anAsset

	^ assets anySatisfy: [:aChildAsset | aChildAsset isComposedOf: anAsset ]! !

!Portfolio methodsFor: 'portfolio-private' stamp: 'TS 5/22/2023 03:46:31'!
canBeAddedTo: aPortfolio

	^ (self isInHierarchyOf: aPortfolio	) not and:
		[ self allChildrenCanBeAddedTo: aPortfolio ]! !

!Portfolio methodsFor: 'portfolio-private' stamp: 'TS 5/22/2023 03:45:47'!
isComposedOf: anAsset

	^ self = anAsset or: 
		(assets includes: anAsset) or:
		[ self anyChildIsComposedOf: anAsset ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'TS 5/21/2023 20:28:46'!
cantHaveRepeatedAssets

	^ 'No se debe agregar un asset preexistente en el portfolio'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Asset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'TS 5/22/2023 03:26:11'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'TS 5/21/2023 20:14:00'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'SG 5/15/2023 19:42:41'!
balance

	^transactions inject: 0 into: [:previousBalance :aTransaction | 
		aTransaction addToTotalBalance: previousBalance
	 ]! !


!ReceptiveAccount methodsFor: 'portfolio-private' stamp: 'TS 5/22/2023 03:58:29'!
addToPortfolio: aPortfolio! !

!ReceptiveAccount methodsFor: 'portfolio-private' stamp: 'TS 5/22/2023 00:53:57'!
canBeAddedTo: aPortfolio

	^ (self isInHierarchyOf: aPortfolio) not! !

!ReceptiveAccount methodsFor: 'portfolio-private' stamp: 'TS 5/22/2023 03:44:08'!
isComposedOf: anAsset

	^ self = anAsset! !
