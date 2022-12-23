;=== Transformar em Int ====;      

 	;Ler Key
 	mov dx, offset k
 	mov ah, 0Ah
	int 21h
    
    ;Escrever NewLine
    mov dx, offset NEWLINE
	mov ah, 9
	int 21h		         
    
    mov cx,0
    mov [k],cl
    
    
    mov bx, 1
    mov cl, [k+1]
    
    loop_1: 
        mov si,cx
        mov al,[k+1+si]
        sub al,"0" 
        mov dx,0
        mul bx
        add [k],al         
        mov bx,10
        
    loop loop_1     
    
;===========================;      
    
                       
  
;====== Abrir arquivo ======;     
  
    mov al, 0
	mov dx, offset input
	mov ah, 3dh
	int 21h 
    
    push ax
    
    ;Ler o arquivo    
	mov bx, ax
	mov dx, offset inputMsg
	mov cx, 100
	mov ah, 3fh
	int 21h
	
    push ax  
    
    ;Colocando o $ para imprimir
    mov si, ax    
    mov [inputMsg + si], '$' 
       
    ;NEWLINE	
    mov dx, offset NEWLINE
	mov ah, 9
	int 21h    

    ;Escreve uma string
    mov ax, 0
    mov dx, offset inputMsg
    mov ah, 9
    pop cx
    int 21h
    
    ;Fechar o arquivo         
	pop bx  
	mov ah, 3eh
	int 21h
	push cx     
	
;===========================;            



;=== Criptografar Mensagem ==;
 
mov si, 0 
xor dx,dx
loop_2:                       
    xor ax,ax  
    xor dx,dx
    mov al,[inputMsg + si]
    cmp al, 'A'
    jl saida
    cmp al, 'Z'
    jg saida
    
    
    
    sub ax, 'A'
    add al, [k]
    mov bl, 26
    div bx
    
    add dl, 'A'
    mov [cripMsg + si], dl
    inc si
jmp loop_2


;===========================;
                             
saida:                             
                                                          
;====== Criar arquivo ======;                             

	mov ah, 3ch
	mov cx, 0
	mov dx, offset output
	int 21h  

    push ax  

    ;Escrever mensagem
    pop bx   
    push bx  
    mov dx, offset cripMsg
    mov ah, 40h
    pop cx
    int 21h
    
    ;Fechar o arquivo
    pop bx  
    mov ah, 3eh
    int 21h
    push cx  
	
;===========================;  	                             
        
ret                           

NEWLINE db 10,13,'$'          
               
input db "C:/input.txt",0
inputMsg db 30,?,30 dup(?) 

k db 10,?,10 dup(?)        

cripMsg db 30,?,30 dup(?)

output db "C:/outp.txt",0             