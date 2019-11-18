.model small
.stack 100h

;//////////////////////////////////// PRINT ANY NUMBER
print_number macro number
  push dx
  push ax
  xor dx, dx
  mov dx, number
  xor ax, ax
  mov ax, dx
  call PrintNumber
  pop ax
  pop dx
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

getTmpDI macro pos
	push bx
	push cx
	push dx
	push si	
	
	mov si, pos
	shl SI, 1
	mov di, tmp[si]
	
	pop si
	pop dx
	pop cx
	pop bx
endm

getTmpSI macro pos
	push bx
	push cx
	push dx
	push di	
	
	mov si, pos
	shl SI, 1
	mov si, tmp[si]
	
	pop di
	pop dx
	pop cx
	pop bx
endm

getTmpAX macro pos
	push bx
	push cx
	push dx
	push si	
	
	xor ax, ax
	mov si, pos
	shl SI, 1
	mov ax, tmp[si]
	
	pop si
	pop dx
	pop cx
	pop bx
endm

getTmpBX macro pos
	push ax
	push cx
	push dx
	push si
		
	xor bx, bx
	mov si, pos
	shl SI, 1
	mov bx, tmp[si]
	
	pop si
	pop dx
	pop cx
	pop ax
endm

setTmp macro pos, val
	push ax
	push bx
	push cx
	push dx
	push si
	push di		
	
	mov di, pos
	shl di, 1
	mov tmp[di], val
	
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
endm

setP macro val
	push ax
	push bx
	push cx
	push dx	
	
	mov P, val

	pop dx
	pop cx
	pop bx
	pop ax
endm

setH macro val
	push ax
	push bx
	push cx
	push dx	
	
	mov H, val

	pop dx
	pop cx
	pop bx
	pop ax
endm


.386
.data

P dw 1
H dw 1
     
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

MOV AX, P
MOV BX, 0
ADD AX, BX
setTmp 1, AX	;obtiene a
MOV AX, 4
MOV BX, 3
ADD AX, BX
setTmp 2, AX
MOV AX, 2
MOV BX, 4
IMUL BX
setTmp 3, AX
getTmpAX 2
getTmpBX 3
ADD AX, BX
setTmp 4, AX
getTmpAX 4
MOV BX, 3
ADD AX, BX
setTmp 5, AX
MOV AX, 2
MOV BX, 1
IMUL BX
setTmp 6, AX
getTmpAX 5
getTmpBX 6
SBB AX, BX
setTmp 7, AX
; -------- Empieza Asignacion -------- 
getTmpDI 1
getTmpBX 7
SHL DI, 1
MOV stck[DI], BX
; -------- Termina Asginacion -------- 
; -------- string asign -------- 
MOV AX, H
setTmp 8, AX	;string start
getTmpAX 8
MOV BX, 0
ADD AX, BX
setTmp 9, AX	;str[0]
getTmpDI 9
MOV BX, 9
SHL DI, 1
MOV heap[DI], BX	;str[0]=9 (strLth)
getTmpAX 8
MOV BX, 1
ADD AX, BX
setTmp 10, AX	;str[1]
getTmpDI 10
MOV BX, 104
SHL DI, 1
MOV heap[DI], BX	;str[1]=h
getTmpAX 8
MOV BX, 2
ADD AX, BX
setTmp 11, AX	;str[2]
getTmpDI 11
MOV BX, 111
SHL DI, 1
MOV heap[DI], BX	;str[2]=o
getTmpAX 8
MOV BX, 3
ADD AX, BX
setTmp 12, AX	;str[3]
getTmpDI 12
MOV BX, 108
SHL DI, 1
MOV heap[DI], BX	;str[3]=l
getTmpAX 8
MOV BX, 4
ADD AX, BX
setTmp 13, AX	;str[4]
getTmpDI 13
MOV BX, 97
SHL DI, 1
MOV heap[DI], BX	;str[4]=a
getTmpAX 8
MOV BX, 5
ADD AX, BX
setTmp 14, AX	;str[5]
getTmpDI 14
MOV BX, 44
SHL DI, 1
MOV heap[DI], BX	;str[5]=,
getTmpAX 8
MOV BX, 6
ADD AX, BX
setTmp 15, AX	;str[6]
getTmpDI 15
MOV BX, 32
SHL DI, 1
MOV heap[DI], BX	;str[6]= 
getTmpAX 8
MOV BX, 7
ADD AX, BX
setTmp 16, AX	;str[7]
getTmpDI 16
MOV BX, 97
SHL DI, 1
MOV heap[DI], BX	;str[7]=a
getTmpAX 8
MOV BX, 8
ADD AX, BX
setTmp 17, AX	;str[8]
getTmpDI 17
MOV BX, 58
SHL DI, 1
MOV heap[DI], BX	;str[8]=:
getTmpAX 8
MOV BX, 9
ADD AX, BX
setTmp 18, AX	;str[9]
getTmpDI 18
MOV BX, 32
SHL DI, 1
MOV heap[DI], BX	;str[9]= 
MOV AX, 10
ADD H, AX	;string size
getTmpSI 8
SHL SI, 1
MOV AX, heap[SI]
setTmp 19, AX
getTmpAX 19
getTmpBX 8
ADD AX, BX
setTmp 19, AX
getTmpAX 8
MOV BX, 1
ADD AX, BX
setTmp 20, AX
l1:
getTmpSI 20
SHL SI, 1
MOV AX, heap[SI]
setTmp 21, AX
getTmpAX 21
print_char AX
getTmpAX 20
MOV BX, 1
ADD AX, BX
setTmp 20, AX
getTmpAX 20
getTmpBX 19
CMP AX, BX
JLE l1
MOV AX, P
MOV BX, 0
ADD AX, BX
setTmp 22, AX	;obtiene a
getTmpSI 22
SHL SI, 1
MOV AX, stck[SI]
setTmp 23, AX
getTmpAX 23
print_number AX
MOV AX, 10
print_char AX
		
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

