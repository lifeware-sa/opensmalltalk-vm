Class {
	#name : #VMContext,
	#superclass : #Object,
	#instVars : [
		'contextOop',
		'interpreter'
	],
	#pools : [
		'VMObjectIndices'
	],
	#category : #'VMMakerTests-Visualisation'
}

{ #category : #'instance creation' }
VMContext class >> newOnContext: anInteger withInterpreter: aStackInterpreterSimulatorLSB [
	^ self new
		contextOop: anInteger;
		interpreter: aStackInterpreterSimulatorLSB;
		yourself
]

{ #category : #accessing }
VMContext >> contextOop: anInteger [ 
	contextOop := anInteger
]

{ #category : #accessing }
VMContext >> instructionPointer [
	^interpreter objectMemory fetchPointer: InstructionPointerIndex ofObject: contextOop.
]

{ #category : #accessing }
VMContext >> interpreter: aStackInterpreterSimulatorLSB [ 
	interpreter := aStackInterpreterSimulatorLSB
]

{ #category : #testing }
VMContext >> isMarried [
	^interpreter isStillMarriedContext: contextOop.
]

{ #category : #testing }
VMContext >> isNilObject [
	^interpreter objectMemory nilObject = contextOop.
]

{ #category : #accessing }
VMContext >> receiver [
	^interpreter objectMemory fetchPointer: ReceiverIndex ofObject: contextOop
]

{ #category : #accessing }
VMContext >> sender [
	^interpreter objectMemory fetchPointer: SenderIndex ofObject: contextOop.
]
