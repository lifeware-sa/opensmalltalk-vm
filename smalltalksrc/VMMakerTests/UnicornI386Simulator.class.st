Class {
	#name : #UnicornI386Simulator,
	#superclass : #UnicornSimulator,
	#category : #'VMMakerTests-Unicorn'
}

{ #category : #registers }
UnicornI386Simulator >> arg0Register [
	
	^ UcX86Registers esi
]

{ #category : #registers }
UnicornI386Simulator >> baseRegister [

	^ UcX86Registers ebx
]

{ #category : #registers }
UnicornI386Simulator >> classRegister [

	^ UcX86Registers ecx
]

{ #category : #'as yet unclassified' }
UnicornI386Simulator >> createUnicorn [

	^ Unicorn x86
]

{ #category : #disassembling }
UnicornI386Simulator >> disassembler [
	
	^ LLVMDisassembler i386
]

{ #category : #accessing }
UnicornI386Simulator >> eax [
	
	^ self readRegister: UcX86Registers eax
]

{ #category : #accessing }
UnicornI386Simulator >> ebp [
	^ self readRegister: UcX86Registers ebp
]

{ #category : #'as yet unclassified' }
UnicornI386Simulator >> ebp: anInteger [ 
	
	self framePointerRegisterValue: anInteger
]

{ #category : #accessing }
UnicornI386Simulator >> ebx [
	
	^ self readRegister: UcX86Registers ebx
]

{ #category : #accessing }
UnicornI386Simulator >> ecx [
	^ self readRegister: UcX86Registers ecx
]

{ #category : #accessing }
UnicornI386Simulator >> edi [
	
	^ self readRegister: UcX86Registers edi
]

{ #category : #accessing }
UnicornI386Simulator >> edx [
	^ self readRegister: UcX86Registers edx
]

{ #category : #registers }
UnicornI386Simulator >> edx: anInteger [ 
	
	^ self writeRegister: UcX86Registers edx value: anInteger
]

{ #category : #registers }
UnicornI386Simulator >> eip [
	
	^ self readRegister: UcX86Registers eip
]

{ #category : #accessing }
UnicornI386Simulator >> esi [
	
	^ self readRegister: UcX86Registers esi
]

{ #category : #accessing }
UnicornI386Simulator >> esp [
	
	^ self readRegister: UcX86Registers esp
]

{ #category : #'as yet unclassified' }
UnicornI386Simulator >> esp: anInteger [ 
	
	self stackPointerRegisterValue: anInteger
]

{ #category : #'as yet unclassified' }
UnicornI386Simulator >> extractDestinationRegisterFromAssembly: aLLVMInstruction [ 
	
	| registerName |
	registerName := (aLLVMInstruction assemblyCodeString substrings: ',') last trimBoth.
	(registerName beginsWith: '%')
		ifTrue: [ registerName := registerName allButFirst ].
	^ registerName
]

{ #category : #'as yet unclassified' }
UnicornI386Simulator >> fp [
	^ self readRegister: UcX86Registers ebp
]

{ #category : #registers }
UnicornI386Simulator >> framePointerRegister [
	
	^ UcX86Registers ebp
]

{ #category : #accessing }
UnicornI386Simulator >> getReturnAddress [
	
	^ self peekAddress
]

{ #category : #registers }
UnicornI386Simulator >> instructionPointerRegister [
	
	^ UcX86Registers eip
]

{ #category : #registers }
UnicornI386Simulator >> receiverRegister [
	
	^ UcX86Registers edx
]

{ #category : #accessing }
UnicornI386Simulator >> registerList [
	
	^ #(eip eax ebx ecx edx esp ebp esi edi)
]

{ #category : #registers }
UnicornI386Simulator >> sendNumberOfArgumentsRegister [

	^ UcX86Registers ebx
]

{ #category : #'as yet unclassified' }
UnicornI386Simulator >> sp [
	^ self readRegister: UcX86Registers esp
]

{ #category : #registers }
UnicornI386Simulator >> stackPointerRegister [
	
	^ UcX86Registers esp
]

{ #category : #accessing }
UnicornI386Simulator >> wordSize [
	
	^ 4
]
