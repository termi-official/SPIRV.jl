@enum Id::Int begin
    IdResultType      = 1
    IdResult          = 2
    IdMemorySemantics = 3
    IdScope           = 4
    IdRef             = 5
end

@enum Literal::Int begin
    LiteralInteger                = 1
    LiteralString                 = 2
    LiteralContextDependentNumber = 3
    LiteralExtInstInteger         = 4
    LiteralSpecConstantOpInteger  = 5
end

@enum Composite::Int begin
    PairLiteralIntegerIdRef = 1
    PairIdRefLiteralInteger = 2
    PairIdRefIdRef = 3
end

@cenum ImageOperands::UInt32 begin
    ImageOperandsNone                  = 0x0000
    ImageOperandsBias                  = 0x0001
    ImageOperandsLod                   = 0x0002
    ImageOperandsGrad                  = 0x0004
    ImageOperandsConstOffset           = 0x0008
    ImageOperandsOffset                = 0x0010
    ImageOperandsConstOffsets          = 0x0020
    ImageOperandsSample                = 0x0040
    ImageOperandsMinLod                = 0x0080
    ImageOperandsMakeTexelAvailable    = 0x0100
    ImageOperandsMakeTexelAvailableKHR = 0x0100
    ImageOperandsMakeTexelVisible      = 0x0200
    ImageOperandsMakeTexelVisibleKHR   = 0x0200
    ImageOperandsNonPrivateTexel       = 0x0400
    ImageOperandsNonPrivateTexelKHR    = 0x0400
    ImageOperandsVolatileTexel         = 0x0800
    ImageOperandsVolatileTexelKHR      = 0x0800
    ImageOperandsSignExtend            = 0x1000
    ImageOperandsZeroExtend            = 0x2000
end

@cenum FPFastMathMode::UInt32 begin
    FPFastMathModeNone       = 0x0000
    FPFastMathModeNotNaN     = 0x0001
    FPFastMathModeNotInf     = 0x0002
    FPFastMathModeNSZ        = 0x0004
    FPFastMathModeAllowRecip = 0x0008
    FPFastMathModeFast       = 0x0010
end

@cenum SelectionControl::UInt32 begin
    SelectionControlNone        = 0x0000
    SelectionControlFlatten     = 0x0001
    SelectionControlDontFlatten = 0x0002
end

@cenum LoopControl::UInt32 begin
    LoopControlNone               = 0x0000
    LoopControlUnroll             = 0x0001
    LoopControlDontUnroll         = 0x0002
    LoopControlDependencyInfinite = 0x0004
    LoopControlDependencyLength   = 0x0008
    LoopControlMinIterations      = 0x0010
    LoopControlMaxIterations      = 0x0020
    LoopControlIterationMultiple  = 0x0040
    LoopControlPeelCount          = 0x0080
    LoopControlPartialCount       = 0x0100
end

@cenum FunctionControl::UInt32 begin
    FunctionControlNone       = 0x0000
    FunctionControlInline     = 0x0001
    FunctionControlDontInline = 0x0002
    FunctionControlPure       = 0x0004
    FunctionControlConst      = 0x0008
end

@cenum MemorySemantics::UInt32 begin
    MemorySemanticsRelaxed                = 0x0000
    MemorySemanticsNone                   = 0x0000
    MemorySemanticsAcquire                = 0x0002
    MemorySemanticsRelease                = 0x0004
    MemorySemanticsAcquireRelease         = 0x0008
    MemorySemanticsSequentiallyConsistent = 0x0010
    MemorySemanticsUniformMemory          = 0x0040
    MemorySemanticsSubgroupMemory         = 0x0080
    MemorySemanticsWorkgroupMemory        = 0x0100
    MemorySemanticsCrossWorkgroupMemory   = 0x0200
    MemorySemanticsAtomicCounterMemory    = 0x0400
    MemorySemanticsImageMemory            = 0x0800
    MemorySemanticsOutputMemory           = 0x1000
    MemorySemanticsOutputMemoryKHR        = 0x1000
    MemorySemanticsMakeAvailable          = 0x2000
    MemorySemanticsMakeAvailableKHR       = 0x2000
    MemorySemanticsMakeVisible            = 0x4000
    MemorySemanticsMakeVisibleKHR         = 0x4000
    MemorySemanticsVolatile               = 0x8000
end

@cenum MemoryAccess::UInt32 begin
    MemoryAccessNone                    = 0x0000
    MemoryAccessVolatile                = 0x0001
    MemoryAccessAligned                 = 0x0002
    MemoryAccessNontemporal             = 0x0004
    MemoryAccessMakePointerAvailable    = 0x0008
    MemoryAccessMakePointerAvailableKHR = 0x0008
    MemoryAccessMakePointerVisible      = 0x0010
    MemoryAccessMakePointerVisibleKHR   = 0x0010
    MemoryAccessNonPrivatePointer       = 0x0020
    MemoryAccessNonPrivatePointerKHR    = 0x0020
end

@cenum KernelProfilingInfo::UInt32 begin
    KernelProfilingInfoNone        = 0x0000
    KernelProfilingInfoCmdExecTime = 0x0001
end

@cenum RayFlags::UInt32 begin
    RayFlagsNoneKHR                     = 0x0000
    RayFlagsOpaqueKHR                   = 0x0001
    RayFlagsNoOpaqueKHR                 = 0x0002
    RayFlagsTerminateOnFirstHitKHR      = 0x0004
    RayFlagsSkipClosestHitShaderKHR     = 0x0008
    RayFlagsCullBackFacingTrianglesKHR  = 0x0010
    RayFlagsCullFrontFacingTrianglesKHR = 0x0020
    RayFlagsCullOpaqueKHR               = 0x0040
    RayFlagsCullNoOpaqueKHR             = 0x0080
    RayFlagsSkipTrianglesKHR            = 0x0100
    RayFlagsSkipAABBsKHR                = 0x0200
end

@cenum SourceLanguage::UInt32 begin
    SourceLanguageUnknown    = 0
    SourceLanguageESSL       = 1
    SourceLanguageGLSL       = 2
    SourceLanguageOpenCL_C   = 3
    SourceLanguageOpenCL_CPP = 4
    SourceLanguageHLSL       = 5
end

@cenum ExecutionModel::UInt32 begin
    ExecutionModelVertex                 = 0
    ExecutionModelTessellationControl    = 1
    ExecutionModelTessellationEvaluation = 2
    ExecutionModelGeometry               = 3
    ExecutionModelFragment               = 4
    ExecutionModelGLCompute              = 5
    ExecutionModelKernel                 = 6
    ExecutionModelTaskNV                 = 5267
    ExecutionModelMeshNV                 = 5268
    ExecutionModelRayGenerationNV        = 5313
    ExecutionModelRayGenerationKHR       = 5313
    ExecutionModelIntersectionNV         = 5314
    ExecutionModelIntersectionKHR        = 5314
    ExecutionModelAnyHitNV               = 5315
    ExecutionModelAnyHitKHR              = 5315
    ExecutionModelClosestHitNV           = 5316
    ExecutionModelClosestHitKHR          = 5316
    ExecutionModelMissNV                 = 5317
    ExecutionModelMissKHR                = 5317
    ExecutionModelCallableNV             = 5318
    ExecutionModelCallableKHR            = 5318
end

@cenum AddressingModel::UInt32 begin
    AddressingModelLogical                    = 0
    AddressingModelPhysical32                 = 1
    AddressingModelPhysical64                 = 2
    AddressingModelPhysicalStorageBuffer64    = 5348
    AddressingModelPhysicalStorageBuffer64EXT = 5348
end

@cenum MemoryModel::UInt32 begin
    MemoryModelSimple    = 0
    MemoryModelGLSL450   = 1
    MemoryModelOpenCL    = 2
    MemoryModelVulkan    = 3
    MemoryModelVulkanKHR = 3
end

@cenum ExecutionMode::UInt32 begin
    ExecutionModeInvocations                      = 0
    ExecutionModeSpacingEqual                     = 1
    ExecutionModeSpacingFractionalEven            = 2
    ExecutionModeSpacingFractionalOdd             = 3
    ExecutionModeVertexOrderCw                    = 4
    ExecutionModeVertexOrderCcw                   = 5
    ExecutionModePixelCenterInteger               = 6
    ExecutionModeOriginUpperLeft                  = 7
    ExecutionModeOriginLowerLeft                  = 8
    ExecutionModeEarlyFragmentTests               = 9
    ExecutionModePointMode                        = 10
    ExecutionModeXfb                              = 11
    ExecutionModeDepthReplacing                   = 12
    ExecutionModeDepthGreater                     = 14
    ExecutionModeDepthLess                        = 15
    ExecutionModeDepthUnchanged                   = 16
    ExecutionModeLocalSize                        = 17
    ExecutionModeLocalSizeHint                    = 18
    ExecutionModeInputPoints                      = 19
    ExecutionModeInputLines                       = 20
    ExecutionModeInputLinesAdjacency              = 21
    ExecutionModeTriangles                        = 22
    ExecutionModeInputTrianglesAdjacency          = 23
    ExecutionModeQuads                            = 24
    ExecutionModeIsolines                         = 25
    ExecutionModeOutputVertices                   = 26
    ExecutionModeOutputPoints                     = 27
    ExecutionModeOutputLineStrip                  = 28
    ExecutionModeOutputTriangleStrip              = 29
    ExecutionModeVecTypeHint                      = 30
    ExecutionModeContractionOff                   = 31
    ExecutionModeInitializer                      = 33
    ExecutionModeFinalizer                        = 34
    ExecutionModeSubgroupSize                     = 35
    ExecutionModeSubgroupsPerWorkgroup            = 36
    ExecutionModeSubgroupsPerWorkgroupId          = 37
    ExecutionModeLocalSizeId                      = 38
    ExecutionModeLocalSizeHintId                  = 39
    ExecutionModePostDepthCoverage                = 4446
    ExecutionModeDenormPreserve                   = 4459
    ExecutionModeDenormFlushToZero                = 4460
    ExecutionModeSignedZeroInfNanPreserve         = 4461
    ExecutionModeRoundingModeRTE                  = 4462
    ExecutionModeRoundingModeRTZ                  = 4463
    ExecutionModeStencilRefReplacingEXT           = 5027
    ExecutionModeOutputLinesNV                    = 5269
    ExecutionModeOutputPrimitivesNV               = 5270
    ExecutionModeDerivativeGroupQuadsNV           = 5289
    ExecutionModeDerivativeGroupLinearNV          = 5290
    ExecutionModeOutputTrianglesNV                = 5298
    ExecutionModePixelInterlockOrderedEXT         = 5366
    ExecutionModePixelInterlockUnorderedEXT       = 5367
    ExecutionModeSampleInterlockOrderedEXT        = 5368
    ExecutionModeSampleInterlockUnorderedEXT      = 5369
    ExecutionModeShadingRateInterlockOrderedEXT   = 5370
    ExecutionModeShadingRateInterlockUnorderedEXT = 5371
end

@cenum StorageClass::UInt32 begin
    StorageClassUniformConstant          = 0
    StorageClassInput                    = 1
    StorageClassUniform                  = 2
    StorageClassOutput                   = 3
    StorageClassWorkgroup                = 4
    StorageClassCrossWorkgroup           = 5
    StorageClassPrivate                  = 6
    StorageClassFunction                 = 7
    StorageClassGeneric                  = 8
    StorageClassPushConstant             = 9
    StorageClassAtomicCounter            = 10
    StorageClassImage                    = 11
    StorageClassStorageBuffer            = 12
    StorageClassCallableDataNV           = 5328
    StorageClassCallableDataKHR          = 5328
    StorageClassIncomingCallableDataNV   = 5329
    StorageClassIncomingCallableDataKHR  = 5329
    StorageClassRayPayloadNV             = 5338
    StorageClassRayPayloadKHR            = 5338
    StorageClassHitAttributeNV           = 5339
    StorageClassHitAttributeKHR          = 5339
    StorageClassIncomingRayPayloadNV     = 5342
    StorageClassIncomingRayPayloadKHR    = 5342
    StorageClassShaderRecordBufferNV     = 5343
    StorageClassShaderRecordBufferKHR    = 5343
    StorageClassPhysicalStorageBuffer    = 5349
    StorageClassPhysicalStorageBufferEXT = 5349
end

@cenum Dim::UInt32 begin
    Dim1D          = 0
    Dim2D          = 1
    Dim3D          = 2
    DimCube        = 3
    DimRect        = 4
    DimBuffer      = 5
    DimSubpassData = 6
end

@cenum SamplerAddressingMode::UInt32 begin
    SamplerAddressingModeNone           = 0
    SamplerAddressingModeClampToEdge    = 1
    SamplerAddressingModeClamp          = 2
    SamplerAddressingModeRepeat         = 3
    SamplerAddressingModeRepeatMirrored = 4
end

@cenum SamplerFilterMode::UInt32 begin
    SamplerFilterModeNearest = 0
    SamplerFilterModeLinear  = 1
end

@cenum ImageFormat::UInt32 begin
    ImageFormatUnknown      = 0
    ImageFormatRgba32f      = 1
    ImageFormatRgba16f      = 2
    ImageFormatR32f         = 3
    ImageFormatRgba8        = 4
    ImageFormatRgba8Snorm   = 5
    ImageFormatRg32f        = 6
    ImageFormatRg16f        = 7
    ImageFormatR11fG11fB10f = 8
    ImageFormatR16f         = 9
    ImageFormatRgba16       = 10
    ImageFormatRgb10A2      = 11
    ImageFormatRg16         = 12
    ImageFormatRg8          = 13
    ImageFormatR16          = 14
    ImageFormatR8           = 15
    ImageFormatRgba16Snorm  = 16
    ImageFormatRg16Snorm    = 17
    ImageFormatRg8Snorm     = 18
    ImageFormatR16Snorm     = 19
    ImageFormatR8Snorm      = 20
    ImageFormatRgba32i      = 21
    ImageFormatRgba16i      = 22
    ImageFormatRgba8i       = 23
    ImageFormatR32i         = 24
    ImageFormatRg32i        = 25
    ImageFormatRg16i        = 26
    ImageFormatRg8i         = 27
    ImageFormatR16i         = 28
    ImageFormatR8i          = 29
    ImageFormatRgba32ui     = 30
    ImageFormatRgba16ui     = 31
    ImageFormatRgba8ui      = 32
    ImageFormatR32ui        = 33
    ImageFormatRgb10a2ui    = 34
    ImageFormatRg32ui       = 35
    ImageFormatRg16ui       = 36
    ImageFormatRg8ui        = 37
    ImageFormatR16ui        = 38
    ImageFormatR8ui         = 39
end

@cenum ImageChannelOrder::UInt32 begin
    ImageChannelOrderR            = 0
    ImageChannelOrderA            = 1
    ImageChannelOrderRG           = 2
    ImageChannelOrderRA           = 3
    ImageChannelOrderRGB          = 4
    ImageChannelOrderRGBA         = 5
    ImageChannelOrderBGRA         = 6
    ImageChannelOrderARGB         = 7
    ImageChannelOrderIntensity    = 8
    ImageChannelOrderLuminance    = 9
    ImageChannelOrderRx           = 10
    ImageChannelOrderRGx          = 11
    ImageChannelOrderRGBx         = 12
    ImageChannelOrderDepth        = 13
    ImageChannelOrderDepthStencil = 14
    ImageChannelOrdersRGB         = 15
    ImageChannelOrdersRGBx        = 16
    ImageChannelOrdersRGBA        = 17
    ImageChannelOrdersBGRA        = 18
    ImageChannelOrderABGR         = 19
end

@cenum ImageChannelDataType::UInt32 begin
    ImageChannelDataTypeSnormInt8        = 0
    ImageChannelDataTypeSnormInt16       = 1
    ImageChannelDataTypeUnormInt8        = 2
    ImageChannelDataTypeUnormInt16       = 3
    ImageChannelDataTypeUnormShort565    = 4
    ImageChannelDataTypeUnormShort555    = 5
    ImageChannelDataTypeUnormInt101010   = 6
    ImageChannelDataTypeSignedInt8       = 7
    ImageChannelDataTypeSignedInt16      = 8
    ImageChannelDataTypeSignedInt32      = 9
    ImageChannelDataTypeUnsignedInt8     = 10
    ImageChannelDataTypeUnsignedInt16    = 11
    ImageChannelDataTypeUnsignedInt32    = 12
    ImageChannelDataTypeHalfFloat        = 13
    ImageChannelDataTypeFloat            = 14
    ImageChannelDataTypeUnormInt24       = 15
    ImageChannelDataTypeUnormInt101010_2 = 16
end

@cenum FPRoundingMode::UInt32 begin
    FPRoundingModeRTE = 0
    FPRoundingModeRTZ = 1
    FPRoundingModeRTP = 2
    FPRoundingModeRTN = 3
end

@cenum LinkageType::UInt32 begin
    LinkageTypeExport = 0
    LinkageTypeImport = 1
end

@cenum AccessQualifier::UInt32 begin
    AccessQualifierReadOnly  = 0
    AccessQualifierWriteOnly = 1
    AccessQualifierReadWrite = 2
end

@cenum FunctionParameterAttribute::UInt32 begin
    FunctionParameterAttributeZext        = 0
    FunctionParameterAttributeSext        = 1
    FunctionParameterAttributeByVal       = 2
    FunctionParameterAttributeSret        = 3
    FunctionParameterAttributeNoAlias     = 4
    FunctionParameterAttributeNoCapture   = 5
    FunctionParameterAttributeNoWrite     = 6
    FunctionParameterAttributeNoReadWrite = 7
end

@cenum Decoration::UInt32 begin
    DecorationRelaxedPrecision            = 0
    DecorationSpecId                      = 1
    DecorationBlock                       = 2
    DecorationBufferBlock                 = 3
    DecorationRowMajor                    = 4
    DecorationColMajor                    = 5
    DecorationArrayStride                 = 6
    DecorationMatrixStride                = 7
    DecorationGLSLShared                  = 8
    DecorationGLSLPacked                  = 9
    DecorationCPacked                     = 10
    DecorationBuiltIn                     = 11
    DecorationNoPerspective               = 13
    DecorationFlat                        = 14
    DecorationPatch                       = 15
    DecorationCentroid                    = 16
    DecorationSample                      = 17
    DecorationInvariant                   = 18
    DecorationRestrict                    = 19
    DecorationAliased                     = 20
    DecorationVolatile                    = 21
    DecorationConstant                    = 22
    DecorationCoherent                    = 23
    DecorationNonWritable                 = 24
    DecorationNonReadable                 = 25
    DecorationUniform                     = 26
    DecorationUniformId                   = 27
    DecorationSaturatedConversion         = 28
    DecorationStream                      = 29
    DecorationLocation                    = 30
    DecorationComponent                   = 31
    DecorationIndex                       = 32
    DecorationBinding                     = 33
    DecorationDescriptorSet               = 34
    DecorationOffset                      = 35
    DecorationXfbBuffer                   = 36
    DecorationXfbStride                   = 37
    DecorationFuncParamAttr               = 38
    DecorationFPRoundingMode              = 39
    DecorationFPFastMathMode              = 40
    DecorationLinkageAttributes           = 41
    DecorationNoContraction               = 42
    DecorationInputAttachmentIndex        = 43
    DecorationAlignment                   = 44
    DecorationMaxByteOffset               = 45
    DecorationAlignmentId                 = 46
    DecorationMaxByteOffsetId             = 47
    DecorationNoSignedWrap                = 4469
    DecorationNoUnsignedWrap              = 4470
    DecorationExplicitInterpAMD           = 4999
    DecorationOverrideCoverageNV          = 5248
    DecorationPassthroughNV               = 5250
    DecorationViewportRelativeNV          = 5252
    DecorationSecondaryViewportRelativeNV = 5256
    DecorationPerPrimitiveNV              = 5271
    DecorationPerViewNV                   = 5272
    DecorationPerTaskNV                   = 5273
    DecorationPerVertexNV                 = 5285
    DecorationNonUniform                  = 5300
    DecorationNonUniformEXT               = 5300
    DecorationRestrictPointer             = 5355
    DecorationRestrictPointerEXT          = 5355
    DecorationAliasedPointer              = 5356
    DecorationAliasedPointerEXT           = 5356
    DecorationCounterBuffer               = 5634
    DecorationHlslCounterBufferGOOGLE     = 5634
    DecorationUserSemantic                = 5635
    DecorationHlslSemanticGOOGLE          = 5635
    DecorationUserTypeGOOGLE              = 5636
end

@cenum BuiltIn::UInt32 begin
    BuiltInPosition                    = 0
    BuiltInPointSize                   = 1
    BuiltInClipDistance                = 3
    BuiltInCullDistance                = 4
    BuiltInVertexId                    = 5
    BuiltInInstanceId                  = 6
    BuiltInPrimitiveId                 = 7
    BuiltInInvocationId                = 8
    BuiltInLayer                       = 9
    BuiltInViewportIndex               = 10
    BuiltInTessLevelOuter              = 11
    BuiltInTessLevelInner              = 12
    BuiltInTessCoord                   = 13
    BuiltInPatchVertices               = 14
    BuiltInFragCoord                   = 15
    BuiltInPointCoord                  = 16
    BuiltInFrontFacing                 = 17
    BuiltInSampleId                    = 18
    BuiltInSamplePosition              = 19
    BuiltInSampleMask                  = 20
    BuiltInFragDepth                   = 22
    BuiltInHelperInvocation            = 23
    BuiltInNumWorkgroups               = 24
    BuiltInWorkgroupSize               = 25
    BuiltInWorkgroupId                 = 26
    BuiltInLocalInvocationId           = 27
    BuiltInGlobalInvocationId          = 28
    BuiltInLocalInvocationIndex        = 29
    BuiltInWorkDim                     = 30
    BuiltInGlobalSize                  = 31
    BuiltInEnqueuedWorkgroupSize       = 32
    BuiltInGlobalOffset                = 33
    BuiltInGlobalLinearId              = 34
    BuiltInSubgroupSize                = 36
    BuiltInSubgroupMaxSize             = 37
    BuiltInNumSubgroups                = 38
    BuiltInNumEnqueuedSubgroups        = 39
    BuiltInSubgroupId                  = 40
    BuiltInSubgroupLocalInvocationId   = 41
    BuiltInVertexIndex                 = 42
    BuiltInInstanceIndex               = 43
    BuiltInSubgroupEqMask              = 4416
    BuiltInSubgroupGeMask              = 4417
    BuiltInSubgroupGtMask              = 4418
    BuiltInSubgroupLeMask              = 4419
    BuiltInSubgroupLtMask              = 4420
    BuiltInSubgroupEqMaskKHR           = 4416
    BuiltInSubgroupGeMaskKHR           = 4417
    BuiltInSubgroupGtMaskKHR           = 4418
    BuiltInSubgroupLeMaskKHR           = 4419
    BuiltInSubgroupLtMaskKHR           = 4420
    BuiltInBaseVertex                  = 4424
    BuiltInBaseInstance                = 4425
    BuiltInDrawIndex                   = 4426
    BuiltInDeviceIndex                 = 4438
    BuiltInViewIndex                   = 4440
    BuiltInBaryCoordNoPerspAMD         = 4992
    BuiltInBaryCoordNoPerspCentroidAMD = 4993
    BuiltInBaryCoordNoPerspSampleAMD   = 4994
    BuiltInBaryCoordSmoothAMD          = 4995
    BuiltInBaryCoordSmoothCentroidAMD  = 4996
    BuiltInBaryCoordSmoothSampleAMD    = 4997
    BuiltInBaryCoordPullModelAMD       = 4998
    BuiltInFragStencilRefEXT           = 5014
    BuiltInViewportMaskNV              = 5253
    BuiltInSecondaryPositionNV         = 5257
    BuiltInSecondaryViewportMaskNV     = 5258
    BuiltInPositionPerViewNV           = 5261
    BuiltInViewportMaskPerViewNV       = 5262
    BuiltInFullyCoveredEXT             = 5264
    BuiltInTaskCountNV                 = 5274
    BuiltInPrimitiveCountNV            = 5275
    BuiltInPrimitiveIndicesNV          = 5276
    BuiltInClipDistancePerViewNV       = 5277
    BuiltInCullDistancePerViewNV       = 5278
    BuiltInLayerPerViewNV              = 5279
    BuiltInMeshViewCountNV             = 5280
    BuiltInMeshViewIndicesNV           = 5281
    BuiltInBaryCoordNV                 = 5286
    BuiltInBaryCoordNoPerspNV          = 5287
    BuiltInFragSizeEXT                 = 5292
    BuiltInFragmentSizeNV              = 5292
    BuiltInFragInvocationCountEXT      = 5293
    BuiltInInvocationsPerPixelNV       = 5293
    BuiltInLaunchIdNV                  = 5319
    BuiltInLaunchIdKHR                 = 5319
    BuiltInLaunchSizeNV                = 5320
    BuiltInLaunchSizeKHR               = 5320
    BuiltInWorldRayOriginNV            = 5321
    BuiltInWorldRayOriginKHR           = 5321
    BuiltInWorldRayDirectionNV         = 5322
    BuiltInWorldRayDirectionKHR        = 5322
    BuiltInObjectRayOriginNV           = 5323
    BuiltInObjectRayOriginKHR          = 5323
    BuiltInObjectRayDirectionNV        = 5324
    BuiltInObjectRayDirectionKHR       = 5324
    BuiltInRayTminNV                   = 5325
    BuiltInRayTminKHR                  = 5325
    BuiltInRayTmaxNV                   = 5326
    BuiltInRayTmaxKHR                  = 5326
    BuiltInInstanceCustomIndexNV       = 5327
    BuiltInInstanceCustomIndexKHR      = 5327
    BuiltInObjectToWorldNV             = 5330
    BuiltInObjectToWorldKHR            = 5330
    BuiltInWorldToObjectNV             = 5331
    BuiltInWorldToObjectKHR            = 5331
    BuiltInHitTNV                      = 5332
    BuiltInHitTKHR                     = 5332
    BuiltInHitKindNV                   = 5333
    BuiltInHitKindKHR                  = 5333
    BuiltInIncomingRayFlagsNV          = 5351
    BuiltInIncomingRayFlagsKHR         = 5351
    BuiltInRayGeometryIndexKHR         = 5352
    BuiltInWarpsPerSMNV                = 5374
    BuiltInSMCountNV                   = 5375
    BuiltInWarpIDNV                    = 5376
    BuiltInSMIDNV                      = 5377
end

@cenum Scope::UInt32 begin
    ScopeCrossDevice    = 0
    ScopeDevice         = 1
    ScopeWorkgroup      = 2
    ScopeSubgroup       = 3
    ScopeInvocation     = 4
    ScopeQueueFamily    = 5
    ScopeQueueFamilyKHR = 5
    ScopeShaderCallKHR  = 6
end

@cenum GroupOperation::UInt32 begin
    GroupOperationReduce                     = 0
    GroupOperationInclusiveScan              = 1
    GroupOperationExclusiveScan              = 2
    GroupOperationClusteredReduce            = 3
    GroupOperationPartitionedReduceNV        = 6
    GroupOperationPartitionedInclusiveScanNV = 7
    GroupOperationPartitionedExclusiveScanNV = 8
end

@cenum KernelEnqueueFlags::UInt32 begin
    KernelEnqueueFlagsNoWait        = 0
    KernelEnqueueFlagsWaitKernel    = 1
    KernelEnqueueFlagsWaitWorkGroup = 2
end

@cenum Capability::UInt32 begin
    CapabilityMatrix                                       = 0
    CapabilityShader                                       = 1
    CapabilityGeometry                                     = 2
    CapabilityTessellation                                 = 3
    CapabilityAddresses                                    = 4
    CapabilityLinkage                                      = 5
    CapabilityKernel                                       = 6
    CapabilityVector16                                     = 7
    CapabilityFloat16Buffer                                = 8
    CapabilityFloat16                                      = 9
    CapabilityFloat64                                      = 10
    CapabilityInt64                                        = 11
    CapabilityInt64Atomics                                 = 12
    CapabilityImageBasic                                   = 13
    CapabilityImageReadWrite                               = 14
    CapabilityImageMipmap                                  = 15
    CapabilityPipes                                        = 17
    CapabilityGroups                                       = 18
    CapabilityDeviceEnqueue                                = 19
    CapabilityLiteralSampler                               = 20
    CapabilityAtomicStorage                                = 21
    CapabilityInt16                                        = 22
    CapabilityTessellationPointSize                        = 23
    CapabilityGeometryPointSize                            = 24
    CapabilityImageGatherExtended                          = 25
    CapabilityStorageImageMultisample                      = 27
    CapabilityUniformBufferArrayDynamicIndexing            = 28
    CapabilitySampledImageArrayDynamicIndexing             = 29
    CapabilityStorageBufferArrayDynamicIndexing            = 30
    CapabilityStorageImageArrayDynamicIndexing             = 31
    CapabilityClipDistance                                 = 32
    CapabilityCullDistance                                 = 33
    CapabilityImageCubeArray                               = 34
    CapabilitySampleRateShading                            = 35
    CapabilityImageRect                                    = 36
    CapabilitySampledRect                                  = 37
    CapabilityGenericPointer                               = 38
    CapabilityInt8                                         = 39
    CapabilityInputAttachment                              = 40
    CapabilitySparseResidency                              = 41
    CapabilityMinLod                                       = 42
    CapabilitySampled1D                                    = 43
    CapabilityImage1D                                      = 44
    CapabilitySampledCubeArray                             = 45
    CapabilitySampledBuffer                                = 46
    CapabilityImageBuffer                                  = 47
    CapabilityImageMSArray                                 = 48
    CapabilityStorageImageExtendedFormats                  = 49
    CapabilityImageQuery                                   = 50
    CapabilityDerivativeControl                            = 51
    CapabilityInterpolationFunction                        = 52
    CapabilityTransformFeedback                            = 53
    CapabilityGeometryStreams                              = 54
    CapabilityStorageImageReadWithoutFormat                = 55
    CapabilityStorageImageWriteWithoutFormat               = 56
    CapabilityMultiViewport                                = 57
    CapabilitySubgroupDispatch                             = 58
    CapabilityNamedBarrier                                 = 59
    CapabilityPipeStorage                                  = 60
    CapabilityGroupNonUniform                              = 61
    CapabilityGroupNonUniformVote                          = 62
    CapabilityGroupNonUniformArithmetic                    = 63
    CapabilityGroupNonUniformBallot                        = 64
    CapabilityGroupNonUniformShuffle                       = 65
    CapabilityGroupNonUniformShuffleRelative               = 66
    CapabilityGroupNonUniformClustered                     = 67
    CapabilityGroupNonUniformQuad                          = 68
    CapabilityShaderLayer                                  = 69
    CapabilityShaderViewportIndex                          = 70
    CapabilitySubgroupBallotKHR                            = 4423
    CapabilityDrawParameters                               = 4427
    CapabilitySubgroupVoteKHR                              = 4431
    CapabilityStorageBuffer16BitAccess                     = 4433
    CapabilityStorageUniformBufferBlock16                  = 4433
    CapabilityUniformAndStorageBuffer16BitAccess           = 4434
    CapabilityStorageUniform16                             = 4434
    CapabilityStoragePushConstant16                        = 4435
    CapabilityStorageInputOutput16                         = 4436
    CapabilityDeviceGroup                                  = 4437
    CapabilityMultiView                                    = 4439
    CapabilityVariablePointersStorageBuffer                = 4441
    CapabilityVariablePointers                             = 4442
    CapabilityAtomicStorageOps                             = 4445
    CapabilitySampleMaskPostDepthCoverage                  = 4447
    CapabilityStorageBuffer8BitAccess                      = 4448
    CapabilityUniformAndStorageBuffer8BitAccess            = 4449
    CapabilityStoragePushConstant8                         = 4450
    CapabilityDenormPreserve                               = 4464
    CapabilityDenormFlushToZero                            = 4465
    CapabilitySignedZeroInfNanPreserve                     = 4466
    CapabilityRoundingModeRTE                              = 4467
    CapabilityRoundingModeRTZ                              = 4468
    CapabilityRayQueryProvisionalKHR                       = 4471
    CapabilityRayTraversalPrimitiveCullingProvisionalKHR   = 4478
    CapabilityFloat16ImageAMD                              = 5008
    CapabilityImageGatherBiasLodAMD                        = 5009
    CapabilityFragmentMaskAMD                              = 5010
    CapabilityStencilExportEXT                             = 5013
    CapabilityImageReadWriteLodAMD                         = 5015
    CapabilityShaderClockKHR                               = 5055
    CapabilitySampleMaskOverrideCoverageNV                 = 5249
    CapabilityGeometryShaderPassthroughNV                  = 5251
    CapabilityShaderViewportIndexLayerEXT                  = 5254
    CapabilityShaderViewportIndexLayerNV                   = 5254
    CapabilityShaderViewportMaskNV                         = 5255
    CapabilityShaderStereoViewNV                           = 5259
    CapabilityPerViewAttributesNV                          = 5260
    CapabilityFragmentFullyCoveredEXT                      = 5265
    CapabilityMeshShadingNV                                = 5266
    CapabilityImageFootprintNV                             = 5282
    CapabilityFragmentBarycentricNV                        = 5284
    CapabilityComputeDerivativeGroupQuadsNV                = 5288
    CapabilityFragmentDensityEXT                           = 5291
    CapabilityShadingRateNV                                = 5291
    CapabilityGroupNonUniformPartitionedNV                 = 5297
    CapabilityShaderNonUniform                             = 5301
    CapabilityShaderNonUniformEXT                          = 5301
    CapabilityRuntimeDescriptorArray                       = 5302
    CapabilityRuntimeDescriptorArrayEXT                    = 5302
    CapabilityInputAttachmentArrayDynamicIndexing          = 5303
    CapabilityInputAttachmentArrayDynamicIndexingEXT       = 5303
    CapabilityUniformTexelBufferArrayDynamicIndexing       = 5304
    CapabilityUniformTexelBufferArrayDynamicIndexingEXT    = 5304
    CapabilityStorageTexelBufferArrayDynamicIndexing       = 5305
    CapabilityStorageTexelBufferArrayDynamicIndexingEXT    = 5305
    CapabilityUniformBufferArrayNonUniformIndexing         = 5306
    CapabilityUniformBufferArrayNonUniformIndexingEXT      = 5306
    CapabilitySampledImageArrayNonUniformIndexing          = 5307
    CapabilitySampledImageArrayNonUniformIndexingEXT       = 5307
    CapabilityStorageBufferArrayNonUniformIndexing         = 5308
    CapabilityStorageBufferArrayNonUniformIndexingEXT      = 5308
    CapabilityStorageImageArrayNonUniformIndexing          = 5309
    CapabilityStorageImageArrayNonUniformIndexingEXT       = 5309
    CapabilityInputAttachmentArrayNonUniformIndexing       = 5310
    CapabilityInputAttachmentArrayNonUniformIndexingEXT    = 5310
    CapabilityUniformTexelBufferArrayNonUniformIndexing    = 5311
    CapabilityUniformTexelBufferArrayNonUniformIndexingEXT = 5311
    CapabilityStorageTexelBufferArrayNonUniformIndexing    = 5312
    CapabilityStorageTexelBufferArrayNonUniformIndexingEXT = 5312
    CapabilityRayTracingNV                                 = 5340
    CapabilityVulkanMemoryModel                            = 5345
    CapabilityVulkanMemoryModelKHR                         = 5345
    CapabilityVulkanMemoryModelDeviceScope                 = 5346
    CapabilityVulkanMemoryModelDeviceScopeKHR              = 5346
    CapabilityPhysicalStorageBufferAddresses               = 5347
    CapabilityPhysicalStorageBufferAddressesEXT            = 5347
    CapabilityComputeDerivativeGroupLinearNV               = 5350
    CapabilityRayTracingProvisionalKHR                     = 5353
    CapabilityCooperativeMatrixNV                          = 5357
    CapabilityFragmentShaderSampleInterlockEXT             = 5363
    CapabilityFragmentShaderShadingRateInterlockEXT        = 5372
    CapabilityShaderSMBuiltinsNV                           = 5373
    CapabilityFragmentShaderPixelInterlockEXT              = 5378
    CapabilityDemoteToHelperInvocationEXT                  = 5379
    CapabilitySubgroupShuffleINTEL                         = 5568
    CapabilitySubgroupBufferBlockIOINTEL                   = 5569
    CapabilitySubgroupImageBlockIOINTEL                    = 5570
    CapabilitySubgroupImageMediaBlockIOINTEL               = 5579
    CapabilityIntegerFunctions2INTEL                       = 5584
    CapabilitySubgroupAvcMotionEstimationINTEL             = 5696
    CapabilitySubgroupAvcMotionEstimationIntraINTEL        = 5697
    CapabilitySubgroupAvcMotionEstimationChromaINTEL       = 5698
end

@cenum RayQueryIntersection::UInt32 begin
    RayQueryIntersectionRayQueryCandidateIntersectionKHR = 0
    RayQueryIntersectionRayQueryCommittedIntersectionKHR = 1
end

@cenum RayQueryCommittedIntersectionType::UInt32 begin
    RayQueryCommittedIntersectionTypeRayQueryCommittedIntersectionNoneKHR      = 0
    RayQueryCommittedIntersectionTypeRayQueryCommittedIntersectionTriangleKHR  = 1
    RayQueryCommittedIntersectionTypeRayQueryCommittedIntersectionGeneratedKHR = 2
end

@cenum RayQueryCandidateIntersectionType::UInt32 begin
    RayQueryCandidateIntersectionTypeRayQueryCandidateIntersectionTriangleKHR = 0
    RayQueryCandidateIntersectionTypeRayQueryCandidateIntersectionAABBKHR     = 1
end

const extra_operands = Dict(
    ImageOperands => Dict(
        ImageOperandsBias => (kind = IdRef,),
        ImageOperandsLod => (kind = IdRef,),
        ImageOperandsGrad => (kind = IdRef,),
        ImageOperandsConstOffset => (kind = IdRef,),
        ImageOperandsOffset => (kind = IdRef,),
        ImageOperandsConstOffsets => (kind = IdRef,),
        ImageOperandsSample => (kind = IdRef,),
        ImageOperandsMinLod => (kind = IdRef,),
        ImageOperandsMakeTexelAvailable => (kind = IdScope,),
        ImageOperandsMakeTexelAvailableKHR => (kind = IdScope,),
        ImageOperandsMakeTexelVisible => (kind = IdScope,),
        ImageOperandsMakeTexelVisibleKHR => (kind = IdScope,),
    ),
    LoopControl => Dict(
        LoopControlDependencyLength => (kind = LiteralInteger,),
        LoopControlMinIterations => (kind = LiteralInteger,),
        LoopControlMaxIterations => (kind = LiteralInteger,),
        LoopControlIterationMultiple => (kind = LiteralInteger,),
        LoopControlPeelCount => (kind = LiteralInteger,),
        LoopControlPartialCount => (kind = LiteralInteger,),
    ),
    MemoryAccess => Dict(
        MemoryAccessAligned => (kind = LiteralInteger,),
        MemoryAccessMakePointerAvailable => (kind = IdScope,),
        MemoryAccessMakePointerAvailableKHR => (kind = IdScope,),
        MemoryAccessMakePointerVisible => (kind = IdScope,),
        MemoryAccessMakePointerVisibleKHR => (kind = IdScope,),
    ),
    ExecutionMode => Dict(
        ExecutionModeInvocations =>
            (kind = LiteralInteger, name = "Number of <<Invocation,invocations>>"),
        ExecutionModeLocalSize => (kind = LiteralInteger, name = "x size"),
        ExecutionModeLocalSizeHint => (kind = LiteralInteger, name = "x size"),
        ExecutionModeOutputVertices => (kind = LiteralInteger, name = "Vertex count"),
        ExecutionModeVecTypeHint => (kind = LiteralInteger, name = "Vector type"),
        ExecutionModeSubgroupSize => (kind = LiteralInteger, name = "Subgroup Size"),
        ExecutionModeSubgroupsPerWorkgroup =>
            (kind = LiteralInteger, name = "Subgroups Per Workgroup"),
        ExecutionModeSubgroupsPerWorkgroupId =>
            (kind = IdRef, name = "Subgroups Per Workgroup"),
        ExecutionModeLocalSizeId => (kind = IdRef, name = "x size"),
        ExecutionModeLocalSizeHintId => (kind = IdRef, name = "Local Size Hint"),
        ExecutionModeDenormPreserve => (kind = LiteralInteger, name = "Target Width"),
        ExecutionModeDenormFlushToZero =>
            (kind = LiteralInteger, name = "Target Width"),
        ExecutionModeSignedZeroInfNanPreserve =>
            (kind = LiteralInteger, name = "Target Width"),
        ExecutionModeRoundingModeRTE => (kind = LiteralInteger, name = "Target Width"),
        ExecutionModeRoundingModeRTZ => (kind = LiteralInteger, name = "Target Width"),
        ExecutionModeOutputPrimitivesNV =>
            (kind = LiteralInteger, name = "Primitive count"),
    ),
    Decoration => Dict(
        DecorationSpecId =>
            (kind = LiteralInteger, name = "Specialization Constant ID"),
        DecorationArrayStride => (kind = LiteralInteger, name = "Array Stride"),
        DecorationMatrixStride => (kind = LiteralInteger, name = "Matrix Stride"),
        DecorationBuiltIn => (kind = BuiltIn,),
        DecorationUniformId => (kind = IdScope, name = "Execution"),
        DecorationStream => (kind = LiteralInteger, name = "Stream Number"),
        DecorationLocation => (kind = LiteralInteger, name = "Location"),
        DecorationComponent => (kind = LiteralInteger, name = "Component"),
        DecorationIndex => (kind = LiteralInteger, name = "Index"),
        DecorationBinding => (kind = LiteralInteger, name = "Binding Point"),
        DecorationDescriptorSet => (kind = LiteralInteger, name = "Descriptor Set"),
        DecorationOffset => (kind = LiteralInteger, name = "Byte Offset"),
        DecorationXfbBuffer => (kind = LiteralInteger, name = "XFB Buffer Number"),
        DecorationXfbStride => (kind = LiteralInteger, name = "XFB Stride"),
        DecorationFuncParamAttr => (
            kind = FunctionParameterAttribute,
            name = "Function Parameter Attribute",
        ),
        DecorationFPRoundingMode =>
            (kind = FPRoundingMode, name = "Floating-Point Rounding Mode"),
        DecorationFPFastMathMode => (kind = FPFastMathMode, name = "Fast-Math Mode"),
        DecorationLinkageAttributes => (kind = LiteralString, name = "Name"),
        DecorationInputAttachmentIndex =>
            (kind = LiteralInteger, name = "Attachment Index"),
        DecorationAlignment => (kind = LiteralInteger, name = "Alignment"),
        DecorationMaxByteOffset => (kind = LiteralInteger, name = "Max Byte Offset"),
        DecorationAlignmentId => (kind = IdRef, name = "Alignment"),
        DecorationMaxByteOffsetId => (kind = IdRef, name = "Max Byte Offset"),
        DecorationSecondaryViewportRelativeNV =>
            (kind = LiteralInteger, name = "Offset"),
        DecorationCounterBuffer => (kind = IdRef, name = "Counter Buffer"),
        DecorationHlslCounterBufferGOOGLE => (kind = IdRef, name = "Counter Buffer"),
        DecorationUserSemantic => (kind = LiteralString, name = "Semantic"),
        DecorationHlslSemanticGOOGLE => (kind = LiteralString, name = "Semantic"),
        DecorationUserTypeGOOGLE => (kind = LiteralString, name = "User Type"),
    ),
)
