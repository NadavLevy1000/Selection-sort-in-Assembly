IDEAL 
MODEL small
STACK 100h
DATASEG
Array db 7,0,126,4,3,0,13,18,2,8
msg1 db 'Unsorted Array: $'
msg2 db 'Sorted Array: $'
coma db ', $'
CODESEG


proc SortArray
	pop di
	
	
	
	mov dx,offset msg1
	mov ah,9h
	int 21h
	mov ah,2
	;new line
	mov dl,10
	int 21h
	mov dl,13
	int 21h
	
	pop ax ;array size
	pop bx ;array address
	
	push ax
	
	mov si, 0
	mov cx, ax
printingLoop:
	mov dl,'0'
	add dl,[bx+si]
	mov ah,2h
	int 21h
	mov ah,2
	mov dx,offset coma
	mov ah,9h
	int 21h
	mov ah,2
	
	inc si
loop printingLoop
	
	;new line
	mov dl,10
	int 21h
	mov dl,13
	int 21h
	
	pop ax
	
	push di
	mov cx, ax
	mov si, 0
startSortingLoop:
	push bx
	push ax
	push cx
	push si
	
	
	mov cx, bx
	add cx, si
	push ax
	push cx
	call FindMin
	;pop si
	;add ax, si
	;push si
	push ax
	push si
	push [bx]
	call Swap
	
	
	pop si
	pop cx
	pop ax
	pop bx
	inc si
	loop startSortingLoop
	
	push ax
	
	
	
	mov dx,offset msg2
	mov ah,9h
	int 21h
	mov ah,2
	;new line
	mov dl,10
	int 21h
	mov dl,13
	int 21h
	
	
	pop ax
	
	mov si, 0
	mov cx, ax
printingLoop2:
	mov dl,'0'
	add dl,[bx+si]
	mov ah,2h
	int 21h
	mov ah,2
	mov dx,offset coma
	mov ah,9h
	int 21h
	mov ah,2
	
	inc si
loop printingLoop2
	ret
endp SortArray

proc Swap
	pop ax ; address
	pop di ; address of array
	pop bx ; first address in array
	pop si ; second address in array
	mov cl, [bx]
	mov dl, [si]
	mov [bx], dl
	mov [si], cl
	
	push ax
	ret
endp Swap


proc FindMin
	pop di
	pop bx ;array address
	pop si ;array size
	dec si
	sub si, bx
	mov dl, [bx+si]
	mov ax, bx
	add ax, si
	xor ah,ah
	mov cx, si
	inc cx
	;save in dx the smallest
startLoop:
	cmp dl, [bx+si]
	jle dontEnter
	mov dl, [bx+si]
	mov ax, bx
	add ax, si
	xor ah,ah
dontEnter:
	dec si
	loop startLoop
	inc si
	add si,bx
	push di
	ret
endp FindMin


start:
	mov ax, @data
	mov ds, ax
	
	push offset Array
	push 10
	call SortArray
	
exit:
	mov ax, 4c00h
	int 21h
END start