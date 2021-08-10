
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.data
anio dw 0

mensaje1  db 13,10, "Ingresa un anio: ", "$"
mensaje2 db 13,10, "NO es bisiesto", "$"
mensaje3 db 13,10, "SI es bisiesto ", "$"


.code
main proc

    lea dx, mensaje1
    mov ah, 09h
    int 21h

    mov cx, 4

    ingresando_anio:
    mov ah, 01h
    int 21h
    cmp al, 0dh
    jz sigue
    
    sub al, 30h
    cmp cx, 4
    jz miles
    cmp cx, 3
    jz cienes
    cmp cx, 2
    jz decenas
    cmp cx, 1
    jz unidades
    
    unidades:
    mov ah, 00
    mov bx, 1
    mul bx
    jmp guardar
    
    decenas:
    mov ah, 00
    mov bx, 10
    mul bx
    jmp guardar
    
    cienes:
    mov ah, 00
    mov bx, 100
    mul bx
    jmp guardar
    
    
    miles: 
    mov ah, 00
    mov bx, 1000
    mul bx
    jmp guardar
    
    
    guardar:
    add anio, ax

    loop ingresando_anio
            
            
    sigue:           
    mov bx, 400
    mov ax, anio            
    xor dx, dx            
    div bx                                       


    cmp dx, 0
    jz si_bisiesto
    
    mov ax, dx
    xor dx, dx
    mov bx, 4
    div bx
    
    cmp ax, 19h         ;25
    jz no_bisiesto
    cmp ax, 32h         ;50
    jz no_bisiesto
    cmp ax, 4bh         ;75
    jz no_bisiesto
    cmp dx, 0
    jz si_bisiesto



    no_bisiesto:                    
    lea dx, mensaje2
    mov ah, 09h
    int 21h
    ret
    
    si_bisiesto:
    lea dx, mensaje3        
    mov ah, 09h            
    int 21h
      

    ret

main endp
end main


