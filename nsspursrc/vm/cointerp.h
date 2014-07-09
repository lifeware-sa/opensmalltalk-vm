/* Automatically generated by
	CCodeGeneratorGlobalStructure VMMaker.oscog-eem.811 uuid: 96eb7a61-d68a-4114-8c1a-c0a7fad3232e
 */


/*** Function Prototypes ***/


#if defined(PRODUCTION) && !PRODUCTION && defined(__GNUC__) && !defined(NoDbgRegParms)
# define NoDbgRegParms __attribute__ ((regparm (0)))
#endif

#if !defined(NoDbgRegParms)
# define NoDbgRegParms /*empty*/
#endif

sqInt accessorDepthForPrimitiveIndex(sqInt primIndex);
usqInt argumentCountAddress(void);
void assertValidMachineCodeFrame(sqInt instrPtr);
void callForCogCompiledCodeCompaction(void);
void ceActivateFailingPrimitiveMethod(sqInt aPrimitiveMethod);
sqInt ceActiveContext(void);
sqInt ceBaseFrameReturn(sqInt returnValue);
sqInt ceCannotResume(void);
sqInt ceCheckForAndFollowForwardedPrimitiveStateFor(sqInt primIndex);
void ceCheckForInterrupts(void);
void ceCheckProfileTick(void);
sqInt ceContextinstVar(sqInt maybeContext, sqInt slotIndex);
sqInt ceContextinstVarvalue(sqInt maybeMarriedContext, sqInt slotIndex, sqInt anOop);
sqInt ceDynamicSuperSendtonumArgs(sqInt selector, sqInt rcvr, sqInt numArgs);
sqInt ceExplicitReceiverAt(sqInt level);
sqInt ceInterpretMethodFromPICreceiver(sqInt aMethodObj, sqInt rcvr);
sqInt ceMNUFromPICMNUMethodreceiver(sqInt aMethodObj, sqInt rcvr);
sqInt ceNewArraySlotSize(sqInt slotSize);
sqInt ceNonLocalReturn(sqInt returnValue);
sqInt cePositive32BitIntegerFor(usqInt anInteger);
sqInt ceReturnToInterpreter(sqInt anOop);
sqInt ceSendAborttonumArgs(sqInt selector, sqInt rcvr, sqInt numArgs);
sqInt ceSendFromInLineCacheMiss(CogMethod *cogMethodOrPIC);
sqInt ceSendMustBeBoolean(sqInt anObject);
sqInt ceSendsupertonumArgs(sqInt selector, sqInt superNormalBar, sqInt rcvr, sqInt numArgs);
void ceStackOverflow(sqInt contextSwitchIfNotNil);
void ceTraceBlockActivation(void);
void ceTraceLinkedSend(sqInt theReceiver);
void ceTraceStoreOfinto(sqInt aValue, sqInt anObject);
void checkAssertsEnabledInCoInterpreter(void);
void clearTraceLog(void);
CogMethod * cogMethodOf(sqInt aMethodOop);
void compilationBreakpointFor(sqInt selectorOop);
sqInt createClosureNumArgsnumCopiedstartpc(sqInt numArgs, sqInt numCopied, sqInt initialIP);
void dumpPrimTraceLog(void);
void dumpTraceLog(void);
void executeCogMethodfromLinkedSendWithReceiver(CogMethod *cogMethod, sqInt rcvr);
void executeCogMethodfromLinkedSendWithReceiverandCacheTag(CogMethod *cogMethod, sqInt rcvr, sqInt cacheTag);
sqInt flushExternalPrimitiveOf(sqInt methodObj);
usqInt framePointerAddress(void);
void (*functionPointerForCompiledMethodprimitiveIndex(sqInt methodObj, sqInt primIndex))(void) ;
sqInt getCheckAllocFiller(void);
sqInt headerOf(sqInt methodPointer);
void ifValidWriteBackStackPointersSaveTo(void *theCFP, void *theCSP, char **savedFPP, char **savedSPP);
sqInt implicitReceiverFormixinimplementing(sqInt rcvr, sqInt mixin, sqInt selector);
usqInt instructionPointerAddress(void);
usqInt interpretAddress(void);
sqInt isCogMethodReference(sqInt methodHeader);
sqInt lookupreceiver(sqInt selector, sqInt rcvr);
void markActiveMethodsAndReferents(void);
sqInt maxLookupNoMNUErrorCode(void);
void * methodCacheAddress(void);
sqInt methodHasCogMethod(sqInt aMethodOop);
sqInt methodNeedsLargeContext(sqInt methodObj);
sqInt methodShouldBeCogged(sqInt aMethodObj);
CogMethod * mframeHomeMethodExport(void);
CogMethod * mframeHomeMethod(char *theFP);
sqInt mMethodClass(void);
usqInt newMethodAddress(void);
usqInt nextProfileTickAddress(void);
sqInt noAssertHeaderOf(sqInt methodPointer);
sqInt primErrTable(void);
usqInt primFailCodeAddress(void);
usqInt primitiveFailAddress(void);
sqInt primitivePropertyFlags(sqInt primIndex);
void * primTraceLogAddress(void);
usqInt primTraceLogIndexAddress(void);
void printCogMethod(CogMethod *cogMethod);
void printFrameWithSP(char *theFP, char *theSP);
void printMethodCacheFor(sqInt thing);
sqInt quickPrimitiveConstantFor(sqInt aQuickPrimitiveIndex);
int (*quickPrimitiveGeneratorFor(sqInt aQuickPrimitiveIndex))(void) ;
sqInt quickPrimitiveInstVarIndexFor(sqInt primIndex);
sqInt rawHeaderOf(sqInt methodPointer);
void rawHeaderOfput(sqInt methodOop, sqInt cogMethodOrMethodHeader);
void reportMinimumUnusedHeadroom(void);
sqInt specialSelectorNumArgs(sqInt index);
usqInt stackLimitAddress(void);
usqInt stackPointerAddress(void);
sqInt startPCOfMethodHeader(sqInt aCompiledMethodHeader);
sqInt startPCOrNilOfLiteralin(sqInt lit, sqInt aMethodObj);
void updateStackZoneReferencesToCompiledCodePreCompaction(void);
char * whereIs(sqInt anOop);
usqInt primitiveFunctionPointerAddress(void);
char * cStringOrNullFor(sqInt oop);
sqInt failed(void);
void primitiveClosureValueNoContextSwitch(void);
sqInt primitiveFail(void);
sqInt primitiveFailFor(sqInt reasonCode);
sqInt primitiveFailureCode(void);
sqInt signalNoResume(sqInt aSemaphore);
usqInt sizeOfAlienData(sqInt oop);
void * startOfAlienData(sqInt oop);
sqInt ceClassAtIndex(sqInt classIndex);
void ceSheduleScavenge(void);
sqInt ceStoreCheck(sqInt anOop);
usqInt freeStartAddress(void);
usqInt getScavengeThreshold(void);
sqInt isReallyYoungObject(sqInt objOop);
sqLong nullHeaderForMachineCodeMethod(void);
usqInt scavengeThresholdAddress(void);
sqInt withoutForwardingOnandsendToCogit(sqInt obj1, sqInt obj2, sqInt (*selector)(sqInt,sqInt));
sqInt withoutForwardingOnandwithsendToCogit(sqInt obj1, sqInt obj2, sqInt aBool, sqInt (*selector)(sqInt,sqInt,sqInt));
sqInt byteSwapped(sqInt w);
sqInt isIntegerValue(sqInt intValue);
sqInt isMarked(sqInt objOop);
sqInt numTagBits(void);
sqInt shiftForWord(void);
usqInt smallObjectBytesForSlots(sqInt numSlots);
sqInt tagMask(void);
sqInt addGCRoot(sqInt *varLoc);
sqInt addressCouldBeObj(sqInt address);
sqInt arrayFormat(void);
sqInt becomewith(sqInt array1, sqInt array2);
void beRootIfOld(sqInt oop);
sqInt byteLengthOf(sqInt objOop);
sqInt byteSizeOf(sqInt oop);
sqInt characterObjectOf(sqInt characterCode);
sqInt characterTag(void);
sqInt characterValueOf(sqInt oop);
sqInt checkedLongAt(sqInt byteAddress);
sqInt checkOkayOop(usqInt oop);
sqInt checkOopHasOkayClass(usqInt obj);
sqInt checkTraversableSortedFreeList(void);
sqInt classAtIndex(sqInt classIndex);
sqInt classFloatCompactIndex(void);
sqInt classIndexMask(void);
sqInt classIndexOf(sqInt objOop);
sqInt classOrNilAtIndex(sqInt classIndex);
sqInt classTableMajorIndexShift(void);
sqInt classTableMinorIndexMask(void);
sqInt classTableRootObj(void);
sqInt compactClassIndexOf(sqInt objOop);
void countMarkedAndUnmarkdObjects(sqInt printFlags);
sqInt eeInstantiateClassIndexformatnumSlots(sqInt knownClassIndex, sqInt objFormat, sqInt numSlots);
sqInt ensureBehaviorHash(sqInt aBehavior);
sqInt fetchByteofObject(sqInt byteIndex, sqInt objOop);
void findStringBeginningWith(char *aCString);
void findString(char *aCString);
sqInt firstByteFormat(void);
sqInt firstCompiledMethodFormat(void);
sqInt firstLongFormat(void);
sqInt firstShortFormat(void);
sqInt fixedFieldsFieldWidth(void);
sqInt fixedFieldsOfClassFormatMask(void);
sqInt followForwardedObjectFieldstoDepth(sqInt objOop, sqInt depth);
sqInt followForwarded(sqInt objOop);
sqInt formatMask(void);
sqInt formatOfClass(sqInt classPointer);
sqInt formatShift(void);
sqInt freeObject(sqInt objOop);
usqLong headerForSlotsformatclassIndex(sqInt numSlots, sqInt formatField, sqInt classIndex);
sqInt identityHashHalfWordMask(void);
sqInt indexablePointersFormat(void);
void inOrderPrintFreeTreeprintList(sqInt freeChunk, sqInt printNextList);
sqInt instanceSizeOf(sqInt classObj);
sqInt isCharacterObject(sqInt oop);
sqInt isCharacterValue(sqInt anInteger);
sqInt isCompiledMethod(sqInt objOop);
sqInt isForwardedObjectClassIndexPun(void);
sqInt isForwarded(sqInt objOop);
sqInt isImmediate(sqInt oop);
sqInt isNonImmediate(sqInt oop);
sqInt isOldObject(sqInt objOop);
sqInt isOopCompiledMethod(sqInt oop);
sqInt isOopForwarded(sqInt oop);
sqInt isOopImmutable(sqInt oop);
sqInt isOopMutable(sqInt oop);
sqInt isPinned(sqInt objOop);
sqInt isReallyYoung(sqInt oop);
sqInt isUnambiguouslyForwarder(sqInt objOop);
sqInt isYoungObject(sqInt objOop);
sqInt isYoung(sqInt oop);
sqInt lastPointerOfWhileSwizzling(sqInt objOop);
sqInt lastPointerOf(sqInt objOop);
sqInt leakCheckBecome(void);
sqInt leakCheckFullGC(void);
sqInt leakCheckIncrementalGC(void);
sqInt leakCheckNewSpaceGC(void);
sqInt lengthOf(sqInt objOop);
void longPrintInstancesOf(sqInt aClassOop);
void longPrintInstancesWithClassIndex(sqInt classIndex);
void longPrintReferencesTo(sqInt anOop);
void markAndTrace(sqInt objOop);
sqInt maybeSplObj(sqInt index);
sqInt nextInSortedFreeListLinkgiven(sqInt freeChunk, sqInt prevFree);
sqInt nonIndexablePointerFormat(void);
sqInt numPointerSlotsOf(sqInt objOop);
sqInt numSlotsHalfShift(void);
sqInt numSlotsMask(void);
usqInt numSlotsOf(sqInt objOop);
sqInt numStrongSlotsOfWeakling(sqInt objOop);
sqInt objectAfter(sqInt objOop);
sqInt objectBefore(sqInt objOop);
sqInt obsoleteDontUseThisFetchWordofObject(sqInt fieldIndex, sqInt oop);
sqInt popRemappableOop(void);
sqInt primitiveErrorTable(void);
void printForwarders(void);
void printFreeChunks(void);
void printFreeChunk(sqInt freeChunk);
void printFreeList(sqInt chunkOrIndex);
void printFreeTree(void);
void printInstancesOf(sqInt aClassOop);
void printInstancesWithClassIndex(sqInt classIndex);
void printMethodReferencesTo(sqInt anOop);
void printObjectsFromto(sqInt startAddress, sqInt endAddress);
void printObjStack(sqInt objStack);
void printOopsFromto(sqInt startAddress, sqInt endAddress);
void printReferencesTo(sqInt anOop);
void pushRemappableOop(sqInt oop);
sqInt remapObj(sqInt objOop);
sqInt rememberedBitShift(void);
sqInt removeGCRoot(sqInt *varLoc);
void shortPrintObjectsFromto(sqInt startAddress, sqInt endAddress);
sqInt shouldRemapObj(sqInt objOop);
sqInt shouldRemapOop(sqInt oop);
sqInt splObj(sqInt index);
usqInt storeCheckBoundary(void);
sqInt storePointerUncheckedofObjectwithValue(sqInt fieldIndex, sqInt objOop, sqInt valuePointer);
void tenuringIncrementalGC(void);
sqInt topRemappableOop(void);
sqInt vmEndianness(void);
sqInt weakArrayFormat(void);
sqInt activeProcess(void);
sqInt argumentCountOfClosure(sqInt closurePointer);
sqInt argumentCountOfMethodHeader(sqInt header);
sqInt argumentCountOf(sqInt methodPointer);
sqInt canContextSwitchIfActivatingheader(sqInt theMethod, sqInt methodHeader);
sqInt checkAllAccessibleObjectsOkay(void);
sqInt checkOkayInterpreterObjects(sqInt writeBack);
sqInt copiedValueCountOfClosure(sqInt closurePointer);
sqInt doSignalSemaphoreWithIndex(sqInt index);
void (*functionPointerForinClass(sqInt primIdx,sqInt theClass))(void) ;
usqLong getNextWakeupUsecs(void);
sqInt * getStackPointer(void);
sqInt headerIndicatesAlternateBytecodeSet(sqInt methodHeader);
sqInt highBit(usqInt anUnsignedValue);
sqInt initialPCForHeadermethod(sqInt methodHeader, sqInt theMethod);
sqInt isQuickPrimitiveIndex(sqInt anInteger);
sqInt isReadMediatedContextInstVarIndex(sqInt index);
sqInt isWriteMediatedContextInstVarIndex(sqInt index);
sqInt isKindOfClass(sqInt oop, sqInt aClass);
sqInt literalCountOfHeader(sqInt headerPointer);
sqInt literalofMethod(sqInt offset, sqInt methodPointer);
void longPrintOop(sqInt oop);
sqInt longStoreBytecodeForHeader(sqInt methodHeader);
sqInt methodClassAssociationOf(sqInt methodPointer);
sqInt methodClassOf(sqInt methodPointer);
sqInt methodPrimitiveIndex(void);
sqInt methodUsesAlternateBytecodeSet(sqInt aMethodObj);
sqInt penultimateLiteralOf(sqInt aMethodOop);
sqInt popStack(void);
sqInt primitiveIndexOfMethodheader(sqInt theMethod, sqInt methodHeader);
sqInt primitiveIndexOf(sqInt methodPointer);
void printAllStacks(void);
sqInt printCallStackOf(sqInt aContextOrProcessOrFrame);
void printChar(sqInt aByte);
void printHex(sqInt n);
void printLikelyImplementorsOfSelector(sqInt selector);
void printMethodCache(void);
void printMethodDictionaryOf(sqInt behavior);
void printMethodDictionary(sqInt dictionary);
void printProcessStack(sqInt aProcess);
sqInt printProcsOnList(sqInt procList);
sqInt printStackCallStackOf(char *aFramePointer);
void print(char *s);
void setBreakSelector(char *aString);
void setNextWakeupUsecs(usqLong value);
void shortPrintFrameAndNCallers(char *theFP, sqInt n);
sqInt sizeOfCallPrimitiveBytecode(sqInt methodHeader);
sqInt sizeOfLongStoreTempBytecode(sqInt methodHeader);
sqInt specialSelector(sqInt index);
unsigned long stackPositiveMachineIntegerValue(sqInt offset);
long stackSignedMachineIntegerValue(sqInt offset);
sqInt stackTop(void);
sqInt stackValue(sqInt offset);
sqInt startPCOfMethod(sqInt aCompiledMethod);
sqInt stringForCString(const char *aCString);
sqInt tempCountOf(sqInt methodPointer);
sqInt temporaryCountOfMethodHeader(sqInt header);


/*** Global Variables ***/
char * breakSelector;
sqInt breakSelectorLength ;
sqInt checkAllocFiller;
sqInt checkForLeaks;
sqInt deferDisplayUpdates;
sqInt desiredCogCodeSize;
sqInt desiredEdenBytes;
sqInt desiredNumStackPages;
sqInt extraVMMemory;
usqInt heapBase;
sqInt inIOProcessEvents;
struct VirtualMachine* interpreterProxy;
sqInt maxLiteralCountForCompile ;
sqInt minBackwardJumpCountForCompile ;
volatile int sendTrace;
void * showSurfaceFn;
sqInt suppressHeartbeatFlag;


/*** Macros ***/
#define compilationBreakpoint(sel, len) do { \
	if ((len) == breakSelectorLength \
	 && !strncmp((char *)((sel) + BaseHeaderSize), breakSelector, breakSelectorLength)) { \
		suppressHeartbeatFlag = 1; \
		compilationBreakpointFor(sel); \
	} \
} while (0)
#define startOfMemory() heapBase
#define wordSize() 4

