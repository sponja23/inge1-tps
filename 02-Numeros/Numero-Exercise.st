!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
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
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'TS 4/18/2023 15:31:17'!
* aMultiplier 
	
	^aMultiplier multiplyToEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TS 4/18/2023 15:21:27'!
+ anAdder 
	
	^anAdder addToEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TS 4/18/2023 15:43:16'!
- aSubtrahend 
	
	^aSubtrahend subtractFromEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TS 4/18/2023 15:51:24'!
/ aDivisor 

	^aDivisor divideFromEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TS 4/19/2023 15:58:53'!
// aDivisor

	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TS 4/19/2023 15:58:59'!
addToEntero: anEnteroAdder

	^self class with: anEnteroAdder integerValue + value! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TS 4/19/2023 16:49:13'!
addToFraccion: aFraccionAdder

	"Gracias a la conmutatividad de la suma, se puede utilizar el mensaje 'addToEntero:' de Fraccion"

	^aFraccionAdder addToEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TS 4/18/2023 15:49:08'!
divideFromEntero: anEnteroDividend 

	^Fraccion with: anEnteroDividend over: self.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TS 4/18/2023 15:53:15'!
divideFromFraccion: aFraccionDividend

	^Fraccion with: aFraccionDividend numerator over: self * aFraccionDividend denominator! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TS 4/19/2023 16:07:40'!
fibonacci

	self subclassResponsibility! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TS 4/19/2023 15:59:06'!
greatestCommonDivisorWith: anEntero 

	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TS 4/19/2023 15:57:47'!
multiplyToEntero: anEnteroMultiplier

	^self class with: anEnteroMultiplier integerValue * value! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TS 4/19/2023 16:49:00'!
multiplyToFraccion: aFraccionMultiplier

	"Gracias a la conmutatividad de la multiplicación, se puede utilizar el mensaje 'multiplyToEntero:' de Fraccion"

	^aFraccionMultiplier multiplyToEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TS 4/19/2023 15:59:15'!
subtractFromEntero: anEnteroMinuend

	^self class with: anEnteroMinuend integerValue - value! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TS 4/18/2023 15:47:39'!
subtractFromFraccion: aFraccionMinuend

	| newNumerator |
		
	newNumerator := aFraccionMinuend numerator - (self  * aFraccionMinuend denominator).

	^newNumerator / aFraccionMinuend denominator.! !


!Entero methodsFor: 'comparing' stamp: 'TS 4/19/2023 15:23:25'!
= anObject

	^(anObject isKindOf: self class) and: [value = anObject integerValue]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'TS 4/19/2023 16:43:27'!
initializeWith: aValue 

	self assert: (self class isValidValue: aValue).

	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'TS 4/19/2023 16:39:30'!
isNegative
	
	self subclassResponsibility! !

!Entero methodsFor: 'testing' stamp: 'TS 4/19/2023 16:40:55'!
isOne
	
	self subclassResponsibility! !

!Entero methodsFor: 'testing' stamp: 'TS 4/19/2023 16:41:02'!
isZero
	
	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'TS 4/18/2023 16:16:05'!
isValidValue: aValue

	self subclassResponsibility! !

!Entero class methodsFor: 'instance creation' stamp: 'TS 4/19/2023 16:01:11'!
with: aValue 
	
	| handlingClass |
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].

	"
	Esta instancia aislada del 'síndrome maradoniano' (Entero se nombra a sí mismo) es necesaria para que, cuando las subclases
	envíen el mensaje 'self class with:', se busque la subclase apropiada para crear la nueva instancia.
	"
	handlingClass := Entero subclasses detect: [ :anEnteroSubclass | anEnteroSubclass isValidValue: aValue ].

	^handlingClass new initializeWith: aValue! !


!Entero class methodsFor: 'error descriptions' stamp: 'TS 4/19/2023 16:08:36'!
negativeFibonacciErrorDescription

	^'Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !


!classDefinition: #Cero category: 'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'arithmetic operations' stamp: 'TS 4/19/2023 16:21:44'!
asDivisorInFraccionWithDividend: aDividend

	self error: Numero canNotDivideByZeroErrorDescription! !

!Cero methodsFor: 'arithmetic operations' stamp: 'TS 4/19/2023 16:35:42'!
asNumeratorInFraccionWithDenominatorGreaterThanOne: anEnteroMayorAUno

	^self! !

!Cero methodsFor: 'arithmetic operations' stamp: 'TS 4/19/2023 16:05:09'!
fibonacci

	^Entero with: 1! !


!Cero methodsFor: 'testing' stamp: 'TS 4/19/2023 16:40:02'!
isNegative
	
	^false! !

!Cero methodsFor: 'testing' stamp: 'TS 4/19/2023 16:39:57'!
isOne
	
	^false! !

!Cero methodsFor: 'testing' stamp: 'TS 4/19/2023 16:39:54'!
isZero
	
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: 'Numero-Exercise'!
Cero class
	instanceVariableNames: ''!

!Cero class methodsFor: 'initialization' stamp: 'TS 4/19/2023 15:46:23'!
isValidValue: aValue

	^aValue = 0! !


!classDefinition: #EnteroMayorAUno category: 'Numero-Exercise'!
Entero subclass: #EnteroMayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroMayorAUno methodsFor: 'arithmetic operations' stamp: 'TS 4/19/2023 16:38:39'!
asDenominatorInReducedFraccionWithNumerator: aNumerator

	^aNumerator asNumeratorInFraccionWithDenominatorGreaterThanOne: self! !

!EnteroMayorAUno methodsFor: 'arithmetic operations' stamp: 'TS 4/19/2023 16:31:01'!
asDivisorInFraccionWithDividend: aDividend

	| denominator greatestCommonDivisor numerator |

	greatestCommonDivisor := aDividend greatestCommonDivisorWith: self.
	numerator := aDividend // greatestCommonDivisor.
	denominator := self // greatestCommonDivisor.
	
	^denominator asDenominatorInReducedFraccionWithNumerator: numerator.! !

!EnteroMayorAUno methodsFor: 'arithmetic operations' stamp: 'TS 4/19/2023 16:35:23'!
asNumeratorInFraccionWithDenominatorGreaterThanOne: anEnteroMayorAUno

	^Fraccion new initializeWith: self over: anEnteroMayorAUno! !

!EnteroMayorAUno methodsFor: 'arithmetic operations' stamp: 'TS 4/19/2023 16:07:16'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^(self - one) fibonacci + (self - two) fibonacci! !


!EnteroMayorAUno methodsFor: 'testing' stamp: 'TS 4/19/2023 16:40:15'!
isNegative
	
	^false! !

!EnteroMayorAUno methodsFor: 'testing' stamp: 'TS 4/19/2023 16:40:11'!
isOne
	
	^false! !

!EnteroMayorAUno methodsFor: 'testing' stamp: 'TS 4/19/2023 16:40:08'!
isZero
	
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroMayorAUno class' category: 'Numero-Exercise'!
EnteroMayorAUno class
	instanceVariableNames: ''!

!EnteroMayorAUno class methodsFor: 'initialization' stamp: 'TS 4/19/2023 15:27:29'!
isValidValue: aValue

	^aValue > 1! !


!classDefinition: #EnteroNegativo category: 'Numero-Exercise'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'TS 4/19/2023 16:21:26'!
asDivisorInFraccionWithDividend: aDividend

	^aDividend negated / self negated.! !

!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'TS 4/19/2023 16:35:31'!
asNumeratorInFraccionWithDenominatorGreaterThanOne: anEnteroMayorAUno

	^Fraccion new initializeWith: self over: anEnteroMayorAUno! !

!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'TS 4/19/2023 16:09:13'!
fibonacci

	self error: Entero negativeFibonacciErrorDescription! !


!EnteroNegativo methodsFor: 'testing' stamp: 'TS 4/19/2023 16:40:22'!
isNegative
	
	^true! !

!EnteroNegativo methodsFor: 'testing' stamp: 'TS 4/19/2023 16:40:30'!
isOne
	
	^false! !

!EnteroNegativo methodsFor: 'testing' stamp: 'TS 4/19/2023 16:40:32'!
isZero
	
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroNegativo class' category: 'Numero-Exercise'!
EnteroNegativo class
	instanceVariableNames: ''!

!EnteroNegativo class methodsFor: 'initialization' stamp: 'TS 4/19/2023 15:23:55'!
isValidValue: aValue

	^aValue < 0! !


!classDefinition: #Uno category: 'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'arithmetic operations' stamp: 'TS 4/19/2023 16:31:52'!
asDenominatorInReducedFraccionWithNumerator: aNumerator

	^aNumerator! !

!Uno methodsFor: 'arithmetic operations' stamp: 'TS 4/19/2023 16:23:41'!
asDivisorInFraccionWithDividend: aDividend

	^aDividend! !

!Uno methodsFor: 'arithmetic operations' stamp: 'TS 4/19/2023 16:35:35'!
asNumeratorInFraccionWithDenominatorGreaterThanOne: anEnteroMayorAUno

	^Fraccion new initializeWith: self over: anEnteroMayorAUno! !

!Uno methodsFor: 'arithmetic operations' stamp: 'TS 4/19/2023 16:04:37'!
fibonacci

	^self! !


!Uno methodsFor: 'testing' stamp: 'TS 4/19/2023 16:40:47'!
isNegative
	
	^false! !

!Uno methodsFor: 'testing' stamp: 'TS 4/19/2023 16:40:42'!
isOne
	
	^true! !

!Uno methodsFor: 'testing' stamp: 'TS 4/19/2023 16:40:37'!
isZero
	
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Uno class' category: 'Numero-Exercise'!
Uno class
	instanceVariableNames: ''!

!Uno class methodsFor: 'initialization' stamp: 'TS 4/19/2023 15:27:51'!
isValidValue: aValue

	^aValue = 1! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TS 4/18/2023 15:37:27'!
* aMultiplier
	
	^aMultiplier multiplyToFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TS 4/18/2023 15:29:00'!
+ anAdder 
	
	^anAdder addToFraccion: self

	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TS 4/18/2023 15:48:07'!
- aSubtrahend 
	
	^aSubtrahend subtractFromFraccion: self
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TS 4/18/2023 15:53:34'!
/ aDivisor 
	
	^aDivisor divideFromFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TS 4/18/2023 15:21:01'!
addToEntero: anEnteroAdder

	| newNumerator |

	newNumerator := anEnteroAdder * self denominator + self numerator.

	^newNumerator / self denominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TS 4/18/2023 15:25:28'!
addToFraccion: aFraccionAdder

	| newNumerator newDenominator |
		
	newNumerator := (aFraccionAdder numerator * denominator) + (aFraccionAdder denominator * numerator).
	newDenominator := aFraccionAdder denominator * denominator.
	
	^newNumerator / newDenominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TS 4/18/2023 15:51:05'!
divideFromEntero: anEnteroDividend

	^Fraccion with: anEnteroDividend * denominator over: numerator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TS 4/18/2023 15:52:11'!
divideFromFraccion: aFraccionDividend

	^(aFraccionDividend numerator * denominator) / (aFraccionDividend denominator * numerator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TS 4/18/2023 15:31:52'!
multiplyToEntero: anEnteroMultiplier

	^anEnteroMultiplier * self numerator / self denominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TS 4/18/2023 15:35:36'!
multiplyToFraccion: aFraccionMultiplier

	^(aFraccionMultiplier numerator * numerator) / (aFraccionMultiplier denominator * denominator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TS 4/18/2023 15:42:48'!
subtractFromEntero: anEnteroMinuend
	| newNumerator |

	newNumerator := anEnteroMinuend * denominator - numerator.

	^newNumerator / denominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TS 4/18/2023 15:46:37'!
subtractFromFraccion: aFraccionMinuend
	| newNumerator newDenominator |

	newNumerator := (aFraccionMinuend numerator * denominator) - (aFraccionMinuend denominator * numerator).
	newDenominator := aFraccionMinuend denominator * denominator.

	^newNumerator / newDenominator! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'TS 4/19/2023 16:44:44'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones están por si se comenten errores en la implementacián - Hernán"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].

	numerator := aNumerator.
	denominator := aDenominator! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'instance creation' stamp: 'TS 4/19/2023 16:50:38'!
with: aDividend over: aDivisor

	^aDivisor asDivisorInFraccionWithDividend: aDividend! !
