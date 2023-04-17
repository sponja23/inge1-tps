!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo negativeOneHalf'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:08:06'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:48'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:55'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:04'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:25'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'SG 4/15/2023 15:51:23'!
test07FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := Fraccion with: (Entero with: 7) over: (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:11:26'!
test08FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'SG 4/15/2023 15:51:37'!
test09AparentFraccionesAreEqual

	self assert: oneHalf equals: (Fraccion with: two over: four)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:12:46'!
test10AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:26:23'!
test11MultiplyingFraccionesCanReturnAnEntero

	self assert: (twoFifth) * (fiveHalfs) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:21'!
test12AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:30'!
test13AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:14:16'!
test14NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/24/2020 02:23:47'!
test15NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'SG 4/15/2023 15:51:57'!
test16SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (Fraccion with: negativeOne over: negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'SG 4/15/2023 15:52:03'!
test17SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (Fraccion with: one over: negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'SG 4/15/2023 16:03:01'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := Fraccion with: one over: two.
	oneFifth := Fraccion with: one over: five.
	twoFifth := Fraccion with: two over: five.
	twoTwentyfifth := Fraccion with: two over: (Entero with: 25).
	fiveHalfs := Fraccion with: five over: two.
	negativeOneHalf := Fraccion with: negativeOne over: two
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'TS 4/17/2023 15:34:58'!
* aMultiplier 

	self subclassResponsibility! !

!Numero methodsFor: 'arithmetic operations' stamp: 'TS 4/17/2023 15:35:01'!
+ anAdder 

	self subclassResponsibility! !

!Numero methodsFor: 'arithmetic operations' stamp: 'TS 4/17/2023 15:35:08'!
// aDivisor

	self error: 'Tipo de número no soportado'! !

!Numero methodsFor: 'arithmetic operations' stamp: 'TS 4/17/2023 15:35:11'!
addToEntero: anEnteroAdder

	self error: 'Tipo de número no soportado'! !

!Numero methodsFor: 'arithmetic operations' stamp: 'TS 4/17/2023 15:35:14'!
addToFraccion: aFraccionAdder

	self error: 'Tipo de número no soportado'! !

!Numero methodsFor: 'arithmetic operations' stamp: 'TS 4/17/2023 15:35:17'!
greatestCommonDivisorWith: anEntero

	self error: 'Tipo de número no soportado'! !

!Numero methodsFor: 'arithmetic operations' stamp: 'TS 4/17/2023 15:35:20'!
multiplyToEntero: anEnteroMultiplier

	self error: 'Tipo de número no soportado'! !

!Numero methodsFor: 'arithmetic operations' stamp: 'TS 4/17/2023 15:35:22'!
multiplyToFraccion: aFraccion

	self error: 'Tipo de número no soportado'! !

!Numero methodsFor: 'arithmetic operations' stamp: 'TS 4/17/2023 15:35:26'!
negated

	self subclassResponsibility! !

!Numero methodsFor: 'arithmetic operations' stamp: 'TS 4/17/2023 15:35:29'!
printOn: aStream

	self subclassResponsibility! !


!Numero methodsFor: 'testing' stamp: 'TS 4/17/2023 15:34:52'!
isNegative
	
	self subclassResponsibility! !

!Numero methodsFor: 'testing' stamp: 'TS 4/17/2023 15:34:49'!
isOne

	self subclassResponsibility! !

!Numero methodsFor: 'testing' stamp: 'TS 4/17/2023 15:34:55'!
isZero

	self subclassResponsibility! !


!Numero methodsFor: 'comparing' stamp: 'SG 4/15/2023 20:40:22'!
= anObject
	self subclassResponsibility ! !

!Numero methodsFor: 'comparing' stamp: 'TS 4/17/2023 15:38:40'!
hash

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:49:48'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'showing' stamp: 'TS 4/17/2023 15:37:14'!
printOn: aStream

	 aStream print: value! !


!Entero methodsFor: 'testing' stamp: 'TS 4/17/2023 15:36:53'!
isNegative

	 ^value < 0! !

!Entero methodsFor: 'testing' stamp: 'TS 4/17/2023 15:36:58'!
isOne

	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'TS 4/17/2023 15:37:01'!
isZero

	^value = 0! !


!Entero methodsFor: 'arithmetic operations' stamp: 'TS 4/17/2023 15:35:35'!
* aMultiplier

	^aMultiplier multiplyToEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'SG 4/15/2023 19:49:19'!
+ anAdder

	^anAdder addToEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TS 4/17/2023 15:35:47'!
// aDivisor

	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TS 4/17/2023 15:36:24'!
addToEntero: anEnteroAdder

	^self class with: value + anEnteroAdder integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TS 4/17/2023 15:36:27'!
greatestCommonDivisorWith: anEntero

	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'SG 4/15/2023 19:58:55'!
multiplyToEntero: anEnteroMultiplier
	
	^self class with: value * anEnteroMultiplier integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TS 4/17/2023 15:37:07'!
negated

	 ^self * (self class with: -1)! !


!Entero methodsFor: 'initialization' stamp: 'TS 4/17/2023 15:36:11'!
initializeWith: aValue

	value := aValue! !


!Entero methodsFor: 'accessing' stamp: 'SG 4/15/2023 20:12:09'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'comparing' stamp: 'TS 4/17/2023 15:35:56'!
= anObject

	^ (anObject isKindOf: self class) and: [value = anObject integerValue]! !

!Entero methodsFor: 'comparing' stamp: 'TS 4/17/2023 15:36:35'!
hash

	^value hash! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'SG 4/15/2023 20:07:27'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^self new initializeWith: aValue! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'showing' stamp: 'TS 4/17/2023 15:38:21'!
printOn: aStream

	 aStream 
			print: numerator;
			nextPut: $/;
			print: denominator! !


!Fraccion methodsFor: 'testing' stamp: 'TS 4/17/2023 15:37:54'!
isNegative 

	^denominator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'TS 4/17/2023 15:37:44'!
isOne

	^false! !

!Fraccion methodsFor: 'testing' stamp: 'TS 4/17/2023 15:37:41'!
isZero

	^false! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'TS 4/17/2023 15:37:20'!
* aMultiplier

	^ aMultiplier multiplyToFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TS 4/17/2023 15:37:23'!
+ anAdder

	^anAdder addToFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TS 4/17/2023 15:37:29'!
addToFraccion: aFraccionAdder

	| newNumerator newDenominator |

	newNumerator := (numerator * aFraccionAdder denominator) + (denominator * aFraccionAdder numerator).
	newDenominator := denominator * aFraccionAdder denominator.

	^ self class with: newNumerator over: newDenominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TS 4/17/2023 15:37:33'!
multiplyToFraccion: aFraccionMultiplier

	^self class with: (numerator * aFraccionMultiplier numerator) over: (denominator * aFraccionMultiplier denominator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TS 4/17/2023 15:37:36'!
negated

	^self class with: numerator * (Entero with: -1) over: denominator! !


!Fraccion methodsFor: 'initialization' stamp: 'SG 4/17/2023 10:12:25'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].

	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'accessing' stamp: 'SG 4/15/2023 09:17:53'!
denominator

	^denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'TS 4/17/2023 15:38:10'!
numerator

	^numerator! !


!Fraccion methodsFor: 'comparing' stamp: 'SG 4/15/2023 20:39:53'!
= anObject
	 ^(anObject isKindOf: self class) and: 
	[(numerator * anObject denominator) = (denominator * anObject numerator)]! !

!Fraccion methodsFor: 'comparing' stamp: 'SG 4/15/2023 09:22:15'!
hash
	^(numerator hash / denominator hash) hash ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'instance creation' stamp: 'SG 4/15/2023 20:08:13'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue: [ ^self with: aDividend negated over: aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator! !
