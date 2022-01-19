using SPIRV, Test

@testset "Array operations" begin
  @testset "Vec" begin
    v = Vec(1.0, 3.0, 1.0, 2.0)
    @test v[2] === 3.0
    v[3] = 4
    @test v[4] == last(v) === 2.0
    @test first(v) === 1.0
    @test v.x === v.r === 1.0
    @test v.y === v.g === 3.0
    @test v.z === v.b === 4.0
    @test v.w === v.a === 2.0
    v2 = similar(v)
    @test all(iszero, v2)
    @test eltype(v2) == eltype(v)
    @test size(v2) == size(v)

    v[] = v2
    @test all(iszero, v)
  end

  @testset "Mat" begin
    m = Mat(Vec(1.0, 1.0), Vec(3.0, 2.0))
    @test m[1, 1] === 1.0
    @test m[1, 2] === 3.0
    m2 = @mat [1.0 3.0
               1.0 2.0]
    @test m == m2
    m[1, 2] = 5.0
    @test m[1, 2] === 5.0
    m2 = similar(m)
    @test all(iszero, m2)
    @test eltype(m2) == eltype(m)
    @test size(m2) == size(m)

    m[] = m2
    @test all(iszero, m)
  end

  @testset "Arr" begin
    arr = Arr(1.0, 3.0, 1.0, 2.0)
    @test arr[2] === 3.0
    arr[3] = 4
    @test arr[4] == last(arr) === 2.0
    @test first(arr) === 1.0
    arr2 = similar(arr)
    @test all(iszero, arr2)
    @test eltype(arr2) == eltype(arr)
    @test size(arr2) == size(arr)

    arr[] = arr2
    @test all(iszero, arr)
  end
end
