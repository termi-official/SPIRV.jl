using SPIRV, Test
using SPIRV.MathFunctions

resource(filename) = joinpath(@__DIR__, "resources", filename)
read_module(file) = read(joinpath(@__DIR__, "modules", file * (last(splitext(file)) == ".jl" ? "" : ".jl")), String)
load_module_expr(file) = Meta.parse(string("quote; ", read_module(file), "; end")).args[1]
load_ir(ex::Expr) = eval(macroexpand(Main, :(@spv_ir $ex)))
load_ir(file) = load_ir(load_module_expr(file))
load_module(ex::Expr) = eval(macroexpand(Main, :(@spv_module $ex)))
load_module(file) = load_module(load_module_expr(file))

@testset "SPIRV.jl" begin
  include("deltagraph.jl");
  include("utilities.jl");
  include("formats.jl")
  include("modules.jl");
  include("spir_types.jl");
  include("metadata.jl");
  include("features.jl");
  include("ir.jl");
  include("spvasm.jl");
  include("layouts.jl");
  include("serialization.jl");
  if VERSION ≥ v"1.8"
    include("passes.jl");
    include("codegen.jl");
    include("analysis.jl");
    include("restructuring.jl");
    include("frontend.jl");
  end;
end;
