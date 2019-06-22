.model small
.stack 32
.data  

get_value1 db ,0dh,0ah, "Enter value 1: $" ,0dh,0ah
get_value2 db ,0dh,0ah, "Enter value 2: $" ,0dh,0ah

menu db ,0dh,0ah,"Choose An Operation" ,0dh,0ah
	db "Addition: +" ,0dh,0ah	
	db "Substraction: -" ,0dh,0ah
	db "Multiplication: *" ,0dh,0ah
	db "Division: /" ,0dh,0ah
	db "Press any Key: $"


add_title db ,0dh,0ah,0dh,0ah, "ADDITION $" ,0dh,0ah
sub_title db ,0dh,0ah,0dh,0ah, "SUBSTRACTION $" ,0dh,0ah
mul_title db ,0dh,0ah,0dh,0ah, "MULTIPLICATION $" ,0dh,0ah
div_title db ,0dh,0ah,0dh,0ah, "DIVISION $" ,0dh,0ah  

ans db ,0dh,0ah, "Answer: $" ,0dh,0ah  

;Islem yapilacak operandlar
op1 db ?                               
op2 db ?                               
 
.code
mov ax, @data
mov ds, ax

jmp start  

start: 
mov ax, 0000h ;yanlis girdi alindiginda tekrar denemek icin sifirlanir. 
mov dx, offset menu 
mov ah, 09
int 21h
       
mov ah, 01h
int 21h    
jmp is_add


;Klavyeden alinan degerin dogru olup olmadigi kontrol edilir.
;- Dogruysa ilgili isleme yonlendirilir.   
;- Dogru degilse kullanicidan tekrar deger alinir.

is_add:
cmp al, '+'
je addition 
jne is_sub
          
is_sub:          
cmp al, '-' 
je substraction
jne is_mul

is_mul:
cmp al, '*'
je multiplication
jne is_div
          
is_div:          
cmp al, '/'
je division
jne start          

;Dort islemin yapilacagi kisim 

;Toplama Islemi           
addition:
mov dx, offset add_title
mov ah, 09
int 21h

;Ilk operand girisi
mov dx, offset get_value1 
mov ah, 09
int 21h
       
mov ah, 01h
int 21h

mov op1, al
 
;Ikinci operand girisi
mov dx, offset get_value2 
mov ah, 09
int 21h
       
mov ah, 01h
int 21h 
         
mov op2, al          

;Sonucu yazdir
mov dx, offset ans  
mov ah, 09
int 21h   

mov al, op1
mov bl, op2

add al, bl 

aas
or ax, 3030h

mov ah, 0eh
int 10h

jmp exit  

;Cikarma Islemi
substraction:
mov dx, offset sub_title
mov ah, 09
int 21h 

;Ilk operand girisi
mov dx, offset get_value1 
mov ah, 09
int 21h
       
mov ah, 01h
int 21h 

mov op1, al 

;Ikinci operand girisi
mov dx, offset get_value2 
mov ah, 09
int 21h        
          
mov ah, 01h
int 21h  

mov op2, al      

;Sonucu yazdir
mov dx, offset ans  
mov ah, 09
int 21h   

mov al, op1
mov bl, op2

sub al, bl

aas
or ax, 3030h

mov ah, 0eh
int 10h

jmp exit  

;Carpma Islemi
multiplication:
mov dx, offset mul_title 
mov ah, 09
int 21h

;Ilk operand girisi
mov dx, offset get_value1 
mov ah, 09
int 21h        

mov ah, 01h
int 21h   

sub al, 30h
mov op1, al       

;Ikinci operand girisi
mov dx, offset get_value2 
mov ah, 09
int 21h   
       
mov ah, 01h
int 21h  

sub al, 30h
mov op2, al 

;Sonucu yazdir
mov dx, offset ans  
mov ah, 09
int 21h   

mov al, op1
mov bl, op2

mul bl
add al, 30h


mov ah, 0eh
int 10h
 
jmp exit 
    
;Bolme Islemi
division:
mov dx, offset div_title 
mov ah, 09
int 21h   

;Ilk operand girisi        
mov dx, offset get_value1 
mov ah, 09
int 21h  
       
mov ah, 01h
int 21h     

sub al, 30h
mov op1, al

;Ikinci operand girisi
mov dx, offset get_value2 
mov ah, 09
int 21h    
       
mov ah, 01h
int 21h          

sub al, 30h
mov op2, al  

;Sonucu yazdir
mov dx, offset ans  
mov ah, 09
int 21h 

mov ax, 0000h 

mov al, op1
mov bl, op2

div bl
add al, 30h  
           
mov ah, 0eh
int 10h
       
jmp exit

exit:

end  