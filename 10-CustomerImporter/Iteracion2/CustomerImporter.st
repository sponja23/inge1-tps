!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'SG 6/28/2023 20:21:40'!
assertAddressLineTypeIsJustA

	^ self 
		assertImportingCustomerFrom: self invalidImportDataWithInvalidAddressLine 
		raisesErrorWithDescription: CustomerImporter invalidLineTypeErrorDescription 
		asserting: [ self assertCustomerImportedWithoutAddress ]! !

!ImportTest methodsFor: 'tests' stamp: 'SG 6/28/2023 20:21:28'!
assertCustomerLineTypeIsJustC

	^ self 
		assertImportingCustomerFrom: self invalidImportDataWithInvalidCustomerLine 
		raisesErrorWithDescription: CustomerImporter invalidLineTypeErrorDescription 
		asserting: [ self assertNoCustomersImported ]! !

!ImportTest methodsFor: 'tests' stamp: 'SG 6/28/2023 20:20:51'!
assertLineTypeIsValid

	^ self 
		assertImportingCustomerFrom: self invalidImportDataWithInvalidLine 
		raisesErrorWithDescription: CustomerImporter invalidLineTypeErrorDescription 
		asserting: [ self assertNoCustomersImported ]! !

!ImportTest methodsFor: 'tests' stamp: 'SG 6/28/2023 19:20:00'!
test01ValidCustomersAreImportedCorrectly

	CustomerImporter valueFrom: self validImportData into: session.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'SG 6/28/2023 20:03:09'!
test02EmptyLineRaisesError
	
	self 
		assertImportingCustomerFrom: self invalidImportDataWithEmptyLines 
		raisesErrorWithDescription: CustomerImporter emptyLineErrorDescription
		asserting: [ self assertNoCustomersImported ]! !

!ImportTest methodsFor: 'tests' stamp: 'SG 6/28/2023 20:21:40'!
test03InvalidLineTypeRaisesError
	
	self assertLineTypeIsValid.

	self assertCustomerLineTypeIsJustC.
		
	self assertAddressLineTypeIsJustA.! !

!ImportTest methodsFor: 'tests' stamp: 'SG 6/28/2023 20:02:21'!
test04CantImportCustomerWithLessThanFiveFields
	
	self 
		assertImportingCustomerFrom: self invalidImportDataWithMissingCustomerFields
		raisesErrorWithDescription: CustomerImporter missingCustomerDataErrorDescription
		asserting: [ self assertOnlyValidCustomersAreImported ]! !

!ImportTest methodsFor: 'tests' stamp: 'SG 6/28/2023 20:02:10'!
test05CantImportCustomerWithMoreThanFiveFields
	
	self 
		assertImportingCustomerFrom: self invalidImportDataWithExtraCustomerFields
		raisesErrorWithDescription: CustomerImporter extraCustomerDataErrorDescription 
		asserting: [ self assertOnlyValidCustomersAreImported ]! !

!ImportTest methodsFor: 'tests' stamp: 'SG 6/28/2023 20:02:42'!
test06CantImportAddressWithLessThanSixFields
	
	self 
		assertImportingCustomerFrom: self invalidImportDataWithMissingAddressFields
		raisesErrorWithDescription: CustomerImporter missingAddressDataErrorDescription 
		asserting: [ self assertCustomerImportedWithoutAddress ]! !

!ImportTest methodsFor: 'tests' stamp: 'SG 6/28/2023 19:52:11'!
test07CantImportAddressWithMoreThanSixFields
	
	
	self 
		assertImportingCustomerFrom: self invalidImportDataWithExtraAddressFields
		raisesErrorWithDescription: CustomerImporter extraAddressDataErrorDescription 
		asserting: [self assertCustomerImportedWithoutAddress] ! !

!ImportTest methodsFor: 'tests' stamp: 'SG 6/28/2023 19:58:17'!
test08CantImportAddressWithoutCustomer

	| readStream |
	
	readStream :=  self invalidImportDataWithAddressButNoCustomer.
	
	self 
		should: [ CustomerImporter valueFrom: readStream into: session ]
		raise: Error
		withMessageText: CustomerImporter cannotImportAddressWithoutCustomerErrorDescription.
	! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'SG 6/28/2023 19:54:22'!
assertCustomerImportedWithoutAddress
	
	| customer |
	self assert: 1 equals: self numberOfImportedCustomers.
	customer := self customerWithIdentificationType: 'D' number: '22333444'.
	self assert: customer hasNoAddress.! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:12:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'SG 6/28/2023 19:33:23'!
assertImportingCustomerFrom: aReadStream raisesErrorWithDescription: anErrorDescription asserting: aBlockToCheckState  

	self 
		should: [ CustomerImporter valueFrom: aReadStream into: session ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anErrorDescription equals: anError messageText.
			aBlockToCheckState value.
		]! !

!ImportTest methodsFor: 'assertions' stamp: 'SG 6/26/2023 20:25:51'!
assertImportingCustomersFrom: aReadStream raisesErrorWithDescription: anErrorDescription 

	^ self
		should: [ CustomerImporter valueFrom: aReadStream into: session ]
		raise: Error
		withMessageText: anErrorDescription! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'SG 6/28/2023 20:00:08'!
assertNoCustomersImported

	^ self assert: 0 equals: self numberOfImportedCustomers ! !

!ImportTest methodsFor: 'assertions' stamp: 'SG 6/28/2023 20:14:49'!
assertOnlyValidCustomersAreImported

	self assertPepeSanchezWasImportedCorrecty.
	self assert: 1 equals: self numberOfImportedCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:27:50'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:28:23'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'HAW 5/22/2022 18:14:22'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !

!ImportTest methodsFor: 'customer' stamp: 'SG 6/28/2023 19:49:17'!
numberOfImportedCustomers
	
	^ (session selectAllOfType: Customer) size! !


!ImportTest methodsFor: 'test data' stamp: 'SG 6/28/2023 19:58:17'!
invalidImportDataWithAddressButNoCustomer

	^ self readStreamWithLines: { 'A,San Martin,3322,Olivos,1636,BsAs' }! !

!ImportTest methodsFor: 'test data' stamp: 'SG 6/26/2023 20:45:36'!
invalidImportDataWithEmptyLines

	^ self readStreamWithLines: { ''. '' }! !

!ImportTest methodsFor: 'test data' stamp: 'SG 6/28/2023 19:56:32'!
invalidImportDataWithExtraAddressFields

	^ self readStreamWithLines: {
		'C,Pepe,Sanchez,D,22333444'.
		'A,San Martin,3322,2954,Olivos,1636,BsAs'.
	}! !

!ImportTest methodsFor: 'test data' stamp: 'SG 6/26/2023 21:41:34'!
invalidImportDataWithExtraCustomerFields

	^ self readStreamWithLines: {
		'C,Pepe,Sanchez,D,22333444'.
		'A,San Martin,3322,Olivos,1636,BsAs'.
		'A,Maipu,888,Florida,1122,Buenos Aires'.
		'C,Juan,Perez,C,23-25666777-9,134'.
		'A,Alem,1122,CABA,1001,CABA'
	}! !

!ImportTest methodsFor: 'test data' stamp: 'SG 6/28/2023 20:09:31'!
invalidImportDataWithInvalidAddressLine
	
	^ self readStreamWithLines: {
		'C,Pepe,Sanchez,D,22333444'.
		'Address,San Martin,3322,Olivos,1636,BsAs'.
	}! !

!ImportTest methodsFor: 'test data' stamp: 'SG 6/28/2023 20:08:03'!
invalidImportDataWithInvalidCustomerLine

	^ self readStreamWithLines: { 'Customer,x,y,z' }! !

!ImportTest methodsFor: 'test data' stamp: 'SG 6/28/2023 20:07:36'!
invalidImportDataWithInvalidLine

	^ self readStreamWithLines: { 'X,a,b,c' }! !

!ImportTest methodsFor: 'test data' stamp: 'SG 6/28/2023 19:56:11'!
invalidImportDataWithMissingAddressFields

	^ self readStreamWithLines: {
		'C,Pepe,Sanchez,D,22333444'.
		'A,San Martin,3322,Olivos,BsAs'.
	}! !

!ImportTest methodsFor: 'test data' stamp: 'SG 6/26/2023 21:41:55'!
invalidImportDataWithMissingCustomerFields

	^ self readStreamWithLines: {
		'C,Pepe,Sanchez,D,22333444'.
		'A,San Martin,3322,Olivos,1636,BsAs'.
		'A,Maipu,888,Florida,1122,Buenos Aires'.
		'C,Juan,Perez,C'.
		'A,Alem,1122,CABA,1001,CABA'
	}! !

!ImportTest methodsFor: 'test data' stamp: 'SG 6/26/2023 20:15:59'!
readStreamWithLines: aCollectionOfLines

	^ ReadStream on: (
		aCollectionOfLines allButFirst
			inject: aCollectionOfLines first
			into: [:previousLines :newLine | previousLines, String crlfString, newLine ]
	)! !

!ImportTest methodsFor: 'test data' stamp: 'SG 6/26/2023 20:09:38'!
validImportData

	^ self readStreamWithLines: {
		'C,Pepe,Sanchez,D,22333444'.
		'A,San Martin,3322,Olivos,1636,BsAs'.
		'A,Maipu,888,Florida,1122,Buenos Aires'.
		'C,Juan,Perez,C,23-25666777-9'.
		'A,Alem,1122,CABA,1001,CABA'
	}! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !

!Customer methodsFor: 'addresses' stamp: 'SG 6/28/2023 19:57:08'!
hasNoAddress
	
	^ addresses isEmpty.! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream newCustomer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'SG 6/26/2023 19:25:38'!
initializeFrom: aReadStream into: aSession

	readStream := aReadStream.	
	session := aSession.! !


!CustomerImporter methodsFor: 'line processing' stamp: 'SG 6/26/2023 20:48:01'!
isAddressLine: aLine

	^ aLine beginsWith: 'A,'! !

!CustomerImporter methodsFor: 'line processing' stamp: 'SG 6/26/2023 20:47:54'!
isCustomerLine: aLine

	^ aLine beginsWith: 'C,'! !

!CustomerImporter methodsFor: 'line processing' stamp: 'SG 6/26/2023 19:35:52'!
onLinesDo: aBlock

	| line |

	[ line := readStream nextLine ] whileNotNil: [
		aBlock value: line
	].! !

!CustomerImporter methodsFor: 'line processing' stamp: 'SG 6/28/2023 20:17:01'!
readAddressLine: aLine 

	| addressData address |
	addressData := self splitLineIntoTokens: aLine.
	
	self assertImportingAllAddressFields: addressData.
	self assertImportingOnlyValidAddressFields: addressData.
	
	address := Address new.
	address streetName: addressData second.
	address streetNumber: addressData third asNumber.
	address town: addressData fourth.
	address zipCode: addressData fifth asNumber.
	address province: addressData sixth.
	
	^ address! !

!CustomerImporter methodsFor: 'line processing' stamp: 'SG 6/26/2023 21:36:09'!
readCustomerLine: line

	| customerData customer |

	customerData := self splitLineIntoTokens: line.
	
	self assertImportingAllCustomerFields: customerData.
	self assertImportingOnlyValidCustomerFields: customerData.
	
	customer := Customer new.
	customer firstName: customerData second.
	customer lastName: customerData third.
	customer identificationType: customerData fourth.
	customer identificationNumber: customerData fifth.

	^ customer! !

!CustomerImporter methodsFor: 'line processing' stamp: 'SG 6/26/2023 19:19:41'!
splitLineIntoTokens: line

	^ line findTokens: $,! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'SG 6/28/2023 20:19:10'!
assertThereIsCustomer

	^ newCustomer isNil ifTrue: [ self error: self class cannotImportAddressWithoutCustomerErrorDescription ]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'SG 6/28/2023 20:19:10'!
readAddressIntoSessionFrom: aLine

	| newAddress |
	
	self assertThereIsCustomer.
	
	newAddress := self readAddressLine: aLine.
	newCustomer addAddress: newAddress! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'SG 6/28/2023 20:18:41'!
readCustomerIntoSessionFrom: aLine

	newCustomer := self readCustomerLine: aLine.
	session persist: newCustomer! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'SG 6/26/2023 20:43:11'!
readLine: aLine

	self assertLineIsNotEmpty: aLine.
	(self isCustomerLine: aLine) ifTrue: [ self readCustomerIntoSessionFrom: aLine. ^self ].
	(self isAddressLine: aLine) ifTrue: [ self readAddressIntoSessionFrom: aLine. ^self ].
	self error: self class invalidLineTypeErrorDescription! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'SG 6/26/2023 20:18:00'!
value
 
	self onLinesDo: [:line |
		self readLine: line
	].
! !


!CustomerImporter methodsFor: 'validation' stamp: 'SG 6/28/2023 20:15:30'!
assertImportingAllAddressFields: addressData

	(addressData size < 6) ifTrue: [self error: self class missingAddressDataErrorDescription ]! !

!CustomerImporter methodsFor: 'validation' stamp: 'SG 6/26/2023 21:48:19'!
assertImportingAllCustomerFields: customerData

	(customerData size < 5) ifTrue: [self error: self class missingCustomerDataErrorDescription ].
	! !

!CustomerImporter methodsFor: 'validation' stamp: 'SG 6/28/2023 20:17:01'!
assertImportingOnlyValidAddressFields: addressData

	^ (addressData size > 6) ifTrue: [self error: self class extraAddressDataErrorDescription ]! !

!CustomerImporter methodsFor: 'validation' stamp: 'SG 6/28/2023 20:15:25'!
assertImportingOnlyValidCustomerFields: customerData

	(customerData size > 5) ifTrue: [self error: self class extraCustomerDataErrorDescription ]! !

!CustomerImporter methodsFor: 'validation' stamp: 'SG 6/26/2023 20:43:40'!
assertLineIsNotEmpty: aLine 

	aLine isEmpty ifTrue: [ self error: self class emptyLineErrorDescription ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 18:06:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 18:11:27'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!CustomerImporter class methodsFor: 'error descriptions' stamp: 'SG 6/28/2023 19:31:29'!
cannotImportAddressWithoutCustomerErrorDescription
	
	^ 'No se puede importar una dirección sin un cliente'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'SG 6/26/2023 20:40:16'!
emptyLineErrorDescription

	^ 'La entrada contiene líneas vacías'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'SG 6/26/2023 21:47:10'!
extraAddressDataErrorDescription
	
	^ 'Las direcciones no pueden tener más de seis campos'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'SG 6/26/2023 21:48:07'!
extraCustomerDataErrorDescription
	
	^ 'Los clientes no pueden tener más de cinco campos'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'SG 6/26/2023 20:12:42'!
invalidLineTypeErrorDescription

	^ 'La línea tiene un tipo inválido'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'SG 6/26/2023 21:34:44'!
missingAddressDataErrorDescription
	
	^ 'Faltan datos de la dirección del cliente'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'SG 6/26/2023 21:48:19'!
missingCustomerDataErrorDescription
	
	^ 'Faltan datos del cliente'! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
