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
	mov al, 13h ; comutare in modul grafic 13h (320 x 200)
	int 10h     
	call desen
	;call pauza
tastatura:
	in ax, 60h      ;importa codul tastaturii
	cmp al, 48h     ;sageata in sus
	je sus
	cmp al, 50h     ;sageata in jos
	je jos
	cmp al, 4Bh     ;sageata stanga
	je stanga
	cmp al, 4Dh     ;sageata dreapta
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
	mov cx, yy  ; axa y
	mov dx, xx  ; axa x
	mov ah, 0ch ; deseneaza pixel

axax:
	inc cx   ; deseneaza axa x
	int 10h
	cmp cx, mmrmx
	JNE axax
	mov cx, yy  	;
	inc dx      	;incrementeaza axa y
	cmp dx, mmrmy  
	JNE axax
	ret

pauza: 	mov     cx, 0fh  ; pauza 10 sec
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
