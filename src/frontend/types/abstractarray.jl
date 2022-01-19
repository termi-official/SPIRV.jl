"""
SPIR-V array or vector.

SPIR-V vectors are semantically different than one-dimensional arrays,
in that they can store only scalars, must be statically sized and may have up to 4 components.
The same applies for SPIR-V matrices.

SPIR-V arrays do not require their element type to be scalar.
They are mostly sized, though unsized arrays are allowed in specific cases.
Vulkan, for example, requires unsized arrays to be the last member of a struct
that is used as a storage buffer.
"""
abstract type AbstractSPIRVArray{T,D} <: AbstractArray{T,D} end

const Scalar = Union{Bool,BitInteger,IEEEFloat}

Base.getindex(arr::AbstractSPIRVArray, indices::Signed...) = getindex(arr, (UInt32.(indices) .- UInt32(1))...)
Base.getindex(arr::AbstractSPIRVArray, indices::UInt32...) = CompositeExtract(arr, indices...)
Base.setindex!(arr::AbstractSPIRVArray, value, indices::Signed...) = setindex!(arr, convert(eltype(arr), value), (UInt32.(indices) .- UInt32(1))...)
Base.setindex!(arr::AbstractSPIRVArray{T}, value::T, indices::UInt32...) where {T} = Store(AccessChain(arr, indices...), value)
Base.setindex!(arr1::AbstractSPIRVArray, arr2::AbstractSPIRVArray) = Store(arr1, convert(typeof(arr1), arr2))

@override getindex(v::Vector, i::Signed) = getindex(v, UInt32(i) - UInt32(i - 1))
@override getindex(v::Vector, i::UInt32) = AccessChain(v, i)[]

Base.eltype(::Type{<:AbstractSPIRVArray{T}}) where {T} = T
Base.firstindex(T::Type{<:AbstractSPIRVArray}, d = 1) = 1
Base.lastindex(T::Type{<:AbstractSPIRVArray}, d) = size(T)[d]
Base.lastindex(T::Type{<:AbstractSPIRVArray}) = prod(size(T))

Base.similar(T::Type{<:AbstractSPIRVArray}, element_type, dims) = zero(T)
Base.similar(T::Type{<:AbstractSPIRVArray}) = similar(T, eltype(T), size(T))

for f in (:length, :eltype, :size, :firstindex, :lastindex, :zero, :one, :similar)
  @eval Base.$f(v::AbstractSPIRVArray) = $f(typeof(v))
end

@noinline function Store(v::T, x::T) where {T<:AbstractSPIRVArray}
  obj_ptr = pointer_from_objref(v)
  ptr = Pointer(Base.unsafe_convert(Ptr{T}, obj_ptr), v)
  Store(ptr, x)
end
