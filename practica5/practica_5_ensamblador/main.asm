INCLUDE Irvine32.inc

MOPCION1 MACRO
	mov esi, 0
	mov edx, offset opc1mensaje1
	call writestring
	mov edx, offset salto_de_carro
	call writestring

	mov edx,OFFSET opc1mensaje2
	call WriteString
	mov edx, offset opc1cadena1
	call writestring
	mov edx, offset salto_de_carro
	call writestring

	mov edx,OFFSET opc1mensaje3
	call WriteString
	mov edx, offset opc1cadena2
	call writestring
	mov edx, offset salto_de_carro
	call writestring

	;mov eax,[opc1cadena1] lee toda la cadena en hexadecimal si funciona
	;mov eax, opc1cadena1[esi]
	;mov tam1, eax
	;inc esi
	;mov eax,opc1cadena1[esi]
	;mov tam1, eax
	;mov ebx,opc1cadena2[esi]
	;mov tam2, ecx
	;cmp ecx, tam1

	bucle_tam_cad1:
	movzx eax, opc1cadena1[esi] 
	inc esi
	cmp esi, opc1tamCadena1
	jc bucle_tam_cad1
	mov tam_cad1_extraido, esi
	mov esi,0

	bucle_tam_cad2:
	movzx eax, opc1cadena2[esi] 
	inc esi
	cmp esi, opc1tamCadena2
	jc bucle_tam_cad2
	mov tam_cad2_extraido, esi
	mov esi,0

	mov eax, tam_cad1_extraido
	mov ebx, tam_cad2_extraido

	cmp eax, ebx
	jz pueden_ser_iguales
	jmp no_son_iguales

	pueden_ser_iguales:
	movzx eax, opc1cadena1[esi]
	movzx ebx, opc1cadena2[esi]
	cmp eax, ebx
	jnz no_son_iguales
	inc esi
	cmp esi, tam_cad1_extraido
	jc pueden_ser_iguales
	jmp si_son_iguales

	mov edx, offset salto_de_carro
	call writestring

	no_son_iguales:
	mov edx, offset opc1mensaje4
	call writestring
	mov edx, offset salto_de_carro
	call writestring
	mov edx, offset salto_de_carro
	call writestring
	call readkey
	jmp salida_opc1
	;ret

	si_son_iguales:
	mov edx, offset opc1mensaje5
	call writestring
	mov edx, offset salto_de_carro
	call writestring
	mov edx, offset salto_de_carro
	call writestring
	call readkey
	jmp salida_opc1
	;ret 

	salida_opc1:
ENDM

MOPCION2 MACRO
	invoke str_copy,addr opc2cadena1,addr opc2cadena2

		mov edx,OFFSET opc2mensaje1
		call WriteString
		;call Crlf
		mov edx, offset salto_de_carro
		call writestring

		mov edx,OFFSET opc2mensaje2
		call WriteString
		mov edx, offset opc2cadena1
		call writestring
		mov edx, offset salto_de_carro
		call writestring

		mov ecx, opc2tamCadena1
		mov esi, 0

		OPC2CICLO1:
			movzx eax,opc2cadena2[esi]
			push eax
			inc esi
		LOOP OPC2CICLO1

		mov ecx, opc2tamCadena1
		mov esi, 0

		OPC2CICLO2:
			pop eax
			mov opc2cadena2[esi],al
			inc esi
		LOOP OPC2CICLO2

		mov edx,OFFSET opc2mensaje3
		call WriteString
		mov edx, offset opc2cadena2
		call writestring
		mov edx, offset salto_de_carro
		call writestring

		invoke Str_compare,addr opc2cadena1,addr opc2cadena2

	jz son_iguales

		mov edx,OFFSET diferentes
		call WriteString
		mov edx, offset salto_de_carro
		call writestring
		call readkey
		call Crlf	
		jmp salida_opc2
		;ret

	son_iguales:
		mov edx,OFFSET iguales
		call WriteString
		mov edx, offset salto_de_carro
		call writestring
		call readkey
		call Crlf
		jmp salida_opc1
	;ret

	salida_opc2:
ENDM

MOPCION3 MACRO
	mov ecx, opc3tamCadena1
	mov esi, 0

	mov edx,OFFSET opc3mensaje1
	call WriteString
	;call crlf
	mov edx, offset salto_de_carro
	call writestring

	mov edx,OFFSET opc3mensaje2
	call WriteString
	mov edx, offset opc3cadena1
	call writestring
	mov edx, offset salto_de_carro
	call writestring

	OPC3CICLO1:
	movzx eax,opc3cadena1[esi]
	mov ebx, a
	cmp ebx,eax
	jz esa
	inc esi
	cmp esi,opc3tamCadena1
	jc OPC3CICLO1

	;ret

	esa:
		inc n_a
		inc esi
		cmp esi,opc3tamCadena1
		jc OPC3CICLO1
		fin:
			mov eax,n_a
			mov ebx,3
			cdq
			idiv ebx
			cmp edx,0
			jz pertenece
			mov edx, OFFSET opc3mensaje3
			call WriteString
			mov edx, offset salto_de_carro	
			call writestring
			mov edx, offset salto_de_carro
			call writestring
			jmp salida_opc3
			;ret
	pertenece:
		mov edx, OFFSET opc3mensaje4
		call WriteString
		mov edx, offset salto_de_carro
		call writestring
		mov edx, offset salto_de_carro
		call writestring
		jmp salida_opc3
		;ret

	salida_opc3:
ENDM

.data

	; VARIABLES DE OPCIÓN 1
	opc1mensaje1 BYTE "Escogiste la opcion 1: ",0
	opc1mensaje2 BYTE "Cadena 1: ",0
	opc1mensaje3 BYTE "Cadena 2: ",0
	opc1mensaje4 BYTE "NO son iguales ",0
	opc1mensaje5 BYTE "SI son iguales",0
	tam_cad1_extraido sdword 0
	tam_cad2_extraido sdword 0

	opc1cadena1 byte "hola mundos",0
	opc1tamCadena1 = ($-opc1cadena1) - 1

	opc1cadena2 byte "hola mundo",0
	opc1tamCadena2 = ($-opc1cadena2) - 1

;	index SDWORD 0
	;arreglo SDWORD 11,18,22,45,5,2
	;tamArreglo = ($-arreglo) / TYPE arreglo

	; VARIABLES DE OPCIÓN 2
	opc2mensaje1 BYTE "Escogiste la opcion 2: ",0
	opc2mensaje2 BYTE "Palabra al derecho: ",0
	opc2mensaje3 BYTE "Palabra al reves  : ",0
	diferentes BYTE "NO es un palindromo",0
	iguales BYTE "SI es un palindromo",0

	;opc2cadena1 DB "anita lava la tina",0	
	opc2cadena1 DB "somos",0	
	opc2tamCadena1 = ($-opc2cadena1) - 1
	opc2cadena2 DB " ",0
	opc2tamCadena2 = ($-opc2cadena2) - 1
	otro byte "Escogiste la opcion 3: ",0

	;VARIABLES DE OPCIÓN 3
	opc3mensaje1 BYTE "Escogiste la opcion 3: ",0
	opc3mensaje2 BYTE "Se tiene la cadena: ",0
	opc3mensaje3 BYTE "NO pertenece",0
	opc3mensaje4 BYTE "SI pertenece",0
	
	a SDWORD "a",0

	n_a SDWORD 0

	opc3cadena1 BYTE "aaaaaaaaa",0
	opc3tamCadena1 = ($-opc3cadena1) - 1

	; VARIABLES GLOBALES
	arreglo_cad byte "Se tiene el siguiente arreglo: ", 0
	salto_de_carro BYTE " ", 0ah
					byte " ", 0
	mensaje1 BYTE "Menu:",0ah
			BYTE "1.-Compara 2 cadenas", 0ah
			BYTE "2.-Palindromos", 0ah
			BYTE "3.-Comprobar si de las veces que se tiene el elemento a en un arreglo es multiplo de 3 ",0ah
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
	mov edx, offset salto_de_carro
	call writestring
	mov edx, offset salto_de_carro
	call writestring
	jmp MENU

	opcion1:
	mov edx, offset salto_de_carro
	call writestring
	MOPCION1
	jmp MENU

	opcion2:
	mov edx, offset salto_de_carro
	call writestring
	MOPCION2
	jmp MENU

	opcion3:
	mov edx, offset salto_de_carro
	call writestring
	MOPCION3
	jmp MENU

	opcion4:
	mov edx, offset mjSalir
	call writestring
	call readkey
	ret

main ENDP
END main