Class {
	#name : #VMAbstractPrimitiveTest,
	#superclass : #VMSpurMemoryManagerTest,
	#pools : [
		'VMBasicConstants',
		'VMBytecodeConstants',
		'VMObjectIndices',
		'VMSqueakClassIndices'
	],
	#category : #VMMakerTests
}

{ #category : #running }
VMAbstractPrimitiveTest >> createProcessFor: newMethod priority: aPriority [

	| aProcess |
	
	aProcess := self createSuspendedProcessFor: newMethod priority: aPriority.
	
	interpreter preemptionYields: false.
	interpreter putToSleep: aProcess yieldingIf: interpreter preemptionYields.

	^ aProcess
]

{ #category : #running }
VMAbstractPrimitiveTest >> createSuspendedProcessFor: newMethod priority: aPriority [

	| suspendedContext aProcess |
	
	"Create a new process with given priority and put it to sleep"

	suspendedContext := self
		newSmallContextReceiver: memory nilObject
		method: newMethod
		arguments: #()
		temporaries: #()
		ip: self wordSize + 1.

	aProcess := self newObjectWithSlots: 4.

	memory storeInteger: PriorityIndex ofObject: aProcess withValue: aPriority.
	memory storePointer: SuspendedContextIndex ofObject: aProcess withValue: suspendedContext.

	^ aProcess
]

{ #category : #'as yet unclassified' }
VMAbstractPrimitiveTest >> newArrayWith: aCollection [ 
	| array |
	array := self newObjectWithSlots: aCollection size format: memory arrayFormat classIndex: memory arrayClassIndexPun.
	aCollection withIndexDo: [ :item :index | 
		memory storePointer: index - 1 ofObject: array withValue: item	
	].
	^ array
	
]

{ #category : #'helpers - classes' }
VMAbstractPrimitiveTest >> newClassInOldSpaceWithSlots: numberOfSlots format: format [
	| newClass formatWithSlots |

	newClass := memory
		allocateSlotsInOldSpace: 3
		format: memory nonIndexablePointerFormat
		classIndex: memory arrayClassIndexPun.
	
	memory storePointer: 0 ofObject: newClass withValue: memory nilObject.
	memory storePointer: 1 ofObject: newClass withValue: memory nilObject.
	
	formatWithSlots := format << 16 + numberOfSlots. 
	memory storePointer: 2 ofObject: newClass withValue: (memory integerObjectOf: formatWithSlots ).
		
	^ newClass	
]

{ #category : #'helpers - frames' }
VMAbstractPrimitiveTest >> newSmallContextReceiver: anOop method: aMethodOop arguments: aCollectionOfArgumentsOop temporaries: aCollectionOfTemporariesOop ip: anIp [

	| newCtx numArgs numTemps |
	newCtx := memory
					allocateSlots: SmallContextSlots
					format: memory indexablePointersFormat
					classIndex: ClassMethodContextCompactIndex.

	numArgs := aCollectionOfArgumentsOop size.
	numTemps := aCollectionOfTemporariesOop size.

	memory storePointerUnchecked: SenderIndex
		ofObject: newCtx
		withValue: memory nilObject.
		
	memory storePointerUnchecked: InstructionPointerIndex
		ofObject: newCtx
		withValue: (memory integerObjectOf: anIp).

	memory storePointerUnchecked: StackPointerIndex
		ofObject: newCtx
		withValue: (memory integerObjectOf: numArgs + numTemps).
		
	memory storePointerUnchecked: MethodIndex
		ofObject: newCtx
		withValue: aMethodOop.

	memory storePointerUnchecked: ClosureIndex ofObject: newCtx withValue: memory nilObject.

	memory storePointerUnchecked: ReceiverIndex
		ofObject: newCtx
		withValue: anOop.
	
	1 to: numArgs do:
		[:i|
		memory storePointerUnchecked: ReceiverIndex + i
			ofObject: newCtx
			withValue: (aCollectionOfArgumentsOop at: i)].

	1 to: numTemps do:
			[:i|
			memory storePointerUnchecked: ReceiverIndex + i + numArgs
				ofObject: newCtx
				withValue: (aCollectionOfTemporariesOop at: i)].
	
	^ newCtx
]

{ #category : #running }
VMAbstractPrimitiveTest >> setUp [
	
	"taken from VMSimpleStackBasedCogitBytecodeTest >> #setup"
	| newMethod ctx page processorOopAssociation processorOop processorListsArray priorities |
	super setUp.
	
	memory nilObject: (self newObjectWithSlots: 0).
	memory trueObject: (self newObjectWithSlots: 0).
	memory falseObject: (self newObjectWithSlots: 0).
	
	"We don't access its contents, but we need it to be after nil, true and false"
	memory hiddenRootsObject: (self newObjectWithSlots: 0).
	interpreter := memory interpreter.
	
	"stackMemoryStartAddress := initialAddress + self initialCodeSize.
	stackMemoryEndAddress := stackMemoryStartAddress + stackSpaceSize."
	
	self initializeOldSpaceForScavenger.

	"Create the root context with a valid method"
	"Let's create a method with enough size. It should have at least a literal (4 or 8 bytes depending the word size) and some bytecodes, so we can put the IP inside the method"
	newMethod := self newMethodWithBytecodes: #[ 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 ].
	
	"The context has 5 (in 32 bits) or 9 (in 64 bits) as initial IP, as method has at least one literal"
	ctx := self newSmallContextReceiver: memory nilObject method: newMethod arguments: #() temporaries: #() ip: self wordSize + 1.
	
	page := interpreter makeBaseFrameFor: ctx.
	interpreter setStackPageAndLimit: page.
	interpreter setStackPointersFromPage: page.
	interpreter libFFI: LibFFI new.
	interpreter libFFI interpreter: interpreter.
	
	"The ScheduleAssocation should be initialized to a valid Processor object"
	processorOopAssociation := self newObjectWithSlots: 2.
	processorOop := self newObjectWithSlots: 2.
	priorities := 2.
	processorListsArray := self newObjectWithSlots: priorities.
	1 to: priorities do: [ :index | 
		"Put an empty linked list in each"
		memory storePointer: index - 1 ofObject: processorListsArray withValue: (self newObjectWithSlots: 2) ].
	
	memory splObj: SchedulerAssociation put: processorOopAssociation.
	memory storePointer: ValueIndex ofObject: processorOopAssociation withValue: processorOop.
	memory storePointer: ProcessListsIndex ofObject: processorOop withValue: processorListsArray.

	"Create a new process with the 4 mandatory instance variables and set it as active process"
	memory storePointer: ActiveProcessIndex ofObject: processorOop withValue:  (self newObjectWithSlots: 4).
	
	"The current instruction pointer is an absolute address pointing to the current bytecode inside the method"
	interpreter instructionPointer: newMethod + memory baseHeaderSize + memory wordSize + 1.
	interpreter method: newMethod.

	memory flushNewSpace.

	self createProcessFor: newMethod priority: 1.
	self createProcessFor: newMethod priority: 1.
	
	memory classExternalAddress: (self newClassInOldSpaceWithSlots: 0 format: (memory byteFormatForNumBytes: 0) ).
	memory classArray: (self newClassInOldSpaceWithSlots: 0 format: memory arrayFormat ).
	memory classByteArray: (self newClassInOldSpaceWithSlots: 0 format: (memory byteFormatForNumBytes: 0) ).

	memory lastHash: 1
]
