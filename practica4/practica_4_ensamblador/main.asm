TITLE Busqueda_Binaria

include Irvine32.inc

MOPCION1 MACRO
	mov suma, 0
	mov multi, 1
	mov edx, offset mjsOpcion1
	call writestring

	mov esi, 0
		beginwhile:

			cmp esi, tamArreglo
			jnc endwhile
			mov eax, arreglo[esi*4]
			mov tempo, eax
			inc esi

			cdq
			idiv ref
			cmp edx, 0
			jz pares	;impares
				mov eax, suma
				add eax, tempo
				mov suma, eax
				;call WriteInt
				jmp beginwhile
				pares:	;pares
				mov eax, multi
				imul tempo
				mov multi, eax
				;call WriteInt
			jmp beginwhile

		endwhile:
	mov edx, OFFSET resulSuma
	call WriteString 
	mov eax, suma
	call WriteInt	
	mov edx, offset salto_de_carro
	call writestring

	mov edx, OFFSET resulMulti
	call WriteString
	mov eax, multi
	call WriteInt	
	mov edx, offset salto_de_carro
	call writestring
	mov edx, offset salto_de_carro
	call writestring
	mov edx, offset mensaje4
	call writestring
	mov edx, offset salto_de_carro
	call writestring
	call readkey
ENDM

MOPCION2 MACRO
	mov esi, 0

	mov edx, offset mjsOpcion2
	call writestring
	
	mov edx, offset mensaje2
	call writestring
	call ReadInt
	mov busqueda, eax

	CICLO_ARREGLO:
	mov eax, arreglo[esi*4]
	mov ebx, busqueda
	cmp eax, ebx
	jz BINGO
		cmp esi, tamArreglo
		inc esi
		jc CICLO_ARREGLO
		mov edx, offset resultNoEncontrado
		call writestring
		mov edx, offset salto_de_carro
		call writestring
		mov edx, offset mensaje4
		call writestring
		mov edx, offset salto_de_carro
		call writestring
		call readkey
		jmp salida
	BINGO:
	mov edx, offset resultEncontrado
	call writestring
	mov edx, offset salto_de_carro
	call writestring
	mov edx, offset mensaje4
	call writestring
	mov edx, offset salto_de_carro
	call writestring
	call readkey
	salida:
ENDM

MOPCION3 MACRO
	mov edx, offset mjsOpcion3
	call writestring
	mov esi, 0
	mov index_arreglo, esi
	jmp TAMARRE
	TAMARRE:
	mov esi, index_arreglo
	cmp esi, tamArreglo
	mov esi, 0
	jc REGISTROS
	jmp IMPRIME_ESTADO


	REGISTROS:
		mov eax, arreglo[esi*4]
		mov val_act, eax
		inc esi
		mov eax, arreglo[esi*4]
		mov val_sig, eax

		mov ebx, val_act
		cmp eax, ebx
		jc mayor_actual
		inc esi
		cmp esi, tamArreglo
		dec esi
		jc REGISTROS
		mov esi, index_arreglo
		inc esi
		mov index_arreglo, esi
		jmp IMPRIME_ESTADO

		mayor_actual:
			mov arreglo[esi*4], ebx
			dec esi
			mov arreglo[esi*4], eax
			inc esi
			inc esi
			cmp esi, tamArreglo
			dec esi
			jc REGISTROS 
			mov esi, index_arreglo
			inc esi
			mov index_arreglo, esi
			jmp IMPRIME_ESTADO

	IMPRIME_ESTADO:
	mov edx, OFFSET resulArreglo
	call WriteString 
	mov esi, 0
	mov index_registros, esi
	jmp revisa_otro_valor
	revisa_otro_valor:
	mov esi, index_registros
	cmp esi, tamArreglo
	jc imprime_otro_valor
	mov edx, offset salto_de_carro
	call writestring
	mov esi, index_arreglo 
	cmp esi, tamArreglo
	jc TAMARRE
	jmp adios
	imprime_otro_valor:
	mov eax, arreglo[esi*4]
	call WriteInt
	mov esi, index_registros
	inc esi
	mov index_registros, esi
	jmp revisa_otro_valor
	adios:
	mov edx, offset salto_de_carro
	call writestring
	mov edx, offset salto_de_carro
	call writestring
	mov edx, offset mensaje4
	call writestring
	mov edx, offset salto_de_carro
	call writestring
	call readkey
ENDM

.data

	; DECLARACIONES DE VARIABLES DE OPCIÓN 1
	resulMulti BYTE "La multiplicacion es: ", 0
	resulSuma BYTE "La suma es: ", 0
	tempo SDWORD ?
	ref SDWORD 2
	suma SDWORD 0
	multi SDWORD 1

	; DECLARACIONES DE VARIABLES DE OPCIÓN 2
	mensaje2 BYTE "Ingrese el valor de la busqueda a continuacion: ", 0
	resultEncontrado BYTE "Encontrado", 0AH
						BYTE " ", 0
	resultNoEncontrado BYTE "No Encontrado", 0AH
						BYTE " ", 0
	busqueda SDWORD ?

	;DECLARACIONES DE VARIABLES DE OPCION 3
	resulArreglo BYTE "El arreglo con ordenamiento burbuja es: ", 0
	index_arreglo SDWORD 0
	index_registros SDWORD 0
	val_act SDWORD 0
	val_sig SDWORD 0
	
	; DECLARACIONES GLOBALES
	arreglo_cad byte "Se tiene el siguiente arreglo: ", 0
	salto_de_carro BYTE " ", 0ah
					byte " ",0
	mensaje1 BYTE "Menu:",0ah
			BYTE "1.-Suma impares y multiplica pares de un arreglo",0ah
			BYTE "2.-Busqueda Binaria",0ah
			BYTE "3.-Ordenamiento burbuja",0ah
			BYTE "4.-Salir  :  ",0
	mensaje3 BYTE "No tengo esa opcion, intente de nuevo", 0AH
				BYTE " ",0
	mensaje4 BYTE "Repitiendo ciclo... ", 0
	mjsOpcion1 BYTE "Elegiste la opcion 1",0AH
				BYTE " ",0
	mjsOpcion2 BYTE "Elegiste la opcion 2",0AH
				BYTE " ",0
	mjsOpcion3 BYTE "Elegiste la opcion 3",0AH
				BYTE " ",0
	mjSalir BYTE "Hasta luego...",0AH
			BYTE " ",0
	arreglo SDWORD 31,38,42,65,25,22
	tamArreglo = ($-arreglo) / TYPE arreglo
	
.code
main proc

	IMPRIME_ARRAY_INICIAL:
	mov edx, OFFSET arreglo_cad
	call WriteString 
	mov esi, 0
	jmp revisa_valor
	revisa_valor:
	cmp esi, tamArreglo
	jc imprime_valor
	mov edx, offset salto_de_carro
	call writestring
	jmp MENU
	imprime_valor:
	mov eax, arreglo[esi*4]
	call WriteInt
	inc esi
	jmp revisa_valor

	MENU:
	mov edx, offset mensaje1
	call writestring
	call readint

	cmp eax, 1
	jz opcion1

	cmp eax, 2
	jz opcion2

	cmp eax, 3
	jz opcion3

	cmp eax, 4
	jz opcion4

	mov edx, offset mensaje3
	call writestring
	jmp IMPRIME_ARRAY_INICIAL

	opcion1:
	MOPCION1
	jmp IMPRIME_ARRAY_INICIAL

	opcion2:
	MOPCION2
	jmp IMPRIME_ARRAY_INICIAL

	opcion3:
	MOPCION3
	jmp IMPRIME_ARRAY_INICIAL

	opcion4:
	mov edx, offset mjSalir
	call writestring
	call readkey
	ret
main endp
end main