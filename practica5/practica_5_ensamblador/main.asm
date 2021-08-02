INCLUDE Irvine32.inc

MOPCION1 MACRO
	mov esi, 0
	mov ecx, tamNombre

	mov edx, offset opc1mensaje1
	call writestring
	mov edx, offset salto_de_carro
	call writestring

	movzx eax,opc1cadena1[esi]
	movzx ebx,opc1cadena2[esi]
	cmp ebx,eax
	jnz pueden_ser_iguales
	inc esi

	mov edx, offset salto_de_carro
	call writestring

	cmp ecx, tamBuffer
	jz pueden_ser_iguales
	no_son_iguales:
	mov edx, offset opc1mensaje4
	call writestring
	mov edx, offset salto_de_carro
	call writestring
	mov edx, offset salto_de_carro
	call writestring
	call readkey
	ret

	pueden_ser_iguales:
	mov eax, opc1cadena1
	mov ebx, opc1cadena2
	cmp eax, ebx
	jnz no_son_iguales
	si_son_iguales:
	mov edx, offset opc1mensaje5
	call writestring
	mov edx, offset salto_de_carro
	call writestring
	mov edx, offset salto_de_carro
	call writestring
	call readkey
	ret 
ENDM

MOPCION2 MACRO
	invoke str_copy,addr opc2cadena1,addr opc2cadena2

		mov edx,OFFSET cadena1
		call WriteString
		call Crlf

		mov ecx, tamCadena
		mov esi, 0

		CICLO1:
			movzx eax,opc2cadena2[esi]
			push eax
			inc esi
		LOOP CICLO1

		mov ecx, tamCadena
		mov esi, 0

		CICLO2:
			pop eax
			mov opc2cadena2[esi],al
			inc esi
		LOOP CICLO2

		mov edx,OFFSET opc2cadena2
		call WriteString
		call Crlf

		invoke Str_compare,addr opc2cadena1,addr opc2cadena2

	jz son_iguales

		mov edx,OFFSET diferentes
		call WriteString
		call Crlf
	ret

	son_iguales:
		mov edx,OFFSET iguales
		call WriteString
		call Crlf
	ret
ENDM

MOPCION3 MACRO
	mov ecx, tamNombre
	mov esi, 0

	CICLO1:
		movzx eax,nombre[esi]
		mov ebx, a
		cmp ebx,eax
		jz esa
		inc esi
		cmp esi,tamNombre
		jc CICLO1

	mov edx, OFFSET nombre
	call WriteString
	ret

	esa:
		inc n_a
		inc esi
		cmp esi,tamNombre
		jc CICLO1
		fin:
			mov eax,n_a
			mov ebx,3
			cdq
			idiv ebx
			cmp edx,0
			jnz pertenece
			mov edx, OFFSET mensaje3
			call WriteString
			ret
	pertenece:
		mov edx, OFFSET mensaje4
		call WriteString
		ret
ENDM

.data

	; VARIABLES DE OPCIÓN 1
	opc1mensaje2 BYTE "Ingresa 1ra cadena: ",0
	opc1mensaje3 BYTE "Ingresa 2da cadena: ",0
	opc1mensaje4 BYTE "NO SON IGUALES ",0
	opc1mensaje5 BYTE "SI SON IGUALES",0
	index sdword 0
	tamBuffer SDWORD ?
	opc1cadena1 sdword "hola",0
	opc1cadena2 sdword "mundo",0
	
;	index SDWORD 0
	;arreglo SDWORD 11,18,22,45,5,2
	;tamArreglo = ($-arreglo) / TYPE arreglo

	; VARIABLES DE OPCIÓN 2
	diferentes BYTE "No es un palindromo",0
	iguales BYTE "Si es un palindromo",0

	opc2cadena1 DB "reconocer",0	
	tamCadena = ($-cadena1) - 1
	opc2cadena2 DB " ",0

	;VARIABLES DE OPCIÓN 3
	mensaje1 BYTE "es a",0
	mensaje2 BYTE "es b",0
	mensaje3 BYTE "si pertenece",0
	mensaje4 BYTE "no pertenece",0
	
	a SDWORD "a",0

	n_a SDWORD 0

	nombre BYTE "aaa",0
	tamNombre = ($-nombre) - 1

	; VARIABLES GLOBALES
	arreglo_cad byte "Se tiene el siguiente arreglo: ", 0
	salto_de_carro BYTE " ", 0ah
					byte " ", 0
	mensaje1 BYTE "Menu:",0ah
			BYTE "1.-Compara 2 cadenas", 0ah
			BYTE "2.-Palindromos", 0ah
			BYTE "3.-Comprobar si de las veces que se tiene else elemento a en un arreglo es multiplo dec 3 ",0ah
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

.code
main PROC
	
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

main ENDP
END main