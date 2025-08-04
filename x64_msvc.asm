$SG30714 DB     'hi', 00H
__real@3ff0000000000000 DQ 03ff0000000000000r   ; 1
??_R4bad_alloc@std@@6B@ DD 01H                      ; std::bad_alloc::`RTTI Complete Object Locator'
        DD      00H
        DD      00H
        DD      imagerel ??_R0?AVbad_alloc@std@@@8
        DD      imagerel ??_R3bad_alloc@std@@8
        DD      imagerel ??_R4bad_alloc@std@@6B@
??_R2bad_alloc@std@@8 DD imagerel ??_R1A@?0A@EA@bad_alloc@std@@8 ; std::bad_alloc::`RTTI Base Class Array'
        DD      imagerel ??_R1A@?0A@EA@exception@std@@8
        ORG $+3
??_R3bad_alloc@std@@8 DD 00H                            ; std::bad_alloc::`RTTI Class Hierarchy Descriptor'
        DD      00H
        DD      02H
        DD      imagerel ??_R2bad_alloc@std@@8
??_R1A@?0A@EA@bad_alloc@std@@8 DD imagerel ??_R0?AVbad_alloc@std@@@8 ; std::bad_alloc::`RTTI Base Class Descriptor at (0,-1,0,64)'
        DD      01H
        DD      00H
        DD      0ffffffffH
        DD      00H
        DD      040H
        DD      imagerel ??_R3bad_alloc@std@@8
??_R1A@?0A@EA@bad_array_new_length@std@@8 DD imagerel ??_R0?AVbad_array_new_length@std@@@8 ; std::bad_array_new_length::`RTTI Base Class Descriptor at (0,-1,0,64)'
        DD      02H
        DD      00H
        DD      0ffffffffH
        DD      00H
        DD      040H
        DD      imagerel ??_R3bad_array_new_length@std@@8
??_R2bad_array_new_length@std@@8 DD imagerel ??_R1A@?0A@EA@bad_array_new_length@std@@8 ; std::bad_array_new_length::`RTTI Base Class Array'
        DD      imagerel ??_R1A@?0A@EA@bad_alloc@std@@8
        DD      imagerel ??_R1A@?0A@EA@exception@std@@8
        ORG $+3
??_R3bad_array_new_length@std@@8 DD 00H       ; std::bad_array_new_length::`RTTI Class Hierarchy Descriptor'
        DD      00H
        DD      03H
        DD      imagerel ??_R2bad_array_new_length@std@@8
??_R4bad_array_new_length@std@@6B@ DD 01H             ; std::bad_array_new_length::`RTTI Complete Object Locator'
        DD      00H
        DD      00H
        DD      imagerel ??_R0?AVbad_array_new_length@std@@@8
        DD      imagerel ??_R3bad_array_new_length@std@@8
        DD      imagerel ??_R4bad_array_new_length@std@@6B@
??_R1A@?0A@EA@exception@std@@8 DD imagerel ??_R0?AVexception@std@@@8 ; std::exception::`RTTI Base Class Descriptor at (0,-1,0,64)'
        DD      00H
        DD      00H
        DD      0ffffffffH
        DD      00H
        DD      040H
        DD      imagerel ??_R3exception@std@@8
??_R2exception@std@@8 DD imagerel ??_R1A@?0A@EA@exception@std@@8 ; std::exception::`RTTI Base Class Array'
        ORG $+3
??_R3exception@std@@8 DD 00H                            ; std::exception::`RTTI Class Hierarchy Descriptor'
        DD      00H
        DD      01H
        DD      imagerel ??_R2exception@std@@8
??_R4exception@std@@6B@ DD 01H                      ; std::exception::`RTTI Complete Object Locator'
        DD      00H
        DD      00H
        DD      imagerel ??_R0?AVexception@std@@@8
        DD      imagerel ??_R3exception@std@@8
        DD      imagerel ??_R4exception@std@@6B@
??_C@_0BA@JFNIOLAK@string?5too?5long@ DB 'string too long', 00H ; `string'
?_Fake_alloc@std@@3U_Fake_allocator@1@B ORG $+1         ; std::_Fake_alloc
_CT??_R0?AVbad_alloc@std@@@8??0bad_alloc@std@@QEAA@AEBV01@@Z24 DD 010H
        DD      imagerel ??_R0?AVbad_alloc@std@@@8
        DD      00H
        DD      0ffffffffH
        ORG $+4
        DD      018H
        DD      imagerel ??0bad_alloc@std@@QEAA@AEBV01@@Z
_CT??_R0?AVbad_array_new_length@std@@@8??0bad_array_new_length@std@@QEAA@AEBV01@@Z24 DD 00H
        DD      imagerel ??_R0?AVbad_array_new_length@std@@@8
        DD      00H
        DD      0ffffffffH
        ORG $+4
        DD      018H
        DD      imagerel ??0bad_array_new_length@std@@QEAA@AEBV01@@Z
_CTA3?AVbad_array_new_length@std@@ DD 03H
        DD      imagerel _CT??_R0?AVbad_array_new_length@std@@@8??0bad_array_new_length@std@@QEAA@AEBV01@@Z24
        DD      imagerel _CT??_R0?AVbad_alloc@std@@@8??0bad_alloc@std@@QEAA@AEBV01@@Z24
        DD      imagerel _CT??_R0?AVexception@std@@@8??0exception@std@@QEAA@AEBV01@@Z24
_TI3?AVbad_array_new_length@std@@ DD 00H
        DD      imagerel ??1bad_array_new_length@std@@UEAA@XZ
        DD      00H
        DD      imagerel _CTA3?AVbad_array_new_length@std@@
??_C@_0BF@KINCDENJ@bad?5array?5new?5length@ DB 'bad array new length', 00H ; `string'
??_7bad_array_new_length@std@@6B@ DQ FLAT:??_R4bad_array_new_length@std@@6B@ ; std::bad_array_new_length::`vftable'
        DQ      FLAT:??_Ebad_array_new_length@std@@UEAAPEAXI@Z
        DQ      FLAT:?what@exception@std@@UEBAPEBDXZ
??_7bad_alloc@std@@6B@ DQ FLAT:??_R4bad_alloc@std@@6B@  ; std::bad_alloc::`vftable'
        DQ      FLAT:??_Ebad_alloc@std@@UEAAPEAXI@Z
        DQ      FLAT:?what@exception@std@@UEBAPEBDXZ
??_C@_0BC@EOODALEL@Unknown?5exception@ DB 'Unknown exception', 00H ; `string'
??_7exception@std@@6B@ DQ FLAT:??_R4exception@std@@6B@  ; std::exception::`vftable'
        DQ      FLAT:??_Eexception@std@@UEAAPEAXI@Z
        DQ      FLAT:?what@exception@std@@UEBAPEBDXZ
$ip2state$??$_Deallocate@$0BA@@std@@YAXPEAX_K@Z DB 02H
        DB      00H
        DB      00H
$cppxdata$??$_Deallocate@$0BA@@std@@YAXPEAX_K@Z DB 060H
        DD      imagerel $ip2state$??$_Deallocate@$0BA@@std@@YAXPEAX_K@Z
voltbl  SEGMENT
        DDSymXIndex:    FLAT:main
voltbl  ENDS
$ip2state$??0?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@QEAA@QEBD@Z DB 06H
        DB      00H
        DB      00H
        DB      'P'
        DB      02H
        DB      'J'
        DB      00H
$stateUnwindMap$??0?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@QEAA@QEBD@Z DB 02H
        DB      0eH
        DD      imagerel ?dtor$0@?0???0?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@QEAA@QEBD@Z@4HA
$cppxdata$??0?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@QEAA@QEBD@Z DB 028H
        DD      imagerel $stateUnwindMap$??0?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@QEAA@QEBD@Z
        DD      imagerel $ip2state$??0?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@QEAA@QEBD@Z

this$ = 8
__formal$ = 16
?f@Foo@@QEAAXH@Z PROC                             ; Foo::f, COMDAT
        mov     DWORD PTR [rsp+16], edx
        mov     QWORD PTR [rsp+8], rcx
        ret     0
?f@Foo@@QEAAXH@Z ENDP                             ; Foo::f

this$ = 8
__formal$ = 16
?f@Foo@@QEAAXN@Z PROC                             ; Foo::f, COMDAT
        movsd   QWORD PTR [rsp+16], xmm1
        mov     QWORD PTR [rsp+8], rcx
        ret     0
?f@Foo@@QEAAXN@Z ENDP                             ; Foo::f

this$ = 8
__formal$ = 16
?g@Foo@@QEBAHAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@@Z PROC ; Foo::g, COMDAT
        mov     QWORD PTR [rsp+16], rdx
        mov     QWORD PTR [rsp+8], rcx
        mov     eax, 42                             ; 0000002aH
        ret     0
?g@Foo@@QEBAHAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@@Z ENDP ; Foo::g

?h@Foo@@SAXXZ PROC                                  ; Foo::h, COMDAT
        ret     0
?h@Foo@@SAXXZ ENDP                                  ; Foo::h

x$ = 32
$T1 = 40
__$ArrayPad$ = 72
main    PROC
$LN4:
        sub     rsp, 88                             ; 00000058H
        mov     rax, QWORD PTR __security_cookie
        xor     rax, rsp
        mov     QWORD PTR __$ArrayPad$[rsp], rax
        mov     edx, 1
        lea     rcx, QWORD PTR x$[rsp]
        call    ?f@Foo@@QEAAXH@Z                        ; Foo::f
        movsd   xmm1, QWORD PTR __real@3ff0000000000000
        lea     rcx, QWORD PTR x$[rsp]
        call    ?f@Foo@@QEAAXN@Z                        ; Foo::f
        npad    1
        lea     rdx, OFFSET FLAT:$SG30714
        lea     rcx, QWORD PTR $T1[rsp]
        call    ??0?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@QEAA@QEBD@Z ; std::basic_string<char,std::char_traits<char>,std::allocator<char> >::basic_string<char,std::char_traits<char>,std::allocator<char> >
        npad    1
        lea     rdx, QWORD PTR $T1[rsp]
        lea     rcx, QWORD PTR x$[rsp]
        call    ?g@Foo@@QEBAHAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@@Z ; Foo::g
        npad    1
        lea     rcx, QWORD PTR $T1[rsp]
        call    ??1?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@QEAA@XZ ; std::basic_string<char,std::char_traits<char>,std::allocator<char> >::~basic_string<char,std::char_traits<char>,std::allocator<char> >
        npad    1
        call    ?h@Foo@@SAXXZ                     ; Foo::h
        npad    1
        xor     eax, eax
        mov     rcx, QWORD PTR __$ArrayPad$[rsp]
        xor     rcx, rsp
        call    __security_check_cookie
        add     rsp, 88                             ; 00000058H
        ret     0
main    ENDP