module SPIRV

using CEnum
using MLStyle
using Graphs
using Reexport
using Dictionaries
using AutoHashEquals
using Accessors

using CodeInfoTools
using Core.Compiler: CodeInfo, IRCode, compute_basic_blocks, uncompressed_ir, method_instances, MethodInstance, InferenceResult, typeinf, InferenceState, retrieve_code_info, lock_mi_inference, AbstractInterpreter

import SPIRV_Tools_jll
const spirv_val = SPIRV_Tools_jll.spirv_val(identity)

const Optional{T} = Union{Nothing,T}

import Base: write, show, showerror, ==

const magic_number = 0x07230203
const generator_magic_number = 0x12349876

# generated SPIR-V wrapper
include("generated/enums.jl")
include("generated/instructions.jl")

include("utils.jl")
include("bijection.jl")
include("ssa.jl")
include("parse.jl")
include("disassemble.jl")
include("spir_types.jl")
include("functions.jl")
include("ir.jl")
include("cfg.jl")
include("assemble.jl")
include("validate.jl")

include("frontend/deltagraph.jl")
include("frontend/interpreter.jl")
include("frontend/cfg.jl")
include("frontend/basicblocks.jl")
include("frontend/reflection.jl")
include("frontend/restructuring.jl")
include("frontend/compile.jl")
include("frontend/intrinsics.jl")

export
        # parse
        PhysicalInstruction, PhysicalModule,
        Instruction,

        # disassemble
        disassemble,

        # assemble
        assemble,

        # SPIR-V types
        SPIRType,
        VoidType,
        ScalarType, BooleanType, IntegerType, FloatType,
        VectorType, MatrixType,
        ImageType,
        SamplerType, SampledImageType,
        ArrayType,
        OpaqueType,
        StructType,
        PointerType,

        # IR
        IR,
        SSAValue,
        Metadata,
        SSADict,
        @inst,

        # CFG
        control_flow_graph,

        # validation
        validate,

        # Front-end
        CFG,
        is_single_entry_single_exit,
        is_tail_structured,
        is_single_node,
        rem_head_recursion!,
        compact_reducible_bbs!,
        compact_structured_branches!,
        merge_mutually_recursive!,
        merge_return_blocks,
        compact,
        sinks,
        sources,

        replace_code!,
        infer!,
        lowered_code,
        inferred_code,

        verify,
        compile

end
