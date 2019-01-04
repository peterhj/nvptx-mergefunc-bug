source_filename = "minimized"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v32:32:32-v64:64:64-v128:128:128-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

; Function Attrs: nounwind
define ptx_kernel void @foo() unnamed_addr #0 {
start:
  tail call void @llvm.nvvm.barrier0() #2
  tail call void @llvm.nvvm.barrier0() #2
  ret void
}

; Function Attrs: nounwind
define ptx_kernel void @bar() unnamed_addr #0 {
start:
  tail call void @llvm.nvvm.barrier0() #2
  tail call void @llvm.nvvm.barrier0() #2
  ret void
}

; Function Attrs: convergent nounwind
declare void @llvm.nvvm.barrier0() unnamed_addr #1

attributes #0 = { nounwind "target-cpu"="sm_35" }
attributes #1 = { convergent nounwind }
attributes #2 = { nounwind }
