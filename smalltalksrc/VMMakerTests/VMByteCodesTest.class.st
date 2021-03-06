Class {
	#name : #VMByteCodesTest,
	#superclass : #VMInterpreterTests,
	#instVars : [
		'contextOop',
		'context',
		'callingFrame',
		'topFrame'
	],
	#category : #'VMMakerTests-InterpreterTests'
}

{ #category : #'helper-assertions' }
VMByteCodesTest >> assert: aBlock pop: anOop intoTemporary: anIndex [
	| oldStackSize |
	oldStackSize := interpreter stackPointer.
	
	aBlock value.
	
	self assert: interpreter stackPointer equals: oldStackSize + memory wordSize.
	self assert: (interpreter temporary: anIndex in: interpreter framePointer) equals: anOop
]

{ #category : #'helper-assertions' }
VMByteCodesTest >> assert: aBlock pushed: anOop [
	| oldStackSize |
	oldStackSize := interpreter stackPointer.
	
	aBlock value.
	
	self assert: interpreter stackPointer equals: oldStackSize - memory wordSize.
	self assert: interpreter stackTop equals: anOop.
	
]

{ #category : #'helper-assertions' }
VMByteCodesTest >> assert: aBlock returned: anOop [
	| callerSP |
	callerSP := interpreter frameCallerSP: interpreter framePointer.
	
	aBlock value.
	
	self assert: interpreter stackPointer equals: callerSP - memory wordSize.
	self assert: interpreter stackTop equals: anOop.
	
]

{ #category : #'helper-assertions' }
VMByteCodesTest >> assertPopped: aBlock [
	| oldStackSize |
	oldStackSize := interpreter stackPointer.
	
	aBlock value.
	
	self assert: interpreter stackPointer equals: oldStackSize + memory wordSize.
	
]

{ #category : #'helpers-bytecode-table' }
VMByteCodesTest >> firstPushTemporaryVariableBytecode [
	"in v3 bytecode table"
	^ 16
]

{ #category : #'helpers-bytecode-table' }
VMByteCodesTest >> firstStoreAndPopTemporaryVariableBytecode [
	^ 104
]

{ #category : #'helper-interpret' }
VMByteCodesTest >> interpret: aBlock [
	interpreter internalizeIPandSP.
	aBlock value.
	interpreter externalizeIPandSP.

]

{ #category : #'tests-pushThisContext' }
VMByteCodesTest >> interpretWithFrame: aBlock [

	callingFrame := stackBuilder addNewFrame
		method: (self newMethodWithBytecodes: #[1 2 3 4 5 6 7 8]).
	topFrame := stackBuilder addNewFrame
		method: (self newMethodWithBytecodes: #[1 2 3 4 5 6 7 8]).
	stackBuilder buildStack.
	
	self interpret: aBlock.

]

{ #category : #'test-push-simple' }
VMByteCodesTest >> pushTempTest: index [
	
	stackBuilder addNewFrame tempAt: index put: (memory integerObjectOf: 42).
	stackBuilder buildStack.
	interpreter currentBytecode: (self pushTemporaryVariableBytecodeAt: index).
	
	"first we push something, so there is something to duplicate"
	self
		assert: [ self interpret: [ interpreter pushTemporaryVariableBytecode ] ]
		pushed: (memory integerObjectOf: 42).

]

{ #category : #'helpers-bytecode-table' }
VMByteCodesTest >> pushTemporaryVariableBytecodeAt: offset [
	^ self firstPushTemporaryVariableBytecode + offset.
	
]

{ #category : #'tests-pushThisContext' }
VMByteCodesTest >> pushThisContextTopFrame [

	self interpretWithFrame: [ interpreter pushActiveContextBytecode ].

	contextOop := interpreter stackTop.
	context := VMContext
		newOnContext: contextOop
		withInterpreter: interpreter
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> storeAndPopTemporaryIntoTempTest: index [
	
	stackBuilder addNewFrame
		tempAt: index put: (memory nilObject) ;
		stack: { memory integerObjectOf: 42 } .
	stackBuilder buildStack.
	
	interpreter currentBytecode: (self storeAndPopTemporaryVariableBytecodeAt: index).
	
	"first we push something, so there is something to duplicate"
	self assert: [ self interpret: [ interpreter storeAndPopTemporaryVariableBytecode ] ]
		pop: (memory integerObjectOf: 42)
		intoTemporary: index
]

{ #category : #'helpers-bytecode-table' }
VMByteCodesTest >> storeAndPopTemporaryVariableBytecodeAt: anInteger [ 
	^ self firstStoreAndPopTemporaryVariableBytecode + anInteger
]

{ #category : #'tests-pushThisContext' }
VMByteCodesTest >> testAccessingSenderOfContextShouldReturnContextOfSender [

	| oldMaybeSenderContext newMaybeSenderContext |
	self interpretWithFrame: [ interpreter pushActiveContextBytecode. ].
	oldMaybeSenderContext := interpreter instVar: SenderIndex ofContext: interpreter stackTop.
	interpreter pushActiveContextBytecode.
	newMaybeSenderContext := interpreter instVar: SenderIndex ofContext: interpreter stackTop.
	self assert: oldMaybeSenderContext equals: newMaybeSenderContext
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testDuplicateStackTop [

	stackBuilder addNewFrame ; buildStack.
	
	"first we push something, so there is something to duplicate"
	self
		assert: [ self interpret: [ interpreter pushConstantOneBytecode ] ]
		pushed: (memory integerObjectOf: 1).

	"then we duplicate it"
	self
		assert: [ self interpret: [ interpreter duplicateTopBytecode  ] ]
		pushed: (memory integerObjectOf: 1).
	
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testPopStackTopBytecode [

	stackBuilder addNewFrame ; buildStack..
	
	"first we push something"
	self
		assert: [ self interpret: [ interpreter pushConstantOneBytecode ] ]
		pushed: (memory integerObjectOf: 1).
	
	"then we pop it"
	self
		assertPopped: [ self interpret: [ interpreter popStackBytecode ] ]
	
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testPushConstantFalseBytecode [
	stackBuilder addNewFrame ; buildStack.
	self
		assert: [ self interpret: [ interpreter pushConstantFalseBytecode ] ]
		pushed: memory falseObject
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testPushConstantMinusOneBytecode [
	stackBuilder addNewFrame ; buildStack.
	self
		assert: [ self interpret: [ interpreter pushConstantMinusOneBytecode ] ]
		pushed: (memory integerObjectOf: -1)
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testPushConstantNilBytecode [
	stackBuilder addNewFrame ; buildStack.
	self
		assert: [ self interpret: [ interpreter pushConstantNilBytecode ] ]
		pushed: memory nilObject
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testPushConstantOneBytecode [
	stackBuilder addNewFrame ; buildStack.
	self
		assert: [ self interpret: [ interpreter pushConstantOneBytecode ] ]
		pushed: (memory integerObjectOf: 1)
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testPushConstantReceiverBytecode [
	| intReceiver f1 |
	intReceiver := memory integerObjectOf: 42.
	
	f1 := stackBuilder addNewFrame receiver: intReceiver.
	stackBuilder buildStack.

	self
		assert: [ self interpret: [ interpreter pushReceiverBytecode ] ]
		pushed: intReceiver
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testPushConstantTrueBytecode [
	stackBuilder addNewFrame ; buildStack.
	self
		assert: [ self interpret: [ interpreter pushConstantTrueBytecode ] ]
		pushed: memory trueObject
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testPushConstantTwoBytecode [
	stackBuilder addNewFrame ; buildStack.
	self
		assert: [ self interpret: [ interpreter pushConstantTwoBytecode ] ]
		pushed: (memory integerObjectOf: 2)
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testPushConstantZeroBytecode [
	stackBuilder addNewFrame ; buildStack.
	self
		assert: [ self interpret: [ interpreter pushConstantZeroBytecode ] ]
		pushed: (memory integerObjectOf: 0)
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testPushTemp0 [
	self pushTempTest: 0
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testPushTemp1 [
	self pushTempTest: 1
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testPushTemp10 [
	self pushTempTest: 10
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testPushTemp11 [
	self pushTempTest: 11
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testPushTemp2 [
	self pushTempTest: 2
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testPushTemp3 [
	self pushTempTest: 3
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testPushTemp4 [
	self pushTempTest: 4
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testPushTemp5 [
	self pushTempTest: 5
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testPushTemp6 [
	self pushTempTest: 6
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testPushTemp7 [
	self pushTempTest: 7
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testPushTemp8 [
	self pushTempTest: 8
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testPushTemp9 [
	self pushTempTest: 9
]

{ #category : #'tests-pushThisContext' }
VMByteCodesTest >> testPushThisContextIsContext [

	self pushThisContextTopFrame.
	self assert: (memory isContext: interpreter stackTop).
]

{ #category : #'tests-pushThisContext' }
VMByteCodesTest >> testPushThisContextPushesValidInstructionPointer [
	self pushThisContextTopFrame.
	self
		assert: (interpreter objectMemory isIntegerObject: context instructionPointer).
	self
		assert: (interpreter withoutSmallIntegerTags: context instructionPointer)
		equals: (interpreter frameCallerFP: interpreter framePointer)
]

{ #category : #'tests-pushThisContext' }
VMByteCodesTest >> testPushThisContextPushesValidPointerToTheFramePointer [
	
	self pushThisContextTopFrame.
	self
		assert: (interpreter objectMemory isIntegerObject: context sender).
	self
		assert: (interpreter withoutSmallIntegerTags: context sender)
		equals: interpreter framePointer
]

{ #category : #'tests-pushThisContext' }
VMByteCodesTest >> testPushThisContextPushesValidReceiver [

	self pushThisContextTopFrame.
	self assert: topFrame receiver equals: context receiver
]

{ #category : #'tests-pushThisContext' }
VMByteCodesTest >> testPushThisContextSetContextToFrame [

	self pushThisContextTopFrame.
	self assert: (interpreter frameContext: interpreter framePointer) equals: interpreter stackTop.
]

{ #category : #'tests-pushThisContext' }
VMByteCodesTest >> testPushThisContextSetFlagContextToFrame [

	self pushThisContextTopFrame.
	self assert: (interpreter frameHasContext: interpreter framePointer).
]

{ #category : #'tests-pushThisContext' }
VMByteCodesTest >> testPushThisContextTwiceMarriesOnce [

	| previousTop newTop |
	self interpretWithFrame: [ 
		interpreter pushActiveContextBytecode.
		previousTop := interpreter stackTop.
		interpreter pushActiveContextBytecode.
		newTop := interpreter stackTop.
		 ].
	self assert: newTop equals: previousTop.
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testReturnFalse [	
	"We need to return to a method.
	So the method of the first stack should have a compiled method in the method field of the stack.
	using memory trueObject simulates that behavior."
	stackBuilder addNewFrame method: (self newMethodWithLiteral: memory trueObject at: 1).
	stackBuilder addNewFrame.
	stackBuilder buildStack.

	self
		assert: [ self interpret: [ interpreter returnFalse ] ]
		returned: memory falseObject

]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testReturnTrue [	
	"We need to return to a method.
	So the method of the first stack should have a compiled method in the method field of the stack.
	using memory trueObject simulates that behavior."
	stackBuilder addNewFrame method: (self newMethodWithLiteral: memory trueObject at: 1).
	stackBuilder addNewFrame.
	stackBuilder buildStack.

	self
		assert: [ self interpret: [ interpreter returnTrue ] ]
		returned: memory trueObject

]

{ #category : #'tests-pushThisContext' }
VMByteCodesTest >> testReturnsMarriedFrameWidowsContext [

	|   topFrameContext |
	self interpretWithFrame: [ 
		interpreter pushActiveContextBytecode.
		interpreter returnTopFromMethod.
		 ].
	topFrameContext := interpreter stackTop.
	"The interpreter does not update the pages, they are updated on demand. 
	Before checking a frame isWindowed we have to synchronize the interpreter variables with the stackPages"
	interpreter externalWriteBackHeadFramePointers.
	self assert: (interpreter isWidowedContext: topFrameContext)
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testStoreAndPopTemporary0 [
	self storeAndPopTemporaryIntoTempTest: 0
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testStoreAndPopTemporary1 [
	self storeAndPopTemporaryIntoTempTest: 1
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testStoreAndPopTemporary2 [
	self storeAndPopTemporaryIntoTempTest: 2
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testStoreAndPopTemporary3 [
	self storeAndPopTemporaryIntoTempTest: 3
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testStoreAndPopTemporary4 [
	self storeAndPopTemporaryIntoTempTest: 4
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testStoreAndPopTemporary5 [
	self storeAndPopTemporaryIntoTempTest: 5
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testStoreAndPopTemporary6 [
	self storeAndPopTemporaryIntoTempTest: 6
]

{ #category : #'test-push-simple' }
VMByteCodesTest >> testStoreAndPopTemporary7 [
	self storeAndPopTemporaryIntoTempTest: 7
]
