VERSION >= v"0.4.0-dev+6521" && __precompile__()

module Knet
using AutoGrad
export grad
export KnetArray, gradcheck, gpu, relu, sigm, invx, logp, conv4, pool, mat
const libknet8 = Libdl.find_library(["libknet8"], [dirname(@__FILE__)])
const datapath = joinpath(dirname(@__FILE__),"..","data")

include("gpu.jl")               # gpu support
include("karray.jl")            # use KnetArrays
include("cuda1.jl")             # unary operators
include("cuda01.jl")            # scalar,array->array
include("cuda10.jl")            # array,scalar->array
include("cuda11.jl")            # array,array->array (elementwise, same shape)
include("cuda12.jl")            # array,array->array (broadcasting)
include("cuda20.jl")            # array->scalar (reductions)
include("cuda21.jl")            # array->vector (reductions)
include("cuda22.jl")            # array,array->array (linear algebra)
include("cuda44.jl")            # convolution and pooling
include("gradcheck.jl")         # gradient check

# See if we have a gpu at initialization:
function __init__()
    try
        r = gpu(true)
        info(r >= 0 ? "Knet using GPU $r" : "No GPU found, Knet using the CPU")
    catch e
        warn("$e: Knet using the CPU.")
        gpu(false)
    end
end

end # module
