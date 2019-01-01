Executive summary: NVPTX + MergeFunctions = badness

The test case `nocore.rs` is not minimal but is still small and demonstrates the
actual usage case that helped me to find this issue (namely, writing tests for
NVPTX intrinsics from stdsimd).

I got `nocore-mergefunc-nousealiases-bad.ptx` and `nocore-nomergefunc-ok.ptx` by
directly running `rustc` from a custom sysroot/toolchain that supports extra
target options to control the MergeFunctions pass:

    RUST_TARGET_PATH=`pwd` rustc --target nvptx64-nvidia-cuda.json -C opt-level=3 nocore.rs --emit asm

First, if you use a vanilla target json, currently `rustc` is known to
complain:

    LLVM ERROR: Module has aliases, which NVPTX does not support.

On the other hand, either disabling MergeFunctions outright, or keeping
MergeFunctions but disabling the `-mergefunc-use-aliases` LLVM option, will
successfully generate a PTX file. However the correctness of the PTX is not
guaranteed!

Running `ptxas -arch sm_35 -o nocore-bad.o nocore-mergefunc-nousealiases-bad.ptx` yields the
following error:

    ptxas ./nocore-mergefunc-nousealiases-bad.ptx, line 38; error   : Illegal call target, device function expected
    ptxas fatal   : Ptx assembly aborted due to errors

Running `ptxas -arch sm_35 -o nocore-ok.o nocore-nomergefunc-ok.ptx` succeeds without error.