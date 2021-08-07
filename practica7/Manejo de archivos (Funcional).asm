; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
org 100h
imprime macro cadena
  mov dx,offset cadena
  mov ah,09H
  int 21h
endm
.data
    msj1 db 0ah,0dh, '***** Menu *****', '$'
    msj2 db 0ah,0dh, '1.- Crear Archivo', '$'
    msj3 db 0ah,0dh, '2.- Leer Archivo', '$'
    msj4 db 0ah,0dh, '3.- Modificar archivo', '$'
    msj5 db 0ah,0dh, '4.- Eliminar archivo', '$'
    msj6 db 0ah,0dh, '5.- Salir', '$' 
    msj7 db 0ah,0dh, 'Opc: ', '$'
    archivo db "C:\emu8086\MyBuild\prueba2.txt",0
    muestra_archivo db "C:\emu8086\MyBuild\prueba2.txt",0
    msjcrear db 0ah,0dh, 'Archivo creado con exito', '$'
    handle dw ?
    cadena db 10,?, 10 dup(' ') 
.code
  menu:
  imprime msj1
  imprime msj2
  imprime msj3
  imprime msj4
  imprime msj5
  imprime msj6
  imprime msj7
  mov ah,01h  ; Leemos un caracter y lo guardamos en el registro al
  int 21h                
  cmp al, 31h
  jz crear 
  cmp al, 32h
  jz abrir
  cmp al, 33h
  jz modificar
  cmp al, 34h
  jz eliminar
  cmp al, 35h
  jz salir 
  crear:
  mov cx, 0                     ; 0H Archivo Normal
                                ; 1H Solo Lectura
                                ; 2H Archivo Oculto
                                ; 3H Archivo de sistema
  mov dx, offset archivo  
  mov ah, 3CH
  int 21h                       ; Devuelve en ax el handler del archivo / Codigo de error en ax y Flag Carry en 1 
  jc salir      
  imprime msjcrear
  mov bx, ax                    ; Pasamos el manejador
  mov ah,3EH                    ; Procedimiento para cerrar archivo
  int 21h                       ; Devuelve en ax el handler del archivo / Codigo de error en ax y Flag Carry en 1 
  jmp menu
  abrir:
  mov ah, 3DH                   ; Abrir archivo
  mov al, 0                     ; modo de lectura
  mov dx, offset archivo        ; mandamos el nombre del archivo
  int 21H                       ; ejecutamos la interrupcion
  jc salir
  mov handle, ax                                  
  ;xor dx, dx                   ;ESTO PARA QUE NO SE MOFIQUE YA LA VARIABLE DEL OFFSET DX AL ASIGNARLE OTRO VALOR
  mov bx, handle                ; Posicionamos el apuntador dentro del archivo     
  mov ah, 42H                   ; PUNTERO
  mov al, 0                     ; En la posicion 0
  mov cx, 10                    ; Cantidad de bytes a leer
  mov dx, offset muestra_archivo
  int 21H
  mov ah, 3FH                   ; Procedimiento para leer el archivo  (LECTURA)
  mov bx, handle
  ;mov dx, offset archivo 
  int 21H
  mov ah, 09H
  mov bx, handle                ; Imprimimos la cadena que se extrajo del archivo
  int 21H        
  mov ah, 3EH                   ; Cerramos el archivo
  int 21H
  jmp menu
  ;//////////////////////////////////////////////////////////////////////////////////////////////
  modificar:
  mov ah, 3DH                   ; Abrir archivo
  mov al, 2                     ; modo de lectura / escritura
  mov dx, offset archivo        ; mandamos el nombre del archivo
  int 21H                       ; ejecutamos la interrupcion
  jc salir
  mov handle, ax                                           
  xor ax, ax                    ; Leemos la cadena y guardamos en la variable
  mov dx, offset cadena
  mov ah, 0AH
  int 21H                                               
  xor bx, bx                    ; Complemos la cadena con el $
  mov bl, cadena[1]
  mov cadena[bx+2], '$'                                                              
  mov dx, offset cadena + 2     ; linea opcional para mostrar el contenido de la variable
  mov ah, 9
  int 21H
  mov bx, handle                ; Escribimos la cadena en el archivo
  mov cl, cadena[1]
  mov dx, offset cadena+2
  mov ah, 40H
  int 21H
  mov ah, 3EH                   ; Cerrar archivo
  int 21H
  jmp menu
  ;//////////////////////////////////////////////////////////////////////////////////////////////
  eliminar:
  mov ah, 41H                   ; Procedimiento para eliminar un archivo
  mov dx, offset archivo
  int 21H
  jc salir
  jmp menu
  salir:
  mov ah, 4CH
  int 21H