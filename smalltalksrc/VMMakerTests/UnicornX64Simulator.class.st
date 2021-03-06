Class {
	#name : #UnicornX64Simulator,
	#superclass : #UnicornSimulator,
	#category : #'VMMakerTests-Unicorn'
}

{ #category : #registers }
UnicornX64Simulator >> arg0Register [
	
	^ UcX86Registers rdi
]

{ #category : #'phisical-registers' }
UnicornX64Simulator >> baseRegister [

	^ UcX86Registers rbx
]

{ #category : #'virtual-registers' }
UnicornX64Simulator >> classRegister [
	
	^ UcX86Registers rcx
]

{ #category : #'as yet unclassified' }
UnicornX64Simulator >> createUnicorn [

	^ Unicorn x8664
]

{ #category : #disassembling }
UnicornX64Simulator >> disassembler [
	
	^ LLVMDisassembler amd64
]

{ #category : #'as yet unclassified' }
UnicornX64Simulator >> extractDestinationRegisterFromAssembly: aLLVMInstruction [ 
	
	| registerName |
	registerName := (aLLVMInstruction assemblyCodeString substrings: ',') last trimBoth.
	(registerName beginsWith: '%')
		ifTrue: [ registerName := registerName allButFirst ].
	^ registerName
]

{ #category : #'phisical-registers' }
UnicornX64Simulator >> fp [

	^ self rbp
]

{ #category : #'virtual-registers' }
UnicornX64Simulator >> framePointerRegister [
	
	^ UcX86Registers rbp
]

{ #category : #accessing }
UnicornX64Simulator >> getReturnAddress [
	
	^ self peekAddress 
]

{ #category : #initialization }
UnicornX64Simulator >> initializeRegisterAliases [

	registerAliases
		at: #rcx put: #classRegister;
		at: #rdx put: #receiverRegister;
		at: #r9 put: #sendNumberOfArgumentsRegister;
		at: #rbx put: #baseRegister;
		at: #rbp put: #framePointerRegister
]

{ #category : #'virtual-registers' }
UnicornX64Simulator >> instructionPointerRegister [
	
	^ UcX86Registers rip
]

{ #category : #'phisical-registers' }
UnicornX64Simulator >> r10 [

	^ self readRegister: UcX86Registers r10
]

{ #category : #'as yet unclassified' }
UnicornX64Simulator >> r10: anInteger [ 
	
	^ self writeRegister: UcX86Registers r10 value: anInteger
]

{ #category : #'phisical-registers' }
UnicornX64Simulator >> r11 [

	^ self readRegister: UcX86Registers r11
]

{ #category : #'as yet unclassified' }
UnicornX64Simulator >> r11: anInteger [ 
	
	^ self writeRegister: UcX86Registers r11 value: anInteger
]

{ #category : #'phisical-registers' }
UnicornX64Simulator >> r12 [

	^ self readRegister: UcX86Registers r12
]

{ #category : #'as yet unclassified' }
UnicornX64Simulator >> r12: anInteger [ 
	
	^ self writeRegister: UcX86Registers r12 value: anInteger
]

{ #category : #'as yet unclassified' }
UnicornX64Simulator >> r1: anInteger [ 
	
	^ self writeRegister: UcX86Registers r1 value: anInteger
]

{ #category : #'as yet unclassified' }
UnicornX64Simulator >> r2: anInteger [ 
	
	^ self writeRegister: UcX86Registers r2 value: anInteger
]

{ #category : #'as yet unclassified' }
UnicornX64Simulator >> r3: anInteger [ 
	
	^ self writeRegister: UcX86Registers r3 value: anInteger
]

{ #category : #'as yet unclassified' }
UnicornX64Simulator >> r4: anInteger [ 
	
	^ self writeRegister: UcX86Registers r4 value: anInteger
]

{ #category : #'as yet unclassified' }
UnicornX64Simulator >> r5: anInteger [ 
	
	^ self writeRegister: UcX86Registers r5 value: anInteger
]

{ #category : #'as yet unclassified' }
UnicornX64Simulator >> r6: anInteger [ 
	
	^ self writeRegister: UcX86Registers r6 value: anInteger
]

{ #category : #'as yet unclassified' }
UnicornX64Simulator >> r7: anInteger [ 
	
	^ self writeRegister: UcX86Registers r7 value: anInteger
]

{ #category : #'phisical-registers' }
UnicornX64Simulator >> r8 [

	^ self readRegister: UcX86Registers r8
]

{ #category : #'as yet unclassified' }
UnicornX64Simulator >> r8: anInteger [ 
	
	^ self writeRegister: UcX86Registers r8 value: anInteger
]

{ #category : #'phisical-registers' }
UnicornX64Simulator >> r9 [

	^ self readRegister: UcX86Registers r9
]

{ #category : #'as yet unclassified' }
UnicornX64Simulator >> r9: anInteger [ 
	
	^ self writeRegister: UcX86Registers r9 value: anInteger
]

{ #category : #'phisical-registers' }
UnicornX64Simulator >> rax [

	^ self readRegister: UcX86Registers rax
]

{ #category : #'phisical-registers' }
UnicornX64Simulator >> rbp [

	^ self readRegister: UcX86Registers rbp
]

{ #category : #'phisical-registers' }
UnicornX64Simulator >> rbp: anInteger [ 

	^ self writeRegister: UcX86Registers rbp value: anInteger
]

{ #category : #'phisical-registers' }
UnicornX64Simulator >> rbx [

	^ self readRegister: UcX86Registers rbx
]

{ #category : #'phisical-registers' }
UnicornX64Simulator >> rbx: aValue [

	^ self writeRegister: UcX86Registers rbx value: aValue
]

{ #category : #'phisical-registers' }
UnicornX64Simulator >> rcx [

	^ self readRegister: UcX86Registers rcx
]

{ #category : #'phisical-registers' }
UnicornX64Simulator >> rcx: anInteger [ 

	^ self writeRegister: UcX86Registers rcx value: anInteger
]

{ #category : #'phisical-registers' }
UnicornX64Simulator >> rdi [

	^ self readRegister: UcX86Registers rdi
]

{ #category : #'phisical-registers' }
UnicornX64Simulator >> rdx [

	^ self readRegister: UcX86Registers rdx
]

{ #category : #'phisical-registers' }
UnicornX64Simulator >> rdx: anInteger [ 

	^ self writeRegister: UcX86Registers rdx value: anInteger
]

{ #category : #'virtual-registers' }
UnicornX64Simulator >> receiverRegister [
	
	^ UcX86Registers rdx
]

{ #category : #accessing }
UnicornX64Simulator >> registerList [
	
	^ #(rip rax rbx rcx rdx rsp rbp r8 r9 r10 r11 r12 rsi rdi)
]

{ #category : #'phisical-registers' }
UnicornX64Simulator >> rip [

	^ self readRegister: UcX86Registers rip
]

{ #category : #'phisical-registers' }
UnicornX64Simulator >> rsi [

	^ self readRegister: UcX86Registers rsi
]

{ #category : #'phisical-registers' }
UnicornX64Simulator >> rsp [

	^ self readRegister: UcX86Registers rsp
]

{ #category : #'phisical-registers' }
UnicornX64Simulator >> rsp: anInteger [ 
	
	^ self writeRegister: UcX86Registers rsp value: anInteger
]

{ #category : #'virtual-registers' }
UnicornX64Simulator >> sendNumberOfArgumentsRegister [
	
	^ UcX86Registers r9
]

{ #category : #'phisical-registers' }
UnicornX64Simulator >> sp [

	^ self rsp
]

{ #category : #'virtual-registers' }
UnicornX64Simulator >> stackPointerRegister [

	^ UcX86Registers rsp
]

{ #category : #accessing }
UnicornX64Simulator >> wordSize [
	
	^ 8
]
