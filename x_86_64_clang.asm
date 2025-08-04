.LCPI0_0:
        .quad   0x3ff0000000000000
main:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 112
        lea     rdi, [rbp - 33]
        mov     qword ptr [rbp - 104], rdi
        mov     esi, 1
        call    _ZN3Foo1fEi
        mov     rdi, qword ptr [rbp - 104]
        movsd   xmm0, qword ptr [rip + .LCPI0_0]
        call    _ZN3Foo1fEd
        lea     rdx, [rbp - 73]
        mov     qword ptr [rbp - 32], rdx
        mov     rax, qword ptr [rbp - 32]
        mov     qword ptr [rbp - 8], rax
        lea     rsi, [rip + .L.str]
        lea     rdi, [rbp - 72]
        call    _ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_
        jmp     .LBB0_1
.LBB0_1:
        lea     rdi, [rbp - 33]
        lea     rsi, [rbp - 72]
        call    _ZNK3Foo1gERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE
        jmp     .LBB0_2
.LBB0_2:
        lea     rdi, [rbp - 72]
        call    _ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED2Ev
        lea     rax, [rbp - 73]
        mov     qword ptr [rbp - 24], rax
        call    _ZN3Foo1hEv
        xor     eax, eax
        add     rsp, 112
        pop     rbp
        ret
        mov     rcx, rax
        mov     eax, edx
        mov     qword ptr [rbp - 88], rcx
        mov     dword ptr [rbp - 92], eax
        jmp     .LBB0_5
        mov     rcx, rax
        mov     eax, edx
        mov     qword ptr [rbp - 88], rcx
        mov     dword ptr [rbp - 92], eax
        lea     rdi, [rbp - 72]
        call    _ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED2Ev
.LBB0_5:
        lea     rax, [rbp - 73]
        mov     qword ptr [rbp - 16], rax
        mov     rdi, qword ptr [rbp - 88]
        call    _Unwind_Resume@PLT

_ZN3Foo1fEi:
        push    rbp
        mov     rbp, rsp
        mov     qword ptr [rbp - 8], rdi
        mov     dword ptr [rbp - 12], esi
        pop     rbp
        ret

_ZN3Foo1fEd:
        push    rbp
        mov     rbp, rsp
        mov     qword ptr [rbp - 8], rdi
        movsd   qword ptr [rbp - 16], xmm0
        pop     rbp
        ret

_ZNK3Foo1gERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE:
        push    rbp
        mov     rbp, rsp
        mov     qword ptr [rbp - 8], rdi
        mov     qword ptr [rbp - 16], rsi
        mov     eax, 42
        pop     rbp
        ret

_ZN3Foo1hEv:
        push    rbp
        mov     rbp, rsp
        pop     rbp
        ret

__clang_call_terminate:
        push    rbp
        mov     rbp, rsp
        call    __cxa_begin_catch@PLT
        call    _ZSt9terminatev@PLT

.L.str:
        .asciz  "hi"

.L.str.1:
        .asciz  "basic_string: construction from null is not valid"

.L.str.2:
        .asciz  "basic_string::_M_create"

DW.ref.__gxx_personality_v0:
        .quad   __gxx_personality_v0