INCLUDE Irvine32.inc

.data
	salto_de_carro sdword " ", 0ah
					sdword " ", 0
	abierto sdword "(", 0
	cerrado sdword ")", 0
	no_bal byte "Parentesis NO balanceados", 0
	bal byte "Parentesis SI balanceados", 0
	abiertos sdword 0
	cerrados sdword 0
	;parentesis byte "(()()()()) (((()))) (()((())()))", 0
	;parentesis byte "((((((())())) (()()(()", 0
	;parentesis byte ")(", 0
	parentesis byte "(() ()(", 0
	tamCadParentesis = ($-parentesis) - 1


.code
main PROC
	mov esi, 0
	mov eax, 0
	mov ebx, 0
	analiza:
	movzx eax, parentesis[esi]
	
	cmp eax, abierto
	
	jz acumula_abiertos
	cmp eax, cerrado
	jz acumula_cerrados
	jmp compara

	acumula_cerrados:
	inc cerrados
	jmp compara

	acumula_abiertos:
	inc abiertos
	jmp compara

	compara:
	mov eax, abiertos
	mov ebx, cerrados

	cmp eax, ebx
	jc no_balanceados
	inc esi
	cmp esi, tamCadParentesis
	jc analiza
	mov eax, abiertos
	mov ebx, cerrados
	cmp eax, ebx
	jnz no_balanceados
	mov edx, offset bal
	call writestring
	mov edx, offset salto_de_carro
	call writestring
	mov edx, offset salto_de_carro
	call writestring
	ret

	no_balanceados:
	mov edx, offset no_bal
	call writestring
	mov edx, offset salto_de_carro
	call writestring
	mov edx, offset salto_de_carro
	call writestring
	ret

main ENDP
END main