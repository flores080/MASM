.model small
.stack 100h

;//////////////////////////////////// PRINT ANY NUMBER
print_number macro number
  xor ax, ax
  mov ax, number
  call PrintNumber
endm

print_char macro char
	push ax
	push dx
	xor dx, dx
	mov ah, 02H
	mov	dx, char
	int 21h
	pop dx
	pop ax
endm

getTmp macro pos
	push ax
	push bx
	push cx
	push dx
	
	pop ax
	pop bx
	pop cx
	pop dx
endm

setTmp macro pos, val
	push ax
	push bx
	push cx
	push dx
	
	pop ax
	pop bx
	pop cx
	pop dx
endm

.386
.data

     
tmp dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
    dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0

stck dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
    dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0

heap dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
    dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0
	dw 0 

     
.code
	main proc
		mov     ax, @data
		mov     ds, ax
		mov     es, ax

		call text_mode	
		
		mov ax, 98
		mov di, 0
		mov tmp[di], ax
		print_char tmp[0]
		
		.exit
	main endp
  
	text_mode proc
		mov ax, 0003h
		int 10h
		ret
	text_mode endp
	
	PrintNumber proc
		xor bx, bx
		xor cx, cx
		mov cx, 0
		mov bx, 10
	  @@loophere:
		  xor edx, edx
		  div bx					;divide by ten

		  ; now ax <-- ax/10
		  ;     dx <-- ax % 10

		  ; print dx
		  ; this is one digit, which we have to convert to ASCII
		  ; the print routine uses dx and ax, so let's push ax
		  ; onto the stack. we clear dx at the beginning of the
		  ; loop anyway, so we don't care if we much around with it

		  push ax
		  add dl, '0'				;convert dl to ascii

		  pop ax					;restore ax
		  push dx					;digits are in reversed order, must use stack
		  inc cx					;remember how many digits we pushed to stack
		  cmp ax, 0				;if ax is zero, we can quit
	  jnz @@loophere

		  ;cx is already set
		  mov ah, 2				;2 is the function number of output char in the DOS Services.
	  @@loophere2:
		  pop dx					;restore digits from last to first
		  int 21h					;calls DOS Services
		  loop @@loophere2

		  ret
	PrintNumber endp
end main

