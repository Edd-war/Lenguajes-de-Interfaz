 name "Cuadro Magico"    
 org 100h

 
.data
     
     
   ;posicion db ?
   casillas db 9 dup (0)
   cuadrado db ? 
   ;valorPrueba db ? 
   ;valorCasilla db ?
   ;valor db ?
   ;contador db ?
   ;resultados db 200 dup(?)
   ;opcion dw ?
   ;vec db 50 dup('?')
   archivo db "datos.txt", 0  
   ;cero db "0"
   
   incremento db 0
   index db 0
   nuevo_index db 0
   
   ;dataTam=$-offset data  
   mensaje db 13,10, "Ingresa el numero del cuadro magico:  ", '$'   
            
   numero db ?          
   datos db ?, "$"        
   espacio db ?, "$"           
   ;salto db 13,10,"",, "$"          
            
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
    mov al,1
    mov index, al    
    ;endm

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
    
    ;mov cl, cuadrado
    ;mov ch, 00

    ;cmp si, 1
    ;jz primer_index
    ;jmp sigue   
    ;primer_index:
    mov al, numero
    inc al
    mov bl, 2
    div bl
    mov bx, ax
    mov nuevo_index, bl
    lea di, casillas
    sub bl, index
    add di, bx
    mov al, index
    mov [di], al 
    jmp salto_ordinario
    
    Resuelve_Cuadro:
    mov al, nuevo_index
    add al, incremento
    mov nuevo_index, al
    ;AQUI SE PONE EL INCREMENTO PENDIENTE CUANDO SE REGRESA EL INDEX DEL ARREGLO A 1
    ;add al, nuevo_index    ;aqui al es el incremento a dar cuando se repita el ciclo
    ;cmp al, cuadrado
    ;jc acciona_incremento    ; si sumados el nuevo index y el aumento es mayor que el cuadrado entonces se decuenta la diferencia al límite y comienza a contar el index de [di] en 1
    ;sub al, cuadrado
    ;mov ch, 00
    ;mov cl, nuevo_index
    ;mov incremento, al          ;"Incremento pendiente"
    ;regresa_index_arreglo:
    ;dec di   
    ;loop regresa_index_arreglo
    ;mov nuevo_index, 0
    mov ah, 00
    add di, ax 
    mov al, index
    sub di, ax     
    mov [di], al
    mov bl, numero
    mov bh, 00
    xor dx, dx
    div bx 
    cmp dx, 0
    jz index_multiplo_numero 
    mov ax, 0000
    mov al, nuevo_index
    xor dx, dx
    div numero
    cmp dx, 0
    jz nuevo_index_multiplo_numero
    jmp salto_ordinario 
    
    index_multiplo_numero: 
    mov al, numero
    mov incremento, al
    jmp analiza_ciclo
    
    nuevo_index_multiplo_numero:
    mov al, cuadrado
    mov bl, numero
    dec bl
    sub al, bl
    sub al, numero
    mov incremento, al
    ;mov si, index
    ;mov casillas[ax], si
    jmp analiza_ciclo
    
    salto_ordinario:
    ;mov nuevo_index, al
    mov al, cuadrado
    mov bl, numero
    dec bl
    sub al, bl
    mov incremento, al
    jmp analiza_ciclo
    
    
    analiza_ciclo:
    
    
    ;acciona_incremento:
    inc index
    mov cl, cuadrado     
    cmp cl, index
    jc completado
    jnc Resuelve_Cuadro
    
    
    
    Abrir_archivo:
    mov ah, 3DH                   ; Abrir archivo
    mov al, 2                     ; modo de lectura / escritura
    lea dx, archivo
    int 21h
    jc salir
    mov handle, ax
    xor ax, ax
    
    Escribir_archivo:
    add ax, 30h   
    mov dx, ax 
    mov ah, 40h
    mov bx, handle
    mov cx, 1
    int 21h
    
    
    Cerrar_archivo:
    mov ah, 3eh
    int 21h
    
    
    
    mov ax, 4C00h
    int 21h
    
    
    completado:
    salir:
    
     
