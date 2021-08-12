.stack 100h

.data
LF equ 10
OD equ 13

 
	opc1msj1 db 0ah, 0dh, 'Ingresa un numero para calcular su factorial: ', '$'
	no_bal db 0ah, 0dh, 'Parentesis NO balanceados', '$'
	bal db 0ah, 0dh, 'Parentesis SI balanceados', '$'
	abiertos db 0
	cerrados db 0
    
    mens db "Inserta cadena",LF,OD,"$"
    salto db LF,OD,"$"
    cadena label byte ;este programa acepta como máximo 50 caracteres introducidos
    chare db 50
    max db 50
    entrada db ?

.code

inicio:
    mov ah, 09
    lea dx, opc1msj1
    int 21h 
 
    mov bx, 0000h
    lea SI, numero
    mov cx, 2
  
    puntero_lector:
    mov ah,01h
    int 21h
    cmp al, 0dh
    jz convierte_numero_introducido
    mov [si],al
    inc si
    inc bx
    loop puntero_lector          


    ;Funcion para convertir ASCII a hexadecimal y obtencion del cuadrado
    ;convierte_numero_introducido: macro
	convierte_numero_introducido:
	sub numero, 30h        
    mov al,numero
    mul numero
    mov cuadrado,al
    
    
    
    
    
    
    
    
    
    
    
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
             
    pop bx
    pop bx
    mov bx, 0

    analizar:
    mov al,[si]
    cmp al,0dh ;si detecta un enter
    jz fin ;deja de contar los caracteres
    inc cx
    inc si
    cmp al, 28h
    jz acumula_abiertos
    cmp al, 29h
    jz extrae_abiertos
    jmp analizar


    acumula_abiertos:
	push 28h
	jmp analizar
	

	extrae_abiertos:
	pop bx
	cmp bl, 28h
	jz analizar
	
	no_balanceados:
	mov ah,09h
    lea dx, no_bal
    int 21h
    
    mov ax, 4C00h
    int 21h

	fin:
	pop bx
	cmp bl, 28h
	jz no_balanceados
	cmp bl, 29h
    jz no_balanceados
	mov ah,09h
    lea dx, bal
    int 21h

    mov ax, 4C00h
    int 21h

end inicio