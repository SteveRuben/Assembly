
.intel_syntax noprefix
.data
#notre algorithme  equation du second degre
#this is an algorithm for solving equation like ax^2+bx+c=0 in asm
# algorithme resolutionequation(a, b, c)
# debut
#      si (a=0) et (b=0) et (c=0) alors
#      			ecrire("Impossible d'avoir des racines")
#      sinon
#           si (a=0) et (b=0) et (c<>0) alors
#      			ecrire("Impossible d'avoir des racines")
#      		sinon
#           	si (a=0) et (b<>0) et (c=0) alors
#      			   x = 0
#      		    sinon
#           	     si (a=0) et (b<>0) et (c<>0) alors
#      			        x = -(c)/b
#      		         sinon
#           	          si (a<>0) et (b=0) et (c=0) alors
#      			             x = 0
#      		              sinon
#           	               X <-- (b*b)-((4*a)*c)
#                               si X = 0 alors     retourner ((-b)/2*a) et ((-b)/2*a)
#                               sinon
#                                    si X < 0 alors    retourner  pas de solution
#                                    sinon
#                                         si X > 0 alors
#                                            i <-- 1
#                                            bool <-- 1
#                                            tantque bool = 1 faire
#                                                    A <-- i*i
#                                                    si A > X alors
#                                                       i <-- i-1
#                                                       bool <-- 0
#                                                    sinon
#                                                         i <-- i+1
#                                                    finsi
#                                            fintantque
#                                            retourner i
#                                         finsi
#                                    finsi
#                               finsi
#                          finsi
#                     finsi
#                finsi
#           finsi
#      finsi
# finalgorithme
texte1:.asciz "entrer  un coefficient \n"
texte2:.asciz  "infinite de solution \n"
texte3:.asciz  "solution double \n"
texte4:.asciz  "solution unique \n"
texte6:.asciz  "pas de solution \n"
texte5:.asciz " 2 ssolutions \n"
a:.double 0
zero:.double 0
 b:.double 0
 c:.double 0
 d:.double 0
 deux:.int 2
 x:.double 0
 dis:.double 0
 sol:.double 0
 sol1:.double 0
 descrip:.asciz "%lf";
 descript_f:.asciz "%lf";
 design:.asciz "******************************************\n"
 texte:.asciz "Veuillez entrer vos coefficient par ordre a , b et c\n"
 design3:.asciz "\n RESOLUTION D'UNE EQUATION DU SECON DEGRE  ax^2+bx+c \n"

.global main
main:
	push offset design3
      call print_string
      add esp,4
     
      push offset design
      call print_string
      add esp,4
				# lecture des donnees
      push offset texte
      call print_string
      add esp,4
      call print_endl
				#lecture de la variable a
push offset texte
call print_string
add esp,4
push  offset a
call  getfloat
add esp,4
push  offset b
call  getfloat
add esp,4
push  offset c
call  getfloat


push  dword ptr [a]
push  dword ptr [a+4]
call  putfloat
add   esp,8

call print_nl
add esp ,4
push  dword ptr [b]
push  dword ptr [b+4]
call  putfloat
add   esp,8
call print_nl
add esp ,4
push  dword ptr [c]
push  dword ptr [c+4]
call  putfloat
add   esp,8
call print_nl
add esp ,4
      #fild word 1
      fld  qword ptr a
      ftst
      fstsw ax
      sahf
      jb sinon
      ja sinon
      ffree ST(0)
      fld  qword ptr b
      ftst
      fstsw ax
      sahf
      jb sinon1
      ja sinon1
      ffree ST(0)      
      fld  qword ptr c
      ftst
      fstsw ax
      sahf
      jb sinon2
      ja sinon2    
       push offset texte2
       call print_string
       add  esp,4
       jmp finsi # on  arrete
sinon2:
      push offset texte2
      call print_string
      add esp ,4
      jmp finsi
sinon1:
	ffree ST(0)      
         fld  qword ptr c
	fchs
	fdiv qword ptr b
	fstp qword ptr sol
	push offset texte4
	call print_string
	add esp , 4
	call print_endl
	push dword ptr [sol]
	push dword ptr [sol+4]
	call putfloat
	add esp,8
	jmp  finsi
sinon:
	ffree ST(0)
	fld qword ptr a
	fmul qword ptr c
	fimul dword ptr deux
	fimul dword ptr deux
	fstp qword ptr x
	fld qword ptr b
	fmul qword ptr b
	fsub qword ptr x
	fst qword ptr d
	ftst
	fstsw ax
	sahf
	jb   passolution
	ja  doublesolution
	ffree ST(0)
	fld qword ptr a
	fimul dword ptr deux
	fstp  qword ptr dis
	fld qword ptr b
	fdiv  qword ptr dis
	fstp  qword ptr sol
	push offset texte3
	call print_string
	add esp,4
	push dword ptr [sol ]
	push dword ptr [sol+4 ]
	call putfloat
	add esp ,8
	jmp finsi
passolution:
		push offset texte6
	       call print_string
	       add esp,4
		jmp finsi
doublesolution:
	fld qword ptr d
	fsqrt
	fstp qword ptr d
	fld qword ptr a
	fimul dword ptr deux
	fstp qword ptr x
	fld qword ptr b
	fchs
	fsub qword ptr d
	fdiv qword ptr x
	fstp qword ptr sol
	fld qword ptr b
	fchs
	fadd  qword ptr d
	fdiv qword ptr x
	fstp qword ptr sol1
	push  offset texte5
	call print_string
	add esp ,4
	push dword ptr [sol]
	push dword ptr [sol+4]
	call putfloat
	add esp,8
	call print_endl
	push dword ptr [sol1]
	push dword ptr [sol1+4]
	call putfloat
	add esp,8
finsi:
	push 0
	call exit


#les procedures


print_string:
   push ebp
   mov ebp,esp
   pusha
   push [ebp+8]
   call printf
   add esp,4
   popa
   pop ebp
   ret
 
getfloat:
   push ebp
   mov  ebp,esp
   pusha
   push [ebp+8]
   push offset descript_f
   call scanf
   add esp,8
   popa
   pop ebp
   ret

putfloat:
   push ebp
   mov ebp,esp
   pusha
   push [ebp+8]
   push [ebp+12]
   push offset descrip
   call printf
   add esp,12
   popa
   pop ebp
   ret

print_endl:
   push ebp
   mov ebp,esp
   pusha
   push '\n'
   call putchar
   add esp,4
   popa
   pop ebp
   ret  
                           
#permet d'afficher   '\n'
print_nl:
push ebp
mov ebp,esp
pusha
push '\n'
call putchar
add esp,4
popa
pop ebp
ret
