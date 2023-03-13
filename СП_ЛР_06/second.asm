model large, C
code
EXTRN C c: dword
EXTRN C y: dword
meig dd -8.0
two  dd 2.0
five dd 5.0

PUBLIC C second
second proc far

fld zero			; Load 0 								; ->     0      |	          |				|				|
fld y				; Load y								; ->	 y	    |      0      |				|				|
fcompp    			; Compare y and -1						;		 y? 	|	   0      |				|				|
fstsw ax			; Store status word in ax
sahf				; Workaround - fcomi not available
jl less
jmp greater			; ST(0) > SRC

less:
fld y               ; Load y								; ->    y	   |              |				|				|
fcos				; cos(y)           					    ;     cos(y)   |	          |				|				|
fsin                ; sin(cos(y))    						;  sin(cos(y)) |              |				|				|
jmp finish

greater:
fld oaah			; Load 1.5								; ->    1.5     |	          |				|				|
fld y               ; Load y								; ->     y      |     1.5     |				|				|

fcompp				; Compare y and 1						;		 y?		|	  1.5     |				|				|
fstsw ax			; Store status word in ax
sahf				; Workaround - fcomi not available

jle less2
fld y               ; Load y								; ->    y	   |              |				|				|
fsin				; sin(y)           					    ;     sin(y)   |	          |				|				|
fcos                ; cos(sin(y))    						;  cos(sin(y)) |              |				|				|
jmp finish

less2:
fld y				; Load y								; ->    y	   |              |				|				|
fld one             ; Load 1                                ;       1      |       y      |             |               |
faddp ST(1), ST(0)  ; Add 1 to y                            ;   /////////  |     y + 1    |             |               |
fld five            ; Load 5                                ; ->    5      |     y + 1    |             |               |
fxch ST(1)          ; Exchange 5 and (y + 1)                ;     y + 1    |       5      |             |               |
fyl2x               ; Compute 5 * log2(y + 1)               ;      res     |              |             |               |

finish:
fstp f				; Store result in f
retn				; Return to caller

second endp

end
