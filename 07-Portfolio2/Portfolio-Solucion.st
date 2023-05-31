!classDefinition: #PortfolioReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioReportTest methodsFor: 'tests' stamp: 'TS 5/31/2023 00:31:59'!
test01PortfolioStructureOfEmptyPortfolioOnlyShowsItsName

	| portfolio |
	portfolio := Portfolio named: 'Portfolio de Juan'.
	
	self
		assert: #('Portfolio de Juan') asOrderedCollection
		equals: (PortfolioStructureSummary for: portfolio) lines
! !

!PortfolioReportTest methodsFor: 'tests' stamp: 'TS 5/31/2023 00:32:13'!
test02PortfolioStructureOfPortfolioWithChildrenAccountsShowsTheirNamesWith1LevelOfIndentation

	| portfolio account1 account2 |
	account1 := ReceptiveAccount named: 'Cuenta de María'.
	account2 := ReceptiveAccount named: 'Cuenta mía'.
	portfolio := Portfolio named: 'Portfolio de Martín' with: account1 with: account2.

	self
		assert: #(
			'Portfolio de Martín'
			'	Cuenta de María'
			'	Cuenta mía'
		) asOrderedCollection
		equals: (PortfolioStructureSummary for: portfolio) lines
! !

!PortfolioReportTest methodsFor: 'tests' stamp: 'TS 5/31/2023 00:32:19'!
test03PortfolioStructureOfPortfolioWithNestedPortfolioShowsItsStructureCorrectly

	| account1 account2 childPortfolio parentPortfolio |
	account1 := ReceptiveAccount named: 'Cuenta de María'.
	account2 := ReceptiveAccount named: 'Cuenta mía'.
	childPortfolio := Portfolio named: 'Portfolio de Juan' with: account1.
	parentPortfolio := Portfolio named: 'Portfolio de Martín' with: childPortfolio with: account2.

	self
		assert: #(
			'Portfolio de Martín'
			'	Portfolio de Juan'
			'		Cuenta de María'
			'	Cuenta mía'
		) asOrderedCollection
		equals: (PortfolioStructureSummary for: parentPortfolio) lines
! !

!PortfolioReportTest methodsFor: 'tests' stamp: 'TS 5/31/2023 00:32:28'!
test04PortfolioStructureOfPortfolioWithMultipleLevelsOfNestingShowsItsStructureCorrectly

	| account1 account2 parentPortfolio childPortfolio grandchildPortfolio |
	account1 := ReceptiveAccount named: 'Cuenta de María'.
	account2 := ReceptiveAccount named: 'Cuenta mía'.
	grandchildPortfolio := Portfolio named: 'Portfolio mío' with: account2.
	childPortfolio := Portfolio named: 'Portfolio de Juan' with: account1 with: grandchildPortfolio.
	parentPortfolio := Portfolio named: 'Portfolio de Martín' with: childPortfolio.

	self
		assert: #(
			'Portfolio de Martín'
			'	Portfolio de Juan'
			'		Cuenta de María'
			'		Portfolio mío'
			'			Cuenta mía'
		) asOrderedCollection
		equals: (PortfolioStructureSummary for: parentPortfolio) lines
! !

!PortfolioReportTest methodsFor: 'tests' stamp: 'TS 5/31/2023 00:04:03'!
test05PortfolioSummaryOfEmptyPortfolioOnlyShowsItsName

	| portfolio |
	portfolio := Portfolio named: 'Portfolio de Martín'.

	self
		assert: #(
			'Portfolio de Martín'
		) asOrderedCollection
		equals: (PortfolioTransactionSummary for: portfolio) lines
! !

!PortfolioReportTest methodsFor: 'tests' stamp: 'TS 5/31/2023 00:07:38'!
test06PortfolioSummaryOfPortfolioWithChildAccountShowsItsNameAndItsChildsAccountSummary

	| portfolio account |
	account := ReceptiveAccount named: 'Cuenta de Martín'.
	Deposit register: 50 on: account.
	portfolio := Portfolio named: 'Portfolio de Martín' with: account.

	self
		assert: #(
			'Portfolio de Martín'
			'	Cuenta de Martín'
			'		Depósito por 50'
			'		Balance = 50'
		) asOrderedCollection
		equals: (PortfolioTransactionSummary for: portfolio) lines
! !

!PortfolioReportTest methodsFor: 'tests' stamp: 'TS 5/31/2023 00:16:38'!
test07PortfolioSummaryOfPortfolioWithChildPortfolioShowsItsName

	| portfolio account childPortfolio |
	account := ReceptiveAccount named: 'Cuenta de Martín'.
	Deposit register: 50 on: account.
	childPortfolio := Portfolio named: 'Portfolio de Juan'.
	portfolio := Portfolio named: 'Portfolio de Martín' with: account with: childPortfolio.

	self
		assert: #(
			'Portfolio de Martín'
			'	Cuenta de Martín'
			'		Depósito por 50'
			'		Balance = 50'
			'	Portfolio de Juan'
		) asOrderedCollection
		equals: (PortfolioTransactionSummary for: portfolio) lines
! !

!PortfolioReportTest methodsFor: 'tests' stamp: 'TS 5/31/2023 00:31:33'!
test08PortfolioSummaryOfNestedPortfoliosShowsAllSummariesCorrectly

	| portfolio account1 childPortfolio account2 grandchildPortfolio |
	account1 := ReceptiveAccount named: 'Cuenta de Juan'.
	Deposit register: 50 on: account1.
	account2 := ReceptiveAccount named: 'Cuenta de María'.
	Transfer register: 50 from: account1 to: account2.
	grandchildPortfolio := Portfolio named: 'Portfolio de María' with: account2.
	childPortfolio := Portfolio named: 'Portfolio de Juan' with: account1 with: grandchildPortfolio.
	portfolio := Portfolio named: 'Portfolio de Martín' with: childPortfolio.

	self
		assert: #(
			'Portfolio de Martín'
			'	Portfolio de Juan'
			'		Cuenta de Juan'
			'			Depósito por 50'
			'			Salida por transferencia de 50'
			'			Balance = 0'
			'		Portfolio de María'
			'			Cuenta de María'
			'				Entrada por transferencia de 50'
			'				Balance = 50'
		) asOrderedCollection
		equals: (PortfolioTransactionSummary for: portfolio) lines
! !


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #TransactionReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransactionReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransactionReportTest methodsFor: 'testing' stamp: 'SMG 5/27/2023 23:21:07'!
test01AccountSummaryOfEmptyAccountOnlyContainsBalanceLine

	| account report |
	account := ReceptiveAccount new.
	
	report := AccountSummary for: account.
	
	self
		assert: #('Balance = 0') asOrderedCollection
		equals: report lines! !

!TransactionReportTest methodsFor: 'testing' stamp: 'SMG 5/27/2023 23:21:37'!
test02AccountSummaryContainsDepositTransactions

	| account report |
	account := ReceptiveAccount new.
	Deposit register: 50 on: account.
	Deposit register: 100 on: account.

	report := AccountSummary for: account.

	self
		assert: #(
			'Depósito por 50'
			'Depósito por 100'
			'Balance = 150'
		) asOrderedCollection
		equals: report lines! !

!TransactionReportTest methodsFor: 'testing' stamp: 'SMG 5/27/2023 23:21:44'!
test03AccountSummaryContainsWithdrawTransactions

	| account report |
	account := ReceptiveAccount new.
	Deposit register: 50 on: account.
	Withdraw register: 25 on: account.

	report := AccountSummary for: account.

	self
		assert: #(
			'Depósito por 50'
			'Extracción por 25'
			'Balance = 25'
		) asOrderedCollection
		equals: report lines! !

!TransactionReportTest methodsFor: 'testing' stamp: 'SMG 5/27/2023 23:34:00'!
test04AccountSummaryContainsTransfers

	| receiver sender |
	sender := ReceptiveAccount new.
	Deposit register: 50 on: sender.
	receiver := ReceptiveAccount new.
	
	Transfer register: 50 from: sender to: receiver.

	self
		assert: #(
			'Depósito por 50'
			'Salida por transferencia de 50'
			'Balance = 0'
		) asOrderedCollection
		equals: (AccountSummary for: sender) lines.
	self
		assert: #(
			'Entrada por transferencia de 50'
			'Balance = 50'
		) asOrderedCollection
		equals: (AccountSummary for: receiver) lines
	! !

!TransactionReportTest methodsFor: 'testing' stamp: 'SMG 5/27/2023 23:40:11'!
test05TransferNetOfAccountWithNoTransfersIsZero

	| account |

	account := ReceptiveAccount new.
	Deposit register: 50 on: account.

	self assert: 0 equals: (TransferNet for: account) value! !

!TransactionReportTest methodsFor: 'testing' stamp: 'SMG 5/27/2023 23:51:23'!
test06TransferNetOfReceivingAccountIsCorrect

	| receiver sender |

	sender := ReceptiveAccount new.
	Deposit register: 50 on: sender.
	receiver := ReceptiveAccount new.
	
	Transfer register: 50 from: sender to: receiver.

	self assert: 50 equals: (TransferNet for: receiver) value
! !

!TransactionReportTest methodsFor: 'testing' stamp: 'SMG 5/27/2023 23:52:14'!
test07TransferNetOfSendingAccountIsCorrect

	| receiver sender |

	sender := ReceptiveAccount new.
	Deposit register: 50 on: sender.
	receiver := ReceptiveAccount new.
	
	Transfer register: 50 from: sender to: receiver.

	self assert: -50 equals: (TransferNet for: sender) value
! !

!TransactionReportTest methodsFor: 'testing' stamp: 'TS 5/30/2023 15:07:52'!
test08PortfoliosHaveCorrectAccountSummaryAndTransferNet

	| account1 account2 portfolio |
	account1 := ReceptiveAccount new.
	Deposit register: 50 on: account1.
	
	account2 := ReceptiveAccount new.
	Transfer register: 50 from: account1 to: account2.
	
	portfolio := Portfolio new.
	portfolio add: account1; add: account2.
	
	"
	Los comparamos como conjuntos porque nos dijeron que no
	importa el orden entre las transacciones de las cuentas
	"
	self
		assert: #(
			'Depósito por 50'
			'Salida por transferencia de 50'
			'Entrada por transferencia de 50'
			'Balance = 50'
		) asSet
		equals: (AccountSummary for: portfolio) lines asSet.
		
	self assert: 0 equals: (TransferNet for: portfolio)	 value.
! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'testing' stamp: 'SMG 5/27/2023 23:30:07'!
test01TransferRemovesBalanceFromSenderAndAddsItToReceiver

	self withTransferOf: 50 do: [:sender :receiver :transfer |
		self assert: 0 equals: sender balance.
		self assert: 50 equals: receiver balance
	]! !

!TransferTest methodsFor: 'testing' stamp: 'SMG 5/27/2023 23:29:33'!
test02TransferLegsAreRegisteredOnParticipantAccounts

	self withTransferOf: 50 do: [:sender :receiver :transfer |
		self assert: (sender hasRegistered: transfer withdrawLeg).
		self assert: (receiver hasRegistered: transfer depositLeg)
	]! !

!TransferTest methodsFor: 'testing' stamp: 'SMG 5/27/2023 23:30:35'!
test03TransferLegsCanAccessTransfer

	self withTransferOf: 50 do: [:sender :receiver :transfer |
		self assert: transfer equals: transfer withdrawLeg transfer.
		self assert: transfer equals: transfer depositLeg transfer
	]! !

!TransferTest methodsFor: 'testing' stamp: 'SMG 5/27/2023 23:31:01'!
test04TransferLegsHasCorrectTransferValue

	self withTransferOf: 50 do: [:sender :receiver :transfer |
		self assert: 50 equals: transfer withdrawLeg value.
		self assert: 50 equals: transfer depositLeg value
	]
! !

!TransferTest methodsFor: 'testing' stamp: 'SMG 5/27/2023 20:45:40'!
test05CantCreateATransferBetweenTheSameAccount

	| account |
	account := ReceptiveAccount new.
	
	self
		should: [ Transfer register: 50 from: account to: account ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Transfer cantTransferBetweenTheSameAccountErrorDescription! !

!TransferTest methodsFor: 'testing' stamp: 'SMG 5/27/2023 20:49:40'!
test06TransferValueMustBePositive

	| receiver sender |
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	self
		should: [ Transfer register: -50 from: sender to: receiver ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Transfer transferValueMustBePositiveErrorDescription! !


!TransferTest methodsFor: 'setUp/tearDown' stamp: 'SMG 5/27/2023 23:24:12'!
accountWithSingleDepositOf: aValue

	| account |

	account := ReceptiveAccount new.
	Deposit register: 50 on: account.
	
	^ account! !

!TransferTest methodsFor: 'setUp/tearDown' stamp: 'SMG 5/27/2023 23:29:45'!
withTransferOf: aValue do: aBlock

	| receiver sender transfer |
	sender := self accountWithSingleDepositOf: aValue.
	receiver := ReceptiveAccount new.
	
	transfer := Transfer register: aValue from: sender to: receiver.
	
	aBlock value: sender value: receiver value: transfer! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'TS 5/30/2023 15:08:12'!
onTransactionsDo: aBlock

	self subclassResponsibility! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'operation' stamp: 'TS 5/30/2023 23:54:18'!
doOperationOf: anAccountOperation

	self subclassResponsibility! !

!Account methodsFor: 'operation' stamp: 'TS 5/31/2023 15:54:13'!
onTransactionDoOperationOf: aTransactionOperation

	self onTransactionsDo: [:aTransaction | aTransaction doOperationOf: aTransactionOperation ]! !


!Account methodsFor: 'accessing' stamp: 'TS 5/30/2023 17:08:20'!
accountName

	^ name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'Portfolio-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instance creation' stamp: 'TS 5/30/2023 17:07:59'!
named: aName

	^self new initializeNamed: aName ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'TS 5/30/2023 16:14:42'!
onAccountsDo: aBlock

	accounts do: aBlock! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'TS 5/30/2023 16:00:01'!
initializeNamed: aName 

	name := aName! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'TS 5/30/2023 15:07:17'!
onTransactionsDo: aBlock 

	accounts do: [:anAccount |
		anAccount onTransactionsDo: aBlock
	]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'operation' stamp: 'TS 5/30/2023 23:54:26'!
doOperationOf: anAccountOperation

	anAccountOperation operateOnPortfolio: self! !

!Portfolio methodsFor: 'operation' stamp: 'TS 5/31/2023 15:53:25'!
onAccountsDoOperationOf: anAccountOperation

	accounts do: [:anAccount | anAccount doOperationOf: anAccountOperation ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'TS 5/30/2023 16:28:03'!
named: aName with: anAccount 
	
	^ (self named: aName)
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'TS 5/30/2023 16:08:04'!
named: aName with: anAccount with: anotherAccount

	^ (self named: aName)
		add: anAccount;
		add: anotherAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'TS 5/30/2023 16:06:50'!
initializeNamed: aName 

	name := aName.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'SMG 5/27/2023 23:14:26'!
onTransactionsDo: aBlock

	transactions do: aBlock! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'operation' stamp: 'TS 5/30/2023 23:54:32'!
doOperationOf: anAccountOperation

	anAccountOperation operateOnReceptiveAccount: self! !


!classDefinition: #AccountOperation category: 'Portfolio-Solucion'!
Object subclass: #AccountOperation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!
!AccountOperation commentStamp: '<historical>' prior: 0!
Esta clase representa una operación que se ejecuta sobre todo el árbol de cuentas de un Portfolio!


!AccountOperation methodsFor: 'operation' stamp: 'TS 5/30/2023 23:56:33'!
operateOnPortfolio: aPortfolio

	self subclassResponsibility! !

!AccountOperation methodsFor: 'operation' stamp: 'TS 5/30/2023 23:56:51'!
operateOnReceptiveAccount: aReceptiveAccount

	self subclassResponsibility! !


!classDefinition: #PortfolioTreeViewSummary category: 'Portfolio-Solucion'!
AccountOperation subclass: #PortfolioTreeViewSummary
	instanceVariableNames: 'reportLines currentIndentationLevel portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!
!PortfolioTreeViewSummary commentStamp: '<historical>' prior: 0!
Esta clase representa una operación cuyo resultado es una serie de líneas que utiliza indentación para visualizar la estructura del árbol de un Portfolio.!


!PortfolioTreeViewSummary methodsFor: 'indentation' stamp: 'TS 5/31/2023 15:39:54'!
addLine: aLine

	reportLines addLast: (self getTabsForIndentationLevel), aLine
! !

!PortfolioTreeViewSummary methodsFor: 'indentation' stamp: 'TS 5/31/2023 15:39:59'!
getTabsForIndentationLevel

	^ String new: currentIndentationLevel withAll: Character tab! !

!PortfolioTreeViewSummary methodsFor: 'indentation' stamp: 'TS 5/31/2023 15:40:41'!
withIncreasedIndentationLevelDo: aBlock	

	currentIndentationLevel := currentIndentationLevel + 1.
	
	aBlock value.

	currentIndentationLevel := currentIndentationLevel - 1.! !


!PortfolioTreeViewSummary methodsFor: 'report' stamp: 'TS 5/31/2023 15:46:38'!
lines

	reportLines := OrderedCollection new.
	currentIndentationLevel := 0.

	portfolio doOperationOf: self.

	^ reportLines! !


!PortfolioTreeViewSummary methodsFor: 'initialization' stamp: 'TS 5/31/2023 15:41:17'!
initializeFor: aPortfolio 

	portfolio := aPortfolio! !


!PortfolioTreeViewSummary methodsFor: 'operation' stamp: 'TS 5/31/2023 15:42:42'!
addAccountName: anAccount

	self addLine: anAccount accountName.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreeViewSummary class' category: 'Portfolio-Solucion'!
PortfolioTreeViewSummary class
	instanceVariableNames: ''!

!PortfolioTreeViewSummary class methodsFor: 'instance creation' stamp: 'TS 5/31/2023 15:41:22'!
for: aPortfolio 

	^self new initializeFor: aPortfolio ! !


!classDefinition: #PortfolioStructureSummary category: 'Portfolio-Solucion'!
PortfolioTreeViewSummary subclass: #PortfolioStructureSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioStructureSummary methodsFor: 'operation' stamp: 'TS 5/31/2023 15:54:38'!
operateOnPortfolio: aPortfolio 

	self addAccountName: aPortfolio.

	self withIncreasedIndentationLevelDo: [ aPortfolio onAccountsDoOperationOf: self ]! !

!PortfolioStructureSummary methodsFor: 'operation' stamp: 'TS 5/31/2023 15:43:16'!
operateOnReceptiveAccount: aReceptiveAccount

	self addAccountName: aReceptiveAccount.
! !


!classDefinition: #PortfolioTransactionSummary category: 'Portfolio-Solucion'!
PortfolioTreeViewSummary subclass: #PortfolioTransactionSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTransactionSummary methodsFor: 'operation' stamp: 'TS 5/31/2023 15:54:47'!
operateOnPortfolio: aPortfolio

	self addAccountName: aPortfolio.
	
	self withIncreasedIndentationLevelDo: [ aPortfolio onAccountsDoOperationOf: self ]
! !

!PortfolioTransactionSummary methodsFor: 'operation' stamp: 'TS 5/31/2023 15:49:35'!
operateOnReceptiveAccount: aReceptiveAccount

	self addAccountName: aReceptiveAccount.

	self withIncreasedIndentationLevelDo: [
		(AccountSummary for: aReceptiveAccount) lines do: [:aLine | self addLine: aLine ]
	]! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'operation' stamp: 'TS 5/30/2023 15:47:11'!
doOperationOf: anAccountSummary

	self subclassResponsibility! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'operation' stamp: 'TS 5/30/2023 15:48:59'!
doOperationOf: aTransactionOperation

	aTransactionOperation operateOnDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'SMG 5/27/2023 20:06:23'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferLeg methodsFor: 'initialization' stamp: 'SMG 5/27/2023 20:37:18'!
initializeFor: aTransfer 

	transfer := aTransfer! !


!TransferLeg methodsFor: 'accessing' stamp: 'TS 5/31/2023 15:55:47'!
transfer

	^ transfer! !


!TransferLeg methodsFor: 'value' stamp: 'SMG 5/27/2023 20:32:43'!
value

	^ transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'Portfolio-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'SMG 5/27/2023 20:40:50'!
for: aTransfer

	^ self new initializeFor: aTransfer! !

!TransferLeg class methodsFor: 'instance creation' stamp: 'SMG 5/27/2023 20:40:36'!
register: aTransfer on: anAccount

	"
	A pesar de que este mensaje y el for: tienen la misma implementación que las otras transacciones,
	tienen distinta semántica: los otros toman un valor, mientras que éste toma una transferencia. Es
	por esto que decidimos no hacer polimórfico a los métodos for: y register:on:
	"

	| transferLeg |
	
	transferLeg := self for: aTransfer.
	
	anAccount register: transferLeg.
	
	^ transferLeg! !


!classDefinition: #DepositLeg category: 'Portfolio-Solucion'!
TransferLeg subclass: #DepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DepositLeg methodsFor: 'balance' stamp: 'TS 5/30/2023 15:49:50'!
affectBalance: aBalance

	^ aBalance + self value! !


!DepositLeg methodsFor: 'operation' stamp: 'TS 5/30/2023 15:50:17'!
doOperationOf: aTransactionOperation

	aTransactionOperation operateOnDepositLeg: self! !


!classDefinition: #WithdrawLeg category: 'Portfolio-Solucion'!
TransferLeg subclass: #WithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WithdrawLeg methodsFor: 'balance' stamp: 'TS 5/30/2023 15:49:54'!
affectBalance: aBalance

	^ aBalance - self value! !


!WithdrawLeg methodsFor: 'operation' stamp: 'TS 5/30/2023 15:49:05'!
doOperationOf: aTransactionOperation

	aTransactionOperation operateOnWithdrawLeg: self! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'operation' stamp: 'TS 5/30/2023 15:50:23'!
doOperationOf: aTransactionOperation

	aTransactionOperation operateOnWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'SMG 5/27/2023 20:06:12'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransactionOperation category: 'Portfolio-Solucion'!
Object subclass: #TransactionOperation
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransactionOperation methodsFor: 'initialization' stamp: 'TS 5/30/2023 15:39:25'!
initializeFor: anAccount 

	account := anAccount! !


!TransactionOperation methodsFor: 'operation' stamp: 'TS 5/30/2023 15:41:46'!
operateOnDeposit: aDeposit

	self subclassResponsibility! !

!TransactionOperation methodsFor: 'operation' stamp: 'TS 5/30/2023 15:42:13'!
operateOnDepositLeg: aDepositLeg

	self subclassResponsibility! !

!TransactionOperation methodsFor: 'operation' stamp: 'TS 5/30/2023 15:42:09'!
operateOnWithdraw: aWithdraw

	self subclassResponsibility! !

!TransactionOperation methodsFor: 'operation' stamp: 'TS 5/30/2023 15:42:02'!
operateOnWithdrawLeg: aWithdrawLeg

	self subclassResponsibility! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
TransactionOperation subclass: #AccountSummary
	instanceVariableNames: 'reportLines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'report' stamp: 'TS 5/30/2023 15:21:35'!
addLine: aString

	reportLines addLast: aString! !

!AccountSummary methodsFor: 'report' stamp: 'TS 5/31/2023 15:55:15'!
lines

	reportLines := OrderedCollection new.

	account onTransactionDoOperationOf: self.

	self addLine: 'Balance = ', account balance asString.
	
	^ reportLines! !


!AccountSummary methodsFor: 'operation' stamp: 'TS 5/30/2023 15:42:36'!
operateOnDeposit: aDeposit

	self addLine: 'Depósito por ', aDeposit value asString! !

!AccountSummary methodsFor: 'operation' stamp: 'TS 5/30/2023 15:43:29'!
operateOnDepositLeg: aWithdrawLeg

	self addLine: 'Entrada por transferencia de ', aWithdrawLeg value asString! !

!AccountSummary methodsFor: 'operation' stamp: 'TS 5/30/2023 15:43:42'!
operateOnWithdraw: aWithdraw

	self addLine: 'Extracción por ', aWithdraw value asString! !

!AccountSummary methodsFor: 'operation' stamp: 'TS 5/30/2023 15:42:54'!
operateOnWithdrawLeg: aWithdrawLeg

	self addLine: 'Salida por transferencia de ', aWithdrawLeg value asString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'SMG 5/27/2023 23:09:06'!
for: anAccount

	^ self new initializeFor: anAccount! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
TransactionOperation subclass: #TransferNet
	instanceVariableNames: 'netValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'report' stamp: 'TS 5/31/2023 15:55:23'!
value
	
	netValue := 0.

	account onTransactionDoOperationOf: self.

	^ netValue! !


!TransferNet methodsFor: 'operation' stamp: 'TS 5/30/2023 15:44:16'!
operateOnDeposit: aDeposit
! !

!TransferNet methodsFor: 'operation' stamp: 'TS 5/30/2023 15:43:58'!
operateOnDepositLeg: aWithdrawLeg

	netValue := netValue + aWithdrawLeg value
! !

!TransferNet methodsFor: 'operation' stamp: 'TS 5/30/2023 15:44:32'!
operateOnWithdraw: aWithdraw
! !

!TransferNet methodsFor: 'operation' stamp: 'TS 5/30/2023 15:44:26'!
operateOnWithdrawLeg: aWithdrawLeg

	netValue := netValue - aWithdrawLeg value
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'SMG 5/27/2023 23:43:51'!
for: anAccount 

	^self new initializeFor: anAccount! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'TS 5/30/2023 14:42:48'!
initializeWith: aValue from: aSender to: aReceiver 
	
	value := aValue.
	withdrawLeg := WithdrawLeg register: self on: aSender.
	depositLeg := DepositLeg register: self on: aReceiver
! !


!Transfer methodsFor: 'accessing' stamp: 'SMG 5/27/2023 20:05:17'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'SMG 5/27/2023 20:17:32'!
value

	^ value! !

!Transfer methodsFor: 'accessing' stamp: 'SMG 5/27/2023 20:05:08'!
withdrawLeg

	^withdrawLeg! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'SMG 5/27/2023 20:51:26'!
assertCantTransferFrom: aValue to: aSender withValue: aReceiver

	aSender = aReceiver ifTrue: [ self error: self cantTransferBetweenTheSameAccountErrorDescription ].
	aValue strictlyPositive ifFalse: [ self error: self transferValueMustBePositiveErrorDescription ]! !

!Transfer class methodsFor: 'instance creation' stamp: 'SMG 5/27/2023 20:51:26'!
register: aValue from: aSender to: aReceiver 

	self assertCantTransferFrom: aValue to: aSender withValue: aReceiver.

	^self new initializeWith: aValue from: aSender to: aReceiver! !


!Transfer class methodsFor: 'error descriptions' stamp: 'SMG 5/27/2023 20:46:25'!
cantTransferBetweenTheSameAccountErrorDescription

	^ 'No se puede realizar una transferencia entre una cuenta y sí misma'! !

!Transfer class methodsFor: 'error descriptions' stamp: 'SMG 5/27/2023 20:49:40'!
transferValueMustBePositiveErrorDescription

	^ 'Las transferencias deben ser de un valor positivo'! !
