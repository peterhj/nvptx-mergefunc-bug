//
// Generated by LLVM NVPTX Back-End
//

.version 3.2
.target sm_35
.address_size 64

	// .globl	foo
                                        // @foo
.visible .entry foo()
{
	.reg .b32 	%r<2>;
	.reg .b64 	%rd<2>;

// BB#0:                                // %start
	mov.u32	%r1, %tid.x;
	mov.u64 	%rd1, 4096;
	st.u32 	[%rd1], %r1;
	ret;
}

	// .globl	bar
.visible .entry bar()                   // @bar
{
	.reg .b32 	%r<2>;
	.reg .b64 	%rd<2>;

// BB#0:                                // %start
	mov.u32	%r1, %tid.x;
	mov.u64 	%rd1, 4096;
	st.u32 	[%rd1], %r1;
	ret;
}

