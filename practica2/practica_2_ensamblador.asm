org 100h

.data
LF equ 10
OD equ 13

 
	opc1msj1 db 13, 10, 'Ingresa un numero para calcular su factorial: ', '$'
	;no_bal db 0ah, 0dh, 'Parentesis NO balanceados', '$'
	;bal db 0ah, 0dh, 'Parentesis SI balanceados', '$'
	;abiertos db 0
	;cerrados db 0
    
    numero dw ?
    ;mens db "Inserta cadena",LF,OD,"$"
    ;salto db LF,OD,"$"
    ;cadena label byte ;este programa acepta como máximo 50 caracteres introducidos
    ;chare db 50
    ;max db 50
    entrada db ?

.code

inicio:
    mov ah, 09
    lea dx, opc1msj1
    int 21h 
 
    mov bx, 0000h
    lea si, numero
    mov cx, 2
  
    puntero_lector:
    mov ah,01h
    int 21h
    cmp al, 0dh
    jz convierte_numero_introducido
    mov ah, 0
    push ax
    ;inc si
    inc bx
    cmp bx, 2
    mov ah, 00
    loop puntero_lector
    pop ax          
    sub al, 30h
    mov numero, al
    pop ax
    ;mov al, [si]
    ;xchg al, numero
    sub al, 30h
    mov bx, 10
    mul bx
    ;add al, numero
    add numero, al
    jmp continua
    
    ;Funcion para convertir ASCII a hexadecimal y obtencion del cuadrado
    ;convierte_numero_introducido: macro
	convierte_numero_introducido:
	sub numero, 30h        
    mov al,numero
    
    continua:
    xor cx, cx
    mov cl, numero
    xor ax, ax
    mov al, cl
    factorial:
    mul   
    loop factorial
         
    mov ah,00h 
    mov al,03h
    int 10h
    
    

    mov ax, 4C00h
    int 21h

end inicio