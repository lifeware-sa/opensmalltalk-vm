Class {
	#name : #UnicornARMv5Simulator,
	#superclass : #UnicornSimulator,
	#category : #'VMMakerTests-Unicorn'
}

{ #category : #registers }
UnicornARMv5Simulator >> arg0Register [
	
	^ UcARMRegisters r3
]

{ #category : #registers }
UnicornARMv5Simulator >> baseRegister [

	^ UcARMRegisters r10
]

{ #category : #registers }
UnicornARMv5Simulator >> classRegister [
	
	^ UcARMRegisters r2
]

{ #category : #'as yet unclassified' }
UnicornARMv5Simulator >> createUnicorn [

	^ Unicorn arm
]

{ #category : #disassembling }
UnicornARMv5Simulator >> disassembler [
	
	^ LLVMDisassembler armv5
]

{ #category : #'as yet unclassified' }
UnicornARMv5Simulator >> extractDestinationRegisterFromAssembly: aLLVMInstruction [ 
	
	"In ARM, instructions are usually encoded asSpotterCandidateLink 
	
	INST Destination, Source
	"
	
	^ (aLLVMInstruction assemblyCodeString substrings: String tab, ',') second trimBoth.
]

{ #category : #registers }
UnicornARMv5Simulator >> fp [
	^ self readRegister: UcARMRegisters fp
]

{ #category : #registers }
UnicornARMv5Simulator >> framePointerRegister [
	
	^ UcARMRegisters fp
]

{ #category : #accessing }
UnicornARMv5Simulator >> getLastAddress: abstractInstructions [ 
	
	| last |
	last := (abstractInstructions reject: [ :e | e isLiteral ]) last.
	^ last address + last machineCodeSize 
]

{ #category : #accessing }
UnicornARMv5Simulator >> getReturnAddress [
	
	^ self linkRegisterValue
]

{ #category : #testing }
UnicornARMv5Simulator >> hasLinkRegister [
	^ true
]

{ #category : #registers }
UnicornARMv5Simulator >> instructionPointerRegister [

	^ UcARMRegisters pc
]

{ #category : #registers }
UnicornARMv5Simulator >> linkRegister [
	
	^ UcARMRegisters lr
]

{ #category : #accessing }
UnicornARMv5Simulator >> linkRegisterValue [

	^ self readRegister: self linkRegister 
]

{ #category : #registers }
UnicornARMv5Simulator >> linkRegisterValue: aValue [ 

	^ self writeRegister: self linkRegister value: aValue
]

{ #category : #registers }
UnicornARMv5Simulator >> lr [
	^ self readRegister: UcARMRegisters lr	
]

{ #category : #registers }
UnicornARMv5Simulator >> pc [
	^ self readRegister: UcARMRegisters pc
]

{ #category : #registers }
UnicornARMv5Simulator >> r0 [
	^ self readRegister: UcARMRegisters r0
]

{ #category : #registers }
UnicornARMv5Simulator >> r1 [
	^ self readRegister: UcARMRegisters r1
]

{ #category : #registers }
UnicornARMv5Simulator >> r10 [
	^ self readRegister: UcARMRegisters r10
]

{ #category : #'as yet unclassified' }
UnicornARMv5Simulator >> r10: anInteger [ 
	
	^ self writeRegister: UcARMRegisters r10 value: anInteger
]

{ #category : #'as yet unclassified' }
UnicornARMv5Simulator >> r11: anInteger [ 
	
	^ self writeRegister: UcARMRegisters r11 value: anInteger
]

{ #category : #'as yet unclassified' }
UnicornARMv5Simulator >> r1: anInteger [ 
	
	^ self writeRegister: UcARMRegisters r1 value: anInteger
]

{ #category : #registers }
UnicornARMv5Simulator >> r2 [
	^ self readRegister: UcARMRegisters r2
]

{ #category : #'as yet unclassified' }
UnicornARMv5Simulator >> r2: anInteger [ 
	
	^ self writeRegister: UcARMRegisters r2 value: anInteger
]

{ #category : #registers }
UnicornARMv5Simulator >> r3 [
	^ self readRegister: UcARMRegisters r3
]

{ #category : #'as yet unclassified' }
UnicornARMv5Simulator >> r3: anInteger [ 
	
	^ self writeRegister: UcARMRegisters r3 value: anInteger
]

{ #category : #registers }
UnicornARMv5Simulator >> r4 [
	^ self readRegister: UcARMRegisters r4
]

{ #category : #'as yet unclassified' }
UnicornARMv5Simulator >> r4: anInteger [ 
	
	^ self writeRegister: UcARMRegisters r4 value: anInteger
]

{ #category : #registers }
UnicornARMv5Simulator >> r5 [
	^ self readRegister: UcARMRegisters r5
]

{ #category : #'as yet unclassified' }
UnicornARMv5Simulator >> r5: anInteger [ 
	
	^ self writeRegister: UcARMRegisters r5 value: anInteger
]

{ #category : #registers }
UnicornARMv5Simulator >> r6 [
	^ self readRegister: UcARMRegisters r6
]

{ #category : #'as yet unclassified' }
UnicornARMv5Simulator >> r6: anInteger [ 
	
	^ self writeRegister: UcARMRegisters r6 value: anInteger
]

{ #category : #registers }
UnicornARMv5Simulator >> r7 [
	^ self readRegister: UcARMRegisters r7
]

{ #category : #'as yet unclassified' }
UnicornARMv5Simulator >> r7: anInteger [ 
	
	^ self writeRegister: UcARMRegisters r7 value: anInteger
]

{ #category : #registers }
UnicornARMv5Simulator >> r8 [
	^ self readRegister: UcARMRegisters r8
]

{ #category : #'as yet unclassified' }
UnicornARMv5Simulator >> r8: anInteger [ 
	
	^ self writeRegister: UcARMRegisters r8 value: anInteger
]

{ #category : #registers }
UnicornARMv5Simulator >> r9 [
	^ self readRegister: UcARMRegisters r9
]

{ #category : #'as yet unclassified' }
UnicornARMv5Simulator >> r9: anInteger [ 
	
	^ self writeRegister: UcARMRegisters r9 value: anInteger
]

{ #category : #registers }
UnicornARMv5Simulator >> receiverRegister [
	
	^ UcARMRegisters r5
]

{ #category : #accessing }
UnicornARMv5Simulator >> registerList [

	^ #(lr pc sp fp r0 r1 r2 r3 r4 r5 r6 r7 r8 r9)
]

{ #category : #registers }
UnicornARMv5Simulator >> sendNumberOfArgumentsRegister [
	
	^ UcARMRegisters r6
]

{ #category : #registers }
UnicornARMv5Simulator >> sp [
	^ self readRegister: UcARMRegisters sp
]

{ #category : #registers }
UnicornARMv5Simulator >> stackPointerRegister [
	
	^ UcARMRegisters sp
]

{ #category : #accessing }
UnicornARMv5Simulator >> wordSize [
	^ 4
]
