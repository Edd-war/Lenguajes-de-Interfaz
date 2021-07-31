TITLE Ordenamiento_por_metodo_burbuja

include Irvine32.inc

.data
	mensaje1 BYTE "Elegiste la opcion 1",0
	resulArreglo BYTE "El arreglo con ordenamiento burbuja es:", 0

	index SDWORD 0
	val_act SDWORD 0
	val_sig SDWORD 0
	;arreglo SDWORD 11,18,22,45,5,2
	;tamArreglo = ($-arreglo) / TYPE arreglo
	
.code
main proc
		
	mov edx, offset mensaje1
	call writestring
	
	ret 
main endp
end main