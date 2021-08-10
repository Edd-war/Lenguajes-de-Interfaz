 name "Cuadro Magico"    
 org 100h

Ingresar_Numero macro
    puntero_lector:
    mov ah,01h
    int 21h
    cmp al, 0dh
    jz convierte_numero_introducido
    mov [si],al
    inc si
    inc bx
    loop puntero_lector          
endm


;Funcion para convertir ASCII a hexadecimal y obtencion del cuadrado
convierte_numero_introducido: macro
	sub numero, 30h        
    mov al,numero
    mul numero
    mov cuadrado,al
  
         
    mov ah,00h 
    mov al,03h
    int 10h
    
    mov cl,cuadrado  
    mov ch,0 
    mov si,1    
endm

;Borramos el archivo y creamos uno nuevo vacio
Inicializa_archivo macro
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
    
    mov nuevo_index, 0
    
endm




leer: macro 
    mov al,valorPrueba
    mov ah,0  
    mov si,ax  
    mov ah,casilla[si]   
       
    mov valorCasilla,ah   
    endm

    ; macro para leer el valor que se encuentre en la posicion del puntero

cambiar macro
    mov al,valor
    mov ah,0 
    mov si,ax
    mov al,posicion
    mov casilla[si],al
  
endm

; macro para sacar el cero de la posicion del puntero y colocar el numero correspondiente
  

      
 
.data
     
     
   posicion db ?
   casilla  db 169 dup (?)
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
  
    Ingresar_Numero     

    ;9   1   6
    ;7   8   2
    ;5   4   3
    
    Inicializa_archivo
    

    Resuelve_Cuadro:
    
    mov ah, 3DH                   ; Abrir archivo
    mov al, 2                     ; modo de lectura / escritura
    lea dx, archivo
    int 21h
    jc salir
    mov handle, ax
    xor ax, ax
    
    
    
    
    loop Resuelve_Cuadro
    
    
    
    
    
    
    
    
    
     
    ; Las posibles posiciones a ocupar se inicializan con 0
    Inicializa_Arreglo: 
    mov al,0
    mov casilla[si],al
    inc si
    loop Inicializa_Arreglo
    
     
    
mov al,numero
mov cl,1
mul cl
mov valor,al         
mov posicion,1

cambiar

   

mov cl,1
; ciclo que realiza el procedimiento de resolucion del cuadro magico
for:
mov al,valor
mov valorPrueba,al
cmp al,0
jz inicial
jmp sinosi1
inicial:
mov al, cuadrado
dec al
mov valorPrueba,al
jmp cont 

sinosi1:
mov ah,numero
dec ah   
cmp ah,al
jnc numeroMayor
jmp sinosi

numeroMayor:
mov ah,valorPrueba
mov al,0
cmp al,ah
jc pruebaMayor 
jmp sinosi 

pruebaMayor:
mov al,valorPrueba
sub al,numero
dec al     
add al,cuadrado
mov valorPrueba,al
jmp cont
sinosi:
mov al,valorPrueba
modulo:         
sub al,numero

cmp al,numero
jge modulo 

cmp al,0
jz moduloCero  
jmp sino
moduloCero:
mov al,valorPrueba
dec al
mov valorPrueba,al
jmp cont
sino:
mov al,valorPrueba
 sub al,numero
dec al
mov valorPrueba,al
jmp cont
 
cont:
leer
cmp valorCasilla,0
jz casillaCero
jmp sinosi2  

casillaCero:
mov ah,valorPrueba
mov valor,ah
mov posicion,cl
inc posicion
cambiar 

jmp cont2
sinosi2:
mov al,valor
inc al

modulo2: 
sub al,numero
cmp al,numero
jge modulo2
cmp al,0
jz moduloValor
jmp sino2  

moduloValor:
mov al,valor
sub al,numero
inc al
mov valor,al
mov posicion,cl
inc posicion
cambiar
jmp cont2 

sino2:
inc valor
mov posicion,cl
inc posicion
cambiar
jmp cont2  

cont2:
mov bl,cuadrado
dec bl
inc cl
cmp bl,cl
jge for 

mov cl,0
mov si,0 
mov bl,numero
dec bl 
jmp imprimircolumna


; se encarga de convertir numeros de dos digitos a codigo ascii
decena:

modulounidad:
sub al,10
cmp al,10
jge modulounidad
mov ah,al
add al,48
mov bh,al

mov al,casilla[si]
sub al,ah
mov ah,0 

modulodecena:
sub al,10
inc ah
cmp al,10
jge modulodecena
add ah,48 
mov al,ah
mov datos,al
mov ah,09 
    mov dx,offset datos
    int 21h
    mov ah,09
    mov datos,bh
mov ah,09 
    mov dx,offset datos
    int 21h
    mov ah,09             ;se imprime en consola el numero
    mov dx,offset espacio
    int 21h
    inc si
    inc ch

jmp comparando
; se encarga de convertir numeros de tres digitos a codigo ascii
centena:
 
 
sub al,100 
 
modulounidad2:
sub al,10
cmp al,10
jge modulounidad2
mov ah,al
add al,48
mov bh,al

mov al,casilla[si]
sub al,100
sub al,ah
mov ah,0 

modulodecena2:
sub al,10
inc ah
cmp al,10
jge modulodecena2
add ah,48 
mov al,ah
mov ah,1
mov datos,ah
mov ah,09 
    mov dx,offset datos
    int 21h
    mov ah,09
    mov datos,bh

mov datos,al
mov ah,09 
    mov dx,offset datos
    int 21h
    mov ah,09
    mov datos,bh
mov ah,09 
    mov dx,offset datos
    int 21h
    mov ah,09            ;se imprime en consola el numero
    mov dx,offset espacio
    int 21h
    inc si
    inc ch

jmp comparando


;se realiza la impresion en consola de los numeros del cuadro magico ya acomodados en su posicon correspondiente 
imprimircolumna: 
mov ch,0

imprimir:
mov al,casilla[si]
mov ah,9
cmp ah,al
jc decena ;salta si el numero contiene una o mas decenas
mov ah,99
cmp ah,al
jc centena ;salta si el numero contiene una o mas centenas
add al,48 ;conversion de unidades a codigo ascii
mov datos,al
mov ah,09 
    mov dx,offset datos
    int 21h
    mov ah,09 ;se imprime en consola el numero
    mov dx,offset espacio
    int 21h
    inc si
    inc ch
    jmp comparando 
    
comparando:
cmp bl,ch  
jge imprimir

mov ah,09 
    lea dx, salto
    int 21h
 mov ah,09 
    lea dx, salto
    int 21h
inc cl
cmp bl,cl     
jge imprimircolumna   
    
 ret