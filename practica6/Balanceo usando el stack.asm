.stack 100h

.data
LF equ 10
OD equ 13

    abierto db 28h
	cerrado db 29h 
	no_bal db 0ah, 0dh, 'Parentesis NO balanceados', '$'
	bal db 0ah, 0dh, 'Parentesis SI balanceados', '$'
	abiertos db 0
	cerrados db 0
	;parentesis db "(()()()())(((())))(()((())()))", 0
	;parentesis db "((((((())()))(()()(()", 0
	;parentesis db ")(", 0
	;parentesis db "(() ()(", 0
    
    mens db "Inserta cadena",LF,OD,"$"
    salto db LF,OD,"$"
    cadena label byte ;este programa acepta como máximo 50 caracteres introducidos
    chare db 50
    max db 50
    entrada db ?

.code

inicio:
    mov ax,@data
    mov ds,ax

    mov ah,09
    lea dx,mens
    int 21h

    mov ah,0ah
    lea dx, cadena
    int 21h


    mov ah,09
    lea dx,salto
    int 21h

    lea si,entrada
    mov cx,00
    
    mov bx, 0

    analizar:
    mov al,[si]
    cmp al,0dh ;si detecta un enter
    jz fin ;deja de contar los caracteres
    inc cx
    inc si
    cmp al, abierto
    jz acumula_abiertos
    cmp al, cerrado
    jz extrae_abiertos
    jmp analizar


    acumula_abiertos:
    mov bl, abierto
	push bx
	jmp analizar
	

	extrae_abiertos:
	pop bx
	cmp bl, abierto
	jz analizar
	
	mov ah,09h
    lea dx, no_bal
    int 21h
    
    mov ax, 4C00h
    int 21h

	fin:
	mov ah,09h
    lea dx, bal
    int 21h

    mov ax, 4C00h
    int 21h

end inicio