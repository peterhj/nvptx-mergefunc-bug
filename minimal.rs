#![crate_type = "lib"]

#![feature(abi_ptx)]
#![feature(lang_items)]
#![feature(link_llvm_intrinsics)]
#![feature(naked_functions)]
#![feature(no_core)]

#![no_core]

#[lang = "sized"]
trait Sized {}

#[lang = "copy"]
trait Copy {}

#[allow(improper_ctypes)]
extern "C" {
  #[link_name = "llvm.nvvm.read.ptx.sreg.tid.x"]
  fn thread_idx_x() -> i32;
}

#[inline]
pub unsafe fn _thread_idx_x() -> i32 {
  thread_idx_x()
}

#[no_mangle]
pub unsafe extern "ptx-kernel" fn foo() {
  let p: *mut i32 = 4096 as *mut i32;
  *p = _thread_idx_x();
}

#[no_mangle]
pub unsafe extern "ptx-kernel" fn bar() {
  let p: *mut i32 = 4096 as *mut i32;
  *p = _thread_idx_x();
}
