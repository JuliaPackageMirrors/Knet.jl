# module KUnet
using Compat

# Print date, expression and elapsed time after execution
VERSION < v"0.4-" && eval(Expr(:using,:Dates))
macro date(_x) :(println("$(now()) "*$(string(_x)));flush(STDOUT);@time $(esc(_x))) end
export @date

include("util/gpu.jl");		export setseed
@useifgpu CUDArt
@useifgpu CUBLAS
@useifgpu CUSPARSE
@useifgpu CUDNN  
@gpu include("util/cudart.jl");
@gpu include("util/curand.jl");
@gpu include("util/cusparse.jl");
include("util/linalg.jl");	

isdefined(:KUdense) || include("util/dense.jl");	# deprecate?
include("util/colops.jl");	# 
include("data.jl");		export ItemTensor

include("model.jl");		export train, test, accuracy, setopt!
include("op.jl");		
include("op/add.jl");		export add
include("op/dot.jl");		export dot
include("op/mul.jl");		export mul
include("op/input.jl");		export input
include("op/par.jl");           export par
include("op/loss.jl");		export quadloss, softloss
include("op/actf.jl");		export sigm, tanh, relu, soft, logp
include("update.jl");		

include("net.jl");              export Net
include("net/initforw.jl")
include("net/initback.jl")
include("net/forw.jl")
include("net/back.jl")
include("net/util.jl")

# end # module

# include("op/mmul.jl");     	# export Mmul
# include("op/bias.jl");		# export Bias
# include("op/conv.jl");		# export Conv
# include("op/pool.jl");		# export Pool
# include("op/drop.jl");		# export Drop
# include("op/add2.jl");		# export Add2
# include("op/mul2.jl");		# export Mul2
# include("op/actf.jl");		# export Actf, Logp, Relu, Sigm, Soft, Tanh
# include("op/loss.jl");		# export Loss, QuadLoss, SoftLoss, LogpLoss, XentLoss, PercLoss, ScalLoss

# include("netcomp.jl");		# export Net
# include("compiler.jl")
# include("net.jl");		# export Net
# include("mlp.jl");		# export MLP, predict # , accuracy, loadnet, savenet

# include("model/irnn.jl");	# export IRNN
# include("model/lstm.jl");	# export LSTM
# include("model/s2c.jl");	# export S2C
# include("model/kperceptron.jl"); # export KPerceptron

# include("data/adding.jl");	# export Adding
# include("data/mnist.jl");	# export MNIST
# include("data/pixels.jl");	# export Pixels

# include("util/deepcopy.jl");	# export cpucopy, gpucopy
# include("util/array.jl");	# export BaseArray

# # include("param.jl");		# export KUparam, setopt! # deprecated
