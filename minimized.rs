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
  #[link_name = "llvm.nvvm.barrier0"]
  fn syncthreads() -> ();
}

#[inline]
pub unsafe fn _syncthreads() -> () {
  syncthreads()
}

#[no_mangle]
pub unsafe extern "ptx-kernel" fn foo() {
  _syncthreads();
  _syncthreads();
}

#[no_mangle]
pub unsafe extern "ptx-kernel" fn bar() {
  _syncthreads();
  _syncthreads();
}
