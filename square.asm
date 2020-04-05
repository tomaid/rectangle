.model small
.stack 100
.data
xx dw 1   ; this is the x axis
yy dw 1   ; this is the y axis
marime dw 35 ; 
mmrmx dw 35
mmrmy dw 35
culoare DB 5
.code
	mov ax,@data
	mov ds,ax
	mov ah, 0h   
	mov al, 13h ; change to graphic mode 13h (320 x 200)
	int 10h     
	call desen
	;call pauza
tastatura:
	in ax, 60h      ;import keyboard code
	cmp al, 48h     ;arrow up
	je sus
	cmp al, 50h     ;arrow down
	je jos
	cmp al, 4Bh     ;arrow left
	je stanga
	cmp al, 4Dh     ;arrow right
	je dreapta
	jmp tastatura
	cmp al, 01h     ;iesire
	je iesire
	jmp tastatura

iesire:	
	mov ah,4ch
	int 21h

sus: call stergedisplay
	dec xx
	mov ax, xx
	cmp ax, 0
	jl jos
	add ax, marime
	mov mmrmy, ax
	mov ax, yy   
	add ax, marime
	mov mmrmx, ax	
	call desen
	jmp tastatura
jos: call stergedisplay
	inc xx
	mov AX, xx   
	add AX, marime
	mov mmrmy, ax
	cmp ax, 200
	jge sus
	mov ax, yy   
	add ax, marime
	mov mmrmx, ax
	call desen
	jmp tastatura
stanga: call stergedisplay
	dec yy
	mov ax, xx   
	add ax, marime
	mov mmrmy, ax
	mov ax, yy  
	cmp ax, 0
	jl dreapta 
	add ax, marime
	mov mmrmx, ax
	call desen
	jmp tastatura
dreapta: call stergedisplay
	inc yy
	mov ax, xx   
	add ax, marime
	mov mmrmy, ax
	mov ax, yy 
	add ax, marime
	mov mmrmx, ax
	cmp ax, 320
	jge stanga  
	call desen
	jmp tastatura
desen:
	mov al, culoare
	mov cx, yy  ; y axis
	mov dx, xx  ; x axis
	mov ah, 0ch ; draw pixel

axax:
	inc cx   ; draw x axis
	int 10h
	cmp cx, mmrmx
	JNE axax
	mov cx, yy  	;
	inc dx      	;increment y axis
	cmp dx, mmrmy  
	JNE axax
	ret

pauza: 	mov     cx, 0fh  ; this is not used, it is just for testing
	mov     dx, 4240h
	mov     ah, 86h
	mov     al, 0
	int     15h
	ret

stergedisplay:
	mov ah, 0           
	mov al, 0Dh
	int 10h
	mov ah,0Ch
	mov al,0
	ret
	
END
