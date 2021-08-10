 name "Cuadro Magico"    
 org 100h

 
.data
     
     
   posicion db ?
   casilla  db 9 dup (?)
   cuadrado db ? 
   valorPrueba db ? 
   valorCasilla db ?
   valor db ?
   contador db ?
   resultados db 200 dup(?)
   opcion dw ?
   vec db 50 dup('?')
   archivo db "datos.txt", 0  
   cero db "0"
   
   incremento db 0
   index db 0
   nuevo_index db 0
   
   dataTam=$-offset data  
   mensaje db 13,10, "Ingresa el numero del cuadro magico:  ", '$'   
            
   numero db ?          
   datos db ?, "$"        
   espacio db ?, "$"           
   salto db 13,10,"",, "$"          
            
   handle dw ?         
            
 .code  
  
    mov ah,09 
    lea dx, mensaje
    int 21h 
    
    mov bx, 0000h
    lea SI, numero
    mov cx, 50
  
    ;Ingresar_Numero     

    ;9   1   6
    ;7   8   2
    ;5   4   3
    
    ;Ingresar_Numero macro
    puntero_lector:
    mov ah,01h
    int 21h
    cmp al, 0dh
    jz convierte_numero_introducido
    mov [si],al
    inc si
    inc bx
    loop puntero_lector          
    ;endm


    ;Funcion para convertir ASCII a hexadecimal y obtencion del cuadrado
    ;convierte_numero_introducido: macro
	convierte_numero_introducido:
	sub numero, 30h        
    mov al,numero
    mul numero
    mov cuadrado,al
  
         
    mov ah,00h 
    mov al,03h
    int 10h
            
    mov ch,0        
    mov cl,cuadrado      
    mov si,1    
    endm

    ;Borramos el archivo y creamos uno nuevo vacio
    ;Inicializa_archivo macro
    mov ah, 41H                   ; Procedimiento para eliminar un archivo
    lea dx, archivo
    int 21H
    jc salir
    
    mov cx, 0                     ; 0H Archivo Normal
                                  ; 1H Solo Lectura
                                  ; 2H Archivo Oculto
                                  ; 3H Archivo de sistema
    lea dx, archivo  
    mov ah, 3CH
    int 21h                       ; Devuelve en ax el handler del archivo / Codigo de error en ax y Flag Carry en 1 
    jc salir
    
    mov nuevo_index, 1
    
    ;endm
    
    ;Inicializa_archivo
    
    
    

    Resuelve_Cuadro:
    mov ah, 3DH                   ; Abrir archivo
    mov al, 2                     ; modo de lectura / escritura
    lea dx, archivo
    int 21h
    jc salir
    mov handle, ax
    xor ax, ax
    
    cmp si, 1
    jz primer_index
    jmp sigue   
    primer_index:
    mov al, numero
    inc al
    mov bl, 2
    div bl
    mov casillas[ax], si
    jmp analiza_ciclo
    
    
    sigue:
    mov al, si
    div numero 
    cmp dx, 0
    jz index_multiplo_numero
    
    
    index_multiplo_numero:
    mov incremento, numero
    jmp analiza_cilo
    
    nuevo_index_multiplo_numero:
    mov al, cuadrado
    mov bl, numero
    dec bl
    sub al, bl
    sub al, numero
    mov incremento, al
    jmp analiza_cilo
    
    ordinario:
    mov al, cuadrado
    mov bl, numero
    dec bl
    sub al, bl
    mov incremento, al
    jmp analiza_cilo
    
    
    analiza_ciclo:
    mov cl, cuadrado
    mov ch, 00 
    
    inc si
    mov ah, 3eh
    int 21h     
    cmp si, cx
    jz completado
    jmp Resuelve_Cuadro
    
    
    Escribir_archivo:
    add ax, 30h   
    mov dx, ax 
    mov ah, 40h
    mov bx, handle
    mov cx, 1
    int 21h
    
    
    
    mov ax, 4C00h
    int 21h
    
    
    completado:
    salir:
    
     
