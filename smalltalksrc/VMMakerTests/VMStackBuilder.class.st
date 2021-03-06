"
I am a builder for Stack frames.

I am configuring frames and building the stack frames.
I am used by tests for the simulator.
I am creating the page that I will put in the interpreter.
I am using the VMFrameBuilder to prepare the frame objects that I will push on the stack.

You can either give me a frame ready to add with #addFrame:
You can also use #addNewFrame:. This creates an frames, add it, then returns it to be configured.
When all the frames have been added, use #buildStack to create the stack.
I need a reference to an interpreter and memory to work.

examples can be found in #VMByteCodetests
for example: 
self stackBuilder addNewFrame receiver: intReceiver.
self stackBuilder buildStack.
 
Internal Representation and Key Implementation Points.

Types are not the exact types used.
    Instance Variables
	frames:		<OrderedCollection> collection of the frames to be added. First frame added in the collection, first frame pushed.
	interpreter:		<Interpreter> an interpreter simulator.
	memory:		<Memory> a memory simulator
	page:		<StackPage> a new page containing the stack to be added

"
Class {
	#name : #VMStackBuilder,
	#superclass : #Object,
	#instVars : [
		'page',
		'frames',
		'args',
		'interpreter',
		'memory'
	],
	#category : #'VMMakerTests-Builders'
}

{ #category : #frames }
VMStackBuilder >> addFrame: aFrame [
	frames add: aFrame
]

{ #category : #frames }
VMStackBuilder >> addNewFrame [
	| frame |
	"'add' a new frame in the sense of an OrderedCollection, which will be iterated with #do:
	The last frame added, will be the stackTop"
	frame := VMFrameBuilder new initializeWithInterpreter: interpreter andMemory: memory.
	frames add: frame.
	^ frame "the frame is then configured by the caller"
]

{ #category : #accessing }
VMStackBuilder >> args [
	^ args
]

{ #category : #accessing }
VMStackBuilder >> args: anObject [
	args := anObject
]

{ #category : #build }
VMStackBuilder >> buildStack [
	self createStackPage.
	self pushFrames.
	interpreter setStackPageAndLimit: page.
	interpreter setStackPointersFromPage: page.
	interpreter internalizeIPandSP.
	^ frames last
]

{ #category : #stack }
VMStackBuilder >> createStackPage [
	| sp |
	frames ifEmpty:[ self error ].

	page := interpreter stackPages newStackPage.
	"set base stackPointer"
	sp := page baseAddress + memory wordSize.
	interpreter stackPointer: sp.
]

{ #category : #accessing }
VMStackBuilder >> frames [
	^ frames
]

{ #category : #accessing }
VMStackBuilder >> frames: anObject [
	frames := anObject
]

{ #category : #initialization }
VMStackBuilder >> initialize [
	super initialize.
	frames := OrderedCollection new. "will be treated in reverse"
	args := OrderedCollection new.
]

{ #category : #accessing }
VMStackBuilder >> interpreter [
	^ interpreter
]

{ #category : #accessing }
VMStackBuilder >> interpreter: anInterpreter [
	interpreter := anInterpreter
]

{ #category : #accessing }
VMStackBuilder >> memory [
	^ memory
]

{ #category : #accessing }
VMStackBuilder >> memory: aMemory [
	memory := aMemory
]

{ #category : #accessing }
VMStackBuilder >> page [
	^ page
]

{ #category : #accessing }
VMStackBuilder >> page: anObject [
	page := anObject
]

{ #category : #initialization }
VMStackBuilder >> pushArgs [
	args do: [ :anArg | interpreter push: anArg ]
]

{ #category : #build }
VMStackBuilder >> pushFrame: aFrame [
	
	interpreter framePointer: interpreter stackPointer.
	page headFP: interpreter stackPointer.

	aFrame pushYourself.
	page headSP: interpreter stackPointer.
]

{ #category : #build }
VMStackBuilder >> pushFrames [
	 "Page setup before the base frame"
	interpreter push: memory nilObject.	"receiver"
	self pushArgs. "arguments"
	interpreter push: memory nilObject.  "senderContext"
	interpreter push: 0. "savedFp"
	page baseFP: interpreter stackPointer.
	"Push base frame"
	frames first previousFrameArgsSize: args size.
	self pushFrame: frames first.

	2 to: frames size do: [ :anIndex | | aFrame |
			aFrame := frames at: anIndex.
			
			aFrame previousFrameArgsSize: ((frames at: anIndex - 1) argumentSize).
			
			interpreter push: interpreter framePointer.	
				
			self pushFrame: aFrame.
			aFrame callerFrame: (frames at: anIndex - 1)."for better inspection"
			]
]

{ #category : #accessing }
VMStackBuilder >> topFrame [
	^ frames last
]
