; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
org 100h
imprime macro cadena
  mov dx,offset cadena
  mov ah,09H
  int 21h
endm
.data
    msj1 db 0ah,0dh, '***** CUADRO MAGICO *****', '$'
    msj2 db 0ah,0dh, 'Ingresa el valor impar para establecer la dimension del cuadro', '$'
    msj3 db 0ah,0dh, 'El valor del arreglo es el siguiente: ', '$' 
    msj7 db 0ah,0dh, 'Opc: ', '$'
    archivo db "C:\emu8086\MyBuild\prueba2.txt",0
    muestra_archivo db "C:\emu8086\MyBuild\prueba2.txt",0
    msjcrear db 0ah,0dh, 'Archivo creado con exito', '$'
    handle dw ?
    longitud dw ?
    base db ?
    cadena db 10,?, 10 dup(' ') 
.code
    mov cx, 1
    imprime msj1
    imprime msj2
    mov ah,01h
    int 21h
    sub al, 30h
    mov base, al
    mov bl, al
    mul bl
    mov longitud, ax
    
    imprime_cuadro:

    mov ah, 3DH                   ; Abrir archivo
    mov al, 2                     ; modo de lectura / escritura
    mov dx, offset archivo        ; mandamos el nombre del archivo
    int 21H                       ; ejecutamos la interrupcion
    jc error
    mov handle, ax
    ;SOLO PARA ENCONTRAR LA POSICION DE 1 EN LA MATRIZ
    mov al, base
    inc al
    mov bl, 2
    div bl
    mov si, ax
    
    mov bx, 0
    ;mov cx,     
                                         
    
    mov bx, handle                ; Escribimos la cadena en el archivo
    mov cx, ax
    mov dx, si+2
    mov ah, 40H
    int 21H
    mov ah, 3EH                   ; Cerrar archivo
    int 21H
     
    ;inc 
    cmp cx, 0
    jc imprime_cuadro

  
  
  
  
  
  
     error:
  
  
  
  
    ;cmp al, 33h
    ;jz modificar
 