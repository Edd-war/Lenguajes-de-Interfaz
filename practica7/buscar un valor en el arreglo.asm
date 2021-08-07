
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

mensaje macro cadena
    mov ah, 09h
    mov dx, offset cadena
    int 21h    
endm
     
.data
    msj1 db 0ah, 0dh, 'El valor fue encontrado' , '$'
    msj2 db 0ah, 0dh, 'El valor no fue encontrado', '$'
    lista db 3,1,2,5,4
    valor db 5
    
.code
    mov cx, 5
    mov bx, 0
    call buscar

ret


buscar proc
    
    ciclo:
        mov ah, lista[bx]
        cmp ah, valor
        jz encontrado
        inc bl
    loop ciclo
    mensaje msj2
    ret
    
    encontrado:
    mensaje msj1
    ret          
        
buscar endp

