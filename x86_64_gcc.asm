_ZN3Foo1fEi:
        push    rbp
        mov     rbp, rsp
        mov     QWORD PTR [rbp-8], rdi
        mov     DWORD PTR [rbp-12], esi
        nop
        pop     rbp
        ret
_ZN3Foo1fEd:
        push    rbp
        mov     rbp, rsp
        mov     QWORD PTR [rbp-8], rdi
        movsd   QWORD PTR [rbp-16], xmm0
        nop
        pop     rbp
        ret
_ZNK3Foo1gERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE:
        push    rbp
        mov     rbp, rsp
        mov     QWORD PTR [rbp-8], rdi
        mov     QWORD PTR [rbp-16], rsi
        mov     eax, 42
        pop     rbp
        ret
_ZN3Foo1hEv:
        push    rbp
        mov     rbp, rsp
        nop
        pop     rbp
        ret
.LC1:
        .string "hi"
main:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 64
        lea     rax, [rbp-49]
        mov     esi, 1
        mov     rdi, rax
        call    _ZN3Foo1fEi
        mov     rdx, QWORD PTR .LC0[rip]
        lea     rax, [rbp-49]
        movq    xmm0, rdx
        mov     rdi, rax
        call    _ZN3Foo1fEd
        lea     rax, [rbp-9]
        mov     QWORD PTR [rbp-8], rax
        nop
        nop
        lea     rdx, [rbp-9]
        lea     rax, [rbp-48]
        mov     esi, OFFSET FLAT:.LC1
        mov     rdi, rax
        call    _ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1IS3_EEPKcRKS3_
        lea     rdx, [rbp-48]
        lea     rax, [rbp-49]
        mov     rsi, rdx
        mov     rdi, rax
        call    _ZNK3Foo1gERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE
        lea     rax, [rbp-48]
        mov     rdi, rax
        call    _ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev
        nop
        call    _ZN3Foo1hEv
        mov     eax, 0
        leave
        ret
.LC2:
        .string "basic_string: construction from null is not valid"
.LC3:
        .string "basic_string::_M_create"
.LC0:
        .long   0
        .long   1072693248