!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'TS 6/26/2023 15:46:34'!
importCustomersFromStream: inputStream

	^ (CustomerImporter from: inputStream to: session) import! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'TS 6/26/2023 01:48:07'!
inputStreamWithLines: aCollectionOfLines

	^ ReadStream on: (
		aCollectionOfLines
			inject: String new
			into: [:previousLines :newLine | previousLines, String crlfString, newLine ]
	)! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'TS 6/25/2023 21:16:37'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'TS 6/25/2023 21:16:53'!
tearDown

	session commit.
	session close! !


!ImportTest methodsFor: 'assertions' stamp: 'TS 6/26/2023 01:01:15'!
assertAddress: anAddress hasNumber: aStreetNumber atTown: aTown withZipCode: aZipCode atProvince: aProvince

	self assert: aStreetNumber equals: anAddress streetNumber.
	self assert: aTown equals: anAddress town.
	self assert: aZipCode equals: anAddress zipCode.
	self assert: aProvince equals: anAddress province! !

!ImportTest methodsFor: 'assertions' stamp: 'TS 6/26/2023 01:21:42'!
assertQueryHasSingleResult: aQueryBlock

	| queryResult |
	queryResult := aQueryBlock value.

	self assert: 1 equals: queryResult size.
	^ queryResult anyOne! !

!ImportTest methodsFor: 'assertions' stamp: 'TS 6/26/2023 01:39:05'!
assertSessionHas: anAmount objectsOfType: aType 

	^ self assert: anAmount equals: (session selectAllOfType: aType) size! !

!ImportTest methodsFor: 'assertions' stamp: 'TS 6/26/2023 01:28:56'!
assertSessionHasAddressOf: aCustomer
atStreet: aStreetName
withNumber: aStreetNumber
atTown: aTown
withZipCode: aZipCode
atProvince: aProvince

	| customerAddress sessionAddress |

	"Asumimos que el nombre de calle se puede usar como clave primaria"
	sessionAddress := self assertQueryHasSingleResult: [ self selectAddressOfStreet: aStreetName ].

	self
		assertAddress: sessionAddress
		hasNumber: aStreetNumber
		atTown: aTown
		withZipCode: aZipCode
		atProvince: aProvince.

	customerAddress := aCustomer addressAtStreet: aStreetName ifNone: [self fail].
	
	self assert: customerAddress equals: sessionAddress.
! !

!ImportTest methodsFor: 'assertions' stamp: 'TS 6/26/2023 01:26:14'!
assertSessionHasCustomerWithId: anIdentificationNumber
ofType: anIdentificationType
withFirstName: aFirstName
andLastName: aLastName   

	| customer |
	customer :=  self assertQueryHasSingleResult: [		self selectCustomerWithId: anIdentificationNumber ofType: anIdentificationType ].
	self assert: aFirstName equals: customer firstName.
	self assert: aLastName equals: customer lastName.
	
	^ customer! !


!ImportTest methodsFor: 'tests' stamp: 'TS 6/26/2023 15:46:52'!
test01CustomersAndAdressesAreImportedCorrectly

	|  customerJuan customerPepe |

	self importCustomersFromStream: (self inputStreamWithLines: {
		'C,Pepe,Sanchez,D,22333444'.
		'A,San Martin,3322,Olivos,1636,BsAs'.
		'A,Maipu,888,Florida,1122,Buenos Aires'.
		'C,Juan,Perez,C,23-25666777-9'.
		'A,Alem,1122,CABA,1001,CABA'
	}).

	self assertSessionHas: 2 objectsOfType: Customer.
	self assertSessionHas: 3 objectsOfType: Address.

	customerPepe := self
		assertSessionHasCustomerWithId: '22333444'
		ofType: 'D'
		withFirstName: 'Pepe'andLastName: 'Sanchez'.
	
	self
		assertSessionHasAddressOf: customerPepe
		atStreet: 'San Martin'
		withNumber: 3322
		atTown: 'Olivos'
		withZipCode: 1636
		atProvince: 'BsAs'.

	self
		assertSessionHasAddressOf: customerPepe
		atStreet: 'Maipu'
		withNumber: 888
		atTown: 'Florida'
		withZipCode: 1122
		atProvince: 'Buenos Aires'.

	customerJuan := self
		assertSessionHasCustomerWithId: '23-25666777-9'
		ofType: 'C'
		withFirstName: 'Juan'
		andLastName: 'Perez'.

	self
		assertSessionHasAddressOf: customerJuan
		atStreet: 'Alem'
		withNumber: 1122
		atTown: 'CABA'
		withZipCode: 1001
		atProvince: 'CABA'
! !


!ImportTest methodsFor: 'queries' stamp: 'TS 6/26/2023 01:20:30'!
selectAddressOfStreet: aStreetName

	^ session		select: [:anAddress | anAddress streetName = aStreetName	] ofType: Address! !

!ImportTest methodsFor: 'queries' stamp: 'TS 6/26/2023 01:19:35'!
selectCustomerWithId: anIdentificationNumber ofType: anIdentificationType

	^ session select: [:customer |
		customer identificationType = anIdentificationType
			and: [customer identificationNumber = anIdentificationNumber]
	] ofType: Customer! !


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


!Address methodsFor: 'town' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'town' stamp: 'HAW 5/22/2022 00:19:29'!
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

!Customer methodsFor: 'addresses' stamp: 'TS 6/26/2023 01:28:22'!
addressAtStreet: aStreetName ifNone: aFailureBlock  

	^ addresses detect: [ :anAddress | anAddress streetName = aStreetName ] ifNone: aFailureBlock! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


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
	instanceVariableNames: 'session inputStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'TS 6/26/2023 01:34:55'!
initializeFrom: aStream to: aSession
	session := aSession.
	inputStream := aStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'TS 6/26/2023 01:34:55'!
import

	| newCustomer line |

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer ifNotNil: [session persistAddressesOf: newCustomer].
			newCustomer := Customer new.
			newCustomer firstName: customerData second.	
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth ].

		line := inputStream nextLine. ].
	
	session persistAddressesOf: newCustomer.

	inputStream close! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'TS 6/26/2023 01:34:55'!
from: aStream to: aSession
	^self new initializeFrom: aStream to: aSession! !


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
