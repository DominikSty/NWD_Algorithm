;Author: DominikSty
;Program returns the largest natural number dividing a and b, iterative algorithm, modulo
[bits 32]
  call load_variable_a_text              ;transition to format "load_variable_a_text"
load_variable_a_display_text db "a = ",0 ;function giving the value of a text variable to be printed
load_variable_a_text:
  call [ebx+12]                          ;printf("NWD(a,b); a = ")
  push esp                               ;placing the esp value at the top of the stack
  call load_variable_a                   ;transition to format "load_variable_a"
load_variable_a_download db "%d",0       ;creation of a text variable containing a character retrieval
load_variable_a:
  call [ebx+16]                          ;scanf("%d")
  add esp,8                              ;sums esp and 8; stores the result in esp

  call load_variable_b_text              ;transition to format "load_variable_b_text"
load_variable_b_display_text db "b = ",0 ;function giving the value of a text variable to be printed
load_variable_b_text:
  call [ebx+12]                          ;printf("NWD(a,b); b = ")
  push esp                               ;placing the esp value at the top of the stack
  call load_variable_b                   ;transition to format "load_variable_b"
load_variable_b_download db "%d",0       ;creation of a text variable containing a character retrieval
load_variable_b:
  call [ebx+16]                          ;scanf("%d")
  add esp,8                              ;sums esp and 8; stores the result in esp
  pop ecx                                ;download the value from the top of the stack and copy it
  pop eax                                ;download the value from the top of the stack and copy it
conditional_loop_start:
  mov esi,ecx                            ;transfer of ecx value to esi
  cdq                                    ;converting numbers
  idiv ecx                               ;division of register values
  mov ecx,edx                            ;transfer of edx to ecx
  mov eax,esi                            ;transfer of esi to eax
  test ecx,ecx                           ;operation of conjunction of given values
  jz conditional_stop_loop;              ;jump to specified format when 0 at tag ZF=1
  jnz conditional_loop_start             ;jump to specified format when !0 at tag ZF=0

conditional_stop_loop:                   ;format containing the final result on the stack
  push eax                               ;placing the eax value at the top of the stack

  test eax,eax                           ;operation of conjunction of given values
  jns positive                           ;jump when the value in eax>=0 that is SF==0
  neg eax                                ;eax=-eax

positive:
  push eax                               ;eax register stores nwd value
  call output_result                     ;transition to format "output_result" and calling it

result_function db "NWD(a,b) = %d",0xA,0 ;function giving the value of a text variable to be printed
output_result:                           ;format containing the output in the console and closing the program
  call [ebx+12]                          ;printf("NWD=%d")
  push 0                                 ;esp -> [0][ret]
  call [ebx+0]                           ;exit(0)
