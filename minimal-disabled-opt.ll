; ModuleID = 'minimal-disabled.ll'
source_filename = "minimal.3a1fbbbh-cgu.0"
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v32:32:32-v64:64:64-v128:128:128-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

; Function Attrs: nounwind writeonly
define ptx_kernel void @bar() unnamed_addr #0 {
start:
  %0 = tail call signext i32 @llvm.nvvm.read.ptx.sreg.tid.x() #2, !range !0
  store i32 %0, i32* inttoptr (i64 4096 to i32*), align 4096
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() unnamed_addr #1

; Function Attrs: nounwind writeonly
define ptx_kernel void @foo() unnamed_addr #0 {
  tail call ptx_kernel void @bar() #0
  ret void
}

attributes #0 = { nounwind writeonly "target-cpu"="sm_35" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind }

!0 = !{i32 0, i32 1024}
