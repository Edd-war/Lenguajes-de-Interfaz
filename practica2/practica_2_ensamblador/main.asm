TITLE Valor_Factorial

include Irvine32.inc

.data

	; DECLARACIONES DE VARIABLES DE OPCIÓN 1
	opc2mensaje1 BYTE "Elegiste la opcion 2: ", 0
	opc2mensaje2 BYTE "Ingresa el index para calcular hasta su valor en la serie FIBONACCI a continuacion: ", 0
	opc2mensaje3 BYTE "Serie FIBONACCI hasta INDEX: ", 0
	uno sdword 1
	cero sdword 0
	serie sdword ?
	index sdword 0

	; DECLARACIONES GLOBALES
	salto_de_carro byte " ", 0ah
					byte " ", 0

	
.code
main proc
	mov esi, 0
	mov eax, cero
	mov serie[esi], eax
	inc esi
	mov eax, uno
	mov serie[esi], eax
	
	mov edx, offset opc2mensaje1
	call writestring
	mov edx, offset salto_de_carro
	call writestring

	mov edx, offset opc2mensaje2
	call writestring
	call readint
	mov index, eax
	mov esi, 0
	cmp esi, index	
	jz salida_opc2

	inicia_serie:
	mov eax, serie[esi]
	inc esi
	add eax, serie[esi]
	jc inicia_serie

	mov eax, 
	dec esi
	jmp inicia_serie
	
	salida_opc2:
	mov esi, 0
	mov edx, offset opc2mensaje3
	call writestring

	inicia_impresion:
	mov eax, serie[esi]
	call writeint
	inc esi
	cmp esi, ecx
	jc inicia_impresion


	mov edx, offset salto_de_carro
	call writestring
	mov edx, offset salto_de_carro
	call writestring
	call readkey
	ret

main endp
end main