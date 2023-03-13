.model flat, C
.data
EXTRN C a: dword
EXTRN C x: dword
EXTRN C y: dword
one dd 1.0
two dd 2.0
three dd 3.0
four dd 3.0
five dd 5.0
six dd 6.0
seven dd 7.0
twelve dd 12.0
sixteen dd 16.0
.code
PUBLIC C first
first proc FAR

finit				; Initialize FPU stack					;	   ST(0)    |    ST(1)    |    ST(2)	|	   ST(3)	 |
fld three           ; Load 3                                ;        3      |             |             |                |
fld four            ; Load 4                                ;        4      |      3      |             |                |
fmul ST(0), ST(1)	; st(0) = 3 * 4                         ;        12     |      3      |             |                |
fld five			; Load 5                                ;        5      |      12     |      3      |                |
fld six				; Load 6                                ;        6      |      5      |      12     |        3       |
fmul ST(0), ST(1)	; st(0) = 5 * 6                         ;        30     |      5      |      12     |        3       |
faddp ST(2), ST(0)	; st(0) = 30 + 12                       ;               |      5      |      42     |        3       |
fxch ST(2)			;                                       ;        42     |      5      |             |        3       |
ffree ST(3)			;                                       ;        42     |      5      |             |                |
ffree ST(1)			;                                       ;        42     |             |             |                |
fld x				; Load x                                ;        x      |      42     |             |                |
fld one				; Load 1                                ;        1      |      x      |     42      |                |
fldl2e				; Load log2(e)                          ;    log2(e)    |      1      |      x      |       42       |
fmulp ST(2), ST(0)	; st(0)  = log * x                      ;  log2(e) * x  |      1      |      x      |       42       |
F2XM1				; Compute 2^ST(0) - 1                   ;  log2(e) * x  |      1      |      x      |       42       |
fst ST(2)			;                                       ;  log2(e) * x  |      1      | 2^ST(0) - 1 |       42       |
faddp ST(2), ST(1)	;                                       ;  log2(e) * x  |             | 2^ST(0)-1+1 |       42       |
fld a				;                                       ;  log2(e) * x  |      a      | 2^ST(0)-1+1 |       42       |
fmulp ST(2), ST(1)	;                                       ;  log2(e) * x  |             |a*2^ST(0)-1+1|       42       |
fsubp ST(3), ST(2)	;                                       ;  log2(e) * x  |             |             |42-a*2^ST(0)-1+1|
fxch ST(3)			;                                       ;   числитель   |             |             |   log2(e) * x  |
ffree ST(3)			;                                       ;   числитель   |             |             |                |
fld seven			;                                       ;        7      |  числитель  |             |                |
fld two				;                                       ;        2      |      7      |  числитель  |                |
fdivp ST(1), ST(0)	;                                       ;               |     3,5     |  числитель  |                |
fld four			;                                       ;       4       |     3,5     |  числитель  |                |
fld three			;                                       ;       3       |      4      |     3,5     |   числитель    |
fdiv ST(1), ST(0)	;                                       ;       3       |     4/3     |     3,5     |   числитель    |
faddp ST(2), ST(1)	;                                       ;       3       |             |  3,5 + 4/3  |   числитель    |
fld twelve			;                                       ;       3       |      12     |  3,5 + 4/3  |   числитель    |
fdivp ST(1), ST(0)	;                                       ;               |      4      |  3,5 + 4/3  |   числитель    |
fmulp ST(2), ST(1)	;                                       ;               |             |(3,5 + 4/3)/4|   числитель    |
fdivp ST(3), ST(2)	;                                       ;               |             |             |      дробь     |
fxch ST(3)			;                                       ;     дробь     |             |             |                |
fld sixteen			;                                       ;      16       |    дробь    |             |                |
fld two				;                                       ;       2       |      16     |    дробь    |                |
fdivp ST(1), ST(0)	;                                       ;               |      8      |    дробь    |                |
fld three			;                                       ;       3       |      8      |    дробь    |                |
fmulp ST(1), ST(0)	;                                       ;               |      24     |    дробь    |                |
fld six				;                                       ;       6       |      24     |    дробь    |                |
fmulp ST(1), ST(0)	;                                       ;               |     144     |    дробь    |                |
fmulp ST(2), ST(1)	;                                       ;               |             |  дробь*144  |                |
fld a				;                                       ;       a       |             |  дробь*144  |                |
fld x				;                                       ;       x       |       a     |  дробь*144  |                |
fdivp ST(1), ST(0)	;                                       ;               |     a/x     |  дробь*144  |                |
fxch ST(1)			;                                       ;      a/x      |             |  дробь*144  |                |
fcos				; cos(a/x)                              ;      a/x      |             |  дробь*144  |                |
fst ST(0)			;                                       ;    cos(a/x)   |             |  дробь*144  |                |
fmul ST(0), ST(2)	;                                       ;    результат  |             |  дробь*144  |                |
ffree ST(2)			;                                       ;    результат  |             |             |                |
fstp y				; Store result in y
retn				; Return to caller

first endp
end