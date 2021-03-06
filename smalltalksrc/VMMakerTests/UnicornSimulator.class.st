Class {
	#name : #UnicornSimulator,
	#superclass : #Object,
	#instVars : [
		'unicorn',
		'stopReason',
		'memory',
		'registerAliases'
	],
	#category : #'VMMakerTests-Unicorn'
}

{ #category : #'instance creation' }
UnicornSimulator class >> ARMv5 [
	
	^ UnicornARMv5Simulator new
]

{ #category : #'instance creation' }
UnicornSimulator class >> ARMv8 [
	
	^ UnicornARMv8Simulator new
]

{ #category : #'instance creation' }
UnicornSimulator class >> IA32 [

	^ UnicornI386Simulator new
]

{ #category : #'instance creation' }
UnicornSimulator class >> X64 [
	
	^ UnicornX64Simulator new
]

{ #category : #'instance creation' }
UnicornSimulator class >> aarch64 [
	
	^ UnicornARMv8Simulator new
]

{ #category : #accessing }
UnicornSimulator >> aliasForRegister: aRegisterName [

	^ registerAliases at: aRegisterName ifAbsent: [ '' ]
]

{ #category : #registers }
UnicornSimulator >> arg0Register [
	
	^ self subclassResponsibility 
]

{ #category : #registers }
UnicornSimulator >> arg0RegisterValue [
	
	^ self readRegister: self arg0Register 
]

{ #category : #registers }
UnicornSimulator >> arg0RegisterValue: aValue [

	^ self writeRegister: self arg0Register value: aValue
]

{ #category : #registers }
UnicornSimulator >> baseRegister [

	^ self subclassResponsibility
]

{ #category : #registers }
UnicornSimulator >> baseRegisterValue [
	
	^ self readRegister: self baseRegister
]

{ #category : #registers }
UnicornSimulator >> baseRegisterValue: aValue [
	
	^ self writeRegister: self baseRegister value: aValue
]

{ #category : #registers }
UnicornSimulator >> classRegister [
	
	^ self subclassResponsibility
]

{ #category : #registers }
UnicornSimulator >> classRegisterValue [
	
	^ self readRegister: self classRegister
]

{ #category : #registers }
UnicornSimulator >> classRegisterValue: aValue [
	
	^ self writeRegister: self classRegister value: aValue
]

{ #category : #accessing }
UnicornSimulator >> cogit [

	^ memory interpreter cogit
]

{ #category : #initialization }
UnicornSimulator >> createUnicorn [

	self subclassResponsibility
]

{ #category : #disassembling }
UnicornSimulator >> disassembleCurrentInstruction [
	
	^ (self disassembleFrom: self instructionPointerValue opcodes: 1) first
]

{ #category : #disassembling }
UnicornSimulator >> disassembleFrom: anIndex opcodes: numberOfInstructions [

	^ self disassembler
		printImmediatesInHexa;
		disassembleNext: numberOfInstructions
		instructionsIn: (memory memory copyFrom: anIndex)
		startAddress: anIndex
		pc: self instructionPointerValue
]

{ #category : #disassembling }
UnicornSimulator >> disassembler [
	self subclassResponsibility
]

{ #category : #executing }
UnicornSimulator >> doStartAt: startAddress until: until timeout: timeout count: count [

	| actualCount result error |

	actualCount := 0.
	self instructionPointerValue: startAddress.

	[ true ]
		whileTrue: [ 
			[result :=  unicorn
				startAt: self instructionPointerValue
				until: 0
				timeout: 0
				count: 1.
					
				stopReason ifNotNil: [ 
						error := stopReason.
						stopReason := nil.
						error signal ].
		
			"If execution did not stop because of a stop reason, verify the error code"
			unicorn verifyErrorCode: result.

			
					actualCount := actualCount + 1] 
				on: UnicornInvalidMemoryAccess do: [ :invalidAccess |
					self instructionPointerValue = until ifTrue: [ ^ 0 ].
					self cogit handleSimulationTrap: (UnicornSimulationTrap simulator: self error: invalidAccess).
					actualCount := actualCount + 1 ].
			
			stopReason ifNotNil: [ ^ result ].
			count = actualCount ifTrue: [ ^ result ].
			self instructionPointerValue = until ifTrue: [ ^ result ]]
]

{ #category : #disassembling }
UnicornSimulator >> extractDestinationRegisterFromAssembly: aLLVMInstruction [ 
	
	self subclassResponsibility
]

{ #category : #registers }
UnicornSimulator >> framePointerRegister [
	
	^ self subclassResponsibility
]

{ #category : #registers }
UnicornSimulator >> framePointerRegisterValue [

	^ self readRegister: self framePointerRegister
]

{ #category : #registers }
UnicornSimulator >> framePointerRegisterValue: aValue [
	
	self writeRegister: self framePointerRegister value: aValue
]

{ #category : #accessing }
UnicornSimulator >> getLastAddress: abstractInstructions [ 

	^ abstractInstructions last address + abstractInstructions last machineCodeSize
]

{ #category : #testing }
UnicornSimulator >> hasLinkRegister [
	^ false
]

{ #category : #initialization }
UnicornSimulator >> initialize [

	super initialize.
	unicorn := self createUnicorn.
	self initializeUnicorn.
	
	registerAliases := Dictionary new.
	self initializeRegisterAliases.
]

{ #category : #initialization }
UnicornSimulator >> initializeRegisterAliases [

	"Hook for subclasses"
]

{ #category : #initialization }
UnicornSimulator >> initializeUnicorn [

	unicorn
		registerInvalidMemoryAccessHook: UcHookType invalidMemoryAccess value 
		doing: [ :type :address :size :value | 
			unicorn stop.
			stopReason := UnicornInvalidMemoryAccess new
				type: type;
				address: address;
				size: size;
				value: value;
				yourself.
			false ]
]

{ #category : #registers }
UnicornSimulator >> instructionPointerRegister [

	^ self subclassResponsibility
]

{ #category : #registers }
UnicornSimulator >> instructionPointerValue [
	
	^ self readRegister: self instructionPointerRegister
]

{ #category : #registers }
UnicornSimulator >> instructionPointerValue: aValue [
	
	^ self writeRegister: self instructionPointerRegister value: aValue
]

{ #category : #memory }
UnicornSimulator >> mapMemory: aMemory at: anAddress [

	unicorn
		mapHostMemory: aMemory
		atAddress: anAddress
		withPermissions: UnicornConstants permissionAll.
]

{ #category : #accessing }
UnicornSimulator >> memory: aSpur64BitMMLECoSimulator [
	
	memory := aSpur64BitMMLECoSimulator 
]

{ #category : #memory }
UnicornSimulator >> memoryAt: address readNext: byteSize [
	
	^ unicorn memoryAt: address readNext: byteSize
]

{ #category : #memory }
UnicornSimulator >> memoryAt: address write: bytes size: size [

	unicorn memoryAt: address write: bytes size: size
]

{ #category : #'helpers - stack' }
UnicornSimulator >> peek [

	| stackAddressIntegerValue peekedByteArray |

	"Getting address from stack register"
	stackAddressIntegerValue := self stackPointerRegisterValue.

	"Putting the value in the stack memory"
	peekedByteArray := self memoryAt: stackAddressIntegerValue readNext: self wordSize.
	
	^ peekedByteArray
]

{ #category : #'helpers - stack' }
UnicornSimulator >> peekAddress [
	
	^ self peek integerAt: 1 size: self wordSize signed: false
]

{ #category : #registers }
UnicornSimulator >> readRegister: aRegisterID [

	| registerValue |
	registerValue := ByteArray new: self wordSize.
	unicorn register: aRegisterID value readInto: registerValue.
	^ registerValue integerAt: 1 size: self wordSize signed: false
]

{ #category : #registers }
UnicornSimulator >> receiverRegister [
	
	^ self subclassResponsibility
]

{ #category : #registers }
UnicornSimulator >> receiverRegisterValue [

	^ self readRegister: self receiverRegister
]

{ #category : #registers }
UnicornSimulator >> receiverRegisterValue: anInteger [ 

	self writeRegister: self receiverRegister value: anInteger
]

{ #category : #'reading memory' }
UnicornSimulator >> register: anIndex readInto: aByteArray [ 

	unicorn register: anIndex readInto: aByteArray 
]

{ #category : #'as yet unclassified' }
UnicornSimulator >> register: aRegisterIndex write: aByteArray [

	unicorn register: aRegisterIndex readInto: aByteArray 
]

{ #category : #accessing }
UnicornSimulator >> registerDescriptors [
	
	^ self registerList collect: [ :e |
		UnicornRegisterDescriptor new
			simulator: self;
			alias: (self aliasForRegister: e);
			name: e;
			yourself ]
]

{ #category : #initialization }
UnicornSimulator >> registerHook: aBlock atAddress: anAddress [

	unicorn
		registerInvalidMemoryAccessHook: UcHookType fetchingAccess value 
		doing: [ :type :address :size :value | address = anAddress ifTrue: aBlock ]
]

{ #category : #registers }
UnicornSimulator >> returnRegisterValue [
	
	^ self receiverRegisterValue
]

{ #category : #registers }
UnicornSimulator >> returnRegisterValue: aValue [
	
	^ self receiverRegisterValue: aValue
]

{ #category : #registers }
UnicornSimulator >> sendNumberOfArgumentsRegister [

	self subclassResponsibility
]

{ #category : #registers }
UnicornSimulator >> sendNumberOfArgumentsRegister: anInteger [ 
	self shouldBeImplemented.
]

{ #category : #registers }
UnicornSimulator >> sendNumberOfArgumentsRegisterValue [
	
	^ self readRegister: self sendNumberOfArgumentsRegister
]

{ #category : #registers }
UnicornSimulator >> sendNumberOfArgumentsRegisterValue: aValue [

	^ self writeRegister: self sendNumberOfArgumentsRegister value: aValue
]

{ #category : #'as yet unclassified' }
UnicornSimulator >> simulateLeafCallOf: anInteger nextpc: anInteger2 memory: aSpurSimulatedMemory [ 
	
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
UnicornSimulator >> smashRegistersWithValuesFrom: base by: step [
	
	self subclassResponsibility
]

{ #category : #registers }
UnicornSimulator >> stackPointerRegister [
	
	self subclassResponsibility
]

{ #category : #registers }
UnicornSimulator >> stackPointerRegisterValue [

	^ self readRegister: self stackPointerRegister
]

{ #category : #registers }
UnicornSimulator >> stackPointerRegisterValue: aValue [
	
	self writeRegister: self stackPointerRegister value: aValue
]

{ #category : #accessing }
UnicornSimulator >> stackValues [
	
	| initialValue |
	initialValue := self stackPointerRegisterValue.
	
	^ (1 to: 20) collect: [ :anIndex |  
		VMMachineCodeDebuggerStackItem address: initialValue + (memory wordSize * (anIndex - 1)) on: self.	
	] 
]

{ #category : #executing }
UnicornSimulator >> startAt: begin until: until timeout: timeout count: count [ 

	| error result |
	result := self doStartAt: begin until: until timeout: timeout count: count.
	
	"If we did not stop for a known reason, verify the error code of the function"
	unicorn verifyErrorCode: result.
	
	"Verify we stopped because we arrived to the right end addres and not a timeout"
	(until = 0 or: [ self instructionPointerValue = until ]) ifFalse: [
		UnicornTimeout new
			target: until;
			signal ]
]

{ #category : #actions }
UnicornSimulator >> step [
	
	self
		startAt: self instructionPointerValue
		until: 0
		timeout: 0
		count: 1
]

{ #category : #accessing }
UnicornSimulator >> wordAt: anInteger [ 
	
	^ memory longAt: anInteger
]

{ #category : #accessing }
UnicornSimulator >> wordSize [
	self subclassResponsibility
]

{ #category : #registers }
UnicornSimulator >> writeRegister: aRegister value: anInteger [ 

	| value |
	value := ByteArray new: self wordSize.
	value integerAt: 1 put: anInteger size: self wordSize signed: false.
	unicorn register: aRegister value write: value.

]
