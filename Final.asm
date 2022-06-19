; p_5 MACRO
;     mov si,offset registers
;     mov cx,64
; clr_r:
;     mov al,30h
;     mov [si],al
;     inc si
;     loop clr_r
;     mov ax,[offset score2]
;     sub ax,30
;     mov score2,ax
;     mov al,[clear_once]
;     dec al
;     mov clear_once,al 
; ENDM

p_p_up macro x,y 
    mov cx,x
    add cx,10
    mov dx,10
    add dx,y
jmp Starttodrawpixel
Drawpixel: 
        MOV AH,0Ch                
        mov al, [si]             
        MOV BH,00h     
        INT 10h  
Starttodrawpixel:  
        inc si
        DEC Cx
        cmp cx,x              
        JNZ Drawpixel   
        MOV CX, 10
        add CX,x

        DEC DX 
        cmp dx,y     
        jnz Drawpixel
endm

; checkValidity macro string,size,char,found 
;     local isFound
;     local notfound
;     mov cx,0
;     lea si,string
;     isFound: 
;         mov ax,[si]
;         cmp al,char
;         jne notfound
;         mov found,1
;     notfound:
;         inc cx
;         inc si
;         cmp cx,size
;         jne isFound
; endm    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

checkValidityforchar macro string,found   
    local loop1 
    local loop2
    local loop3
    local loop4
    local loop5
    cmp  string,65d
       jnc  loop2
       jc  loop1
       loop2:
        cmp string,91d
        jc loop3
        jnc loop4
       loop4:
        cmp string,97d
        jnc loop5
        jc loop1
       loop5:
        cmp string,123d
        jc loop3
        jnc loop1   
    
        loop1:
            mov found,1d
            
    loop3:     
endm     


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   

checkValidityforforbiddenchar macro string,found   
     local loop1 
    local loop2
    local loop3
    local loop4
    local loop5
    local loop11
    cmp  string,65d
       jnc  loop2
       jc  loop1
       loop2:
        cmp string,91d
        jc loop3
        jnc loop4
       loop4:
        cmp string,97d
        jnc loop5
        jc loop1
       loop5:
        cmp string,123d
        jc loop3
        jnc loop1   
    
        loop1: 
            cmp string,48d
            jc loop11
            cmp string,58d
            jc loop3
            loop11:
                 mov found,1d
            
    loop3:     
endm   


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
clearScreen macro
    mov ah,0
    mov al,3
    int 10h 
endm 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

convertLower macro name
            local loop1
            local loop2
            local equal
            local notequal 
            local exit
            mov bx,offset name   
         ;   mov cx,size        
            loop1:      
              ;    cmp cx,0h
                  cmp byte ptr [bx],36d  
                  je exit
                  cmp byte ptr [bx],61h
                  jl equal   
                  JG notequal 
                  je notequal
                
          equal:    
                   cmp byte ptr [bx],20h
                   je   notequal 
                   cmp byte ptr [bx],91d
                   je   notequal 
                   cmp byte ptr [bx],93d
                   je   notequal 
                   cmp byte ptr [bx],44d
                   je   notequal  
                   cmp byte ptr [bx],36d
                   je notequal
                   cmp byte ptr [bx],58d
                   jc notequal
                   loop2: 
                       add byte ptr [bx],20h
                       ;mov dx,byte ptr[bx]
                       ;mov ah,02
                       ;int 21h
                       inc bx  
                     ;  dec cx
                       jmp loop1  
           
          notequal: 
                   ;mov dx,byte ptr[bx]
                   ;mov ah,02
                   ;int 21h
                   inc bx   
                 ;  dec cx         
                   jmp loop1
          
         
                
             jnz loop1 
         exit:
              
          endm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
   


getname macro name
        mov ah,0Ah
        mov dx,offset name-2
        int 21h 
endm     

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

getnum macro num
        mov ah,1
        int 21h         
        sub al,30h   
        mov cl,10
        mov ah,0
        mul cl
        mov bl,al
        mov ah,1
        int 21h         
        sub al,30h  
        add al,bl
        mov num,al
endm     

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

twobit macro num
    mov al,[num]
    mov ah,0
    mov bl,10
    div bl 
    add al,48
    mov dl,al
    push ax
    mov ah,2
    int 21h
    pop ax
    mov al,ah 
    add al,48   
    mov dl,al
    mov ah,2
    int 21h 
endm        

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

removeEnter macro name    ;when found = 1 nottrue command 
   local loop1
   local exit
   mov si,offset name
   loop1:
   cmp byte ptr [si],13d
   je exit
   inc si
   jmp loop1
    
  exit:
   mov byte ptr [si],36d 
   endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
convString2 macro num,string    ;when found = 1 nottrue command 
    local exit
    mov al,num 
    mov ah,0 
    mov bl,10d
    div bl
    add al,30h
    mov string[0],al
    add ah,30h
    mov string[1],ah
   
  exit: 
   endm 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

convString4 macro num,string    ;when found = 1 nottrue command 
    local exit 
    local cont1  
    local cont2
    local cont3
    local cont4
    local cont5
    local cont6
    local cont7
    local cont8  
    
    
    mov ax,num
    mov dx,0
    mov bx,1000h
    div bx
    cmp al,10d
    jnc cont1  
    add al,30h
    jmp cont5
    cont1:
    add al,37h 
    cont5:
    mov byte ptr string[0],al
    mov ax,dx 
    mov dx,0
    mov bx,100h
    div bx 
    cmp al,10d
    jnc cont2
    add al,30h 
    jmp cont6
    cont2:
    add al,37h
    cont6:
    mov byte ptr string[1],al
    mov ax,dx
    mov dx,0
    mov bx,10h
    div bx
    cmp al,10d
    jnc cont3
    add al,30h 
    jmp cont7
    cont3:
    add al,37h
    cont7:
    mov byte ptr string[2],al
    mov ax,dx
    mov dx,0 
    cmp al,10d
    jnc cont4
    add al,30h
    jmp cont8
    cont4:   
    add al,37h
    cont8:
    mov byte ptr string[3],al
   
  exit: 
   endm 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
convString2h macro num,string    ;when found = 1 nottrue command 
    local exit
    local cont1
    local cont2
    local cont3
    local cont4
    local cont5
    mov al,num 
    mov ah,0 
    mov bl,10h
    div bl 
    cmp al,10d
    jnc cont1  
    add al,30h
    jmp cont5
    cont1:
    add al,37h 
    cont5:
   ; add al,30h
    mov string[0],al 
    cmp ah,10d
    jnc cont2
    add ah,30h
    jmp cont3
    cont2:
    add ah,37h  
    cont3:
    mov string[1],ah
   
  exit: 
   endm 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

checkValidity macro string,char,found 
    local isFound
    local notfound
    local exit
   ; mov cx,0
   mov found,0
    lea si,string
    isFound: 
        mov al,byte ptr [si]
        cmp byte ptr [si],36d
        je exit
        cmp al,char
        jne notfound
        mov found,1
    notfound:
     ;   inc cx
        inc si
    ;    cmp cx,size
        jmp isFound
 exit:       
endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

drawlinehor macro begin,colour,count
mov di,begin
mov al,colour
mov cx,count
rep stosb
endm drawlinehor
drawlabel macro
 local allbig
 local all
 local signglestep
 mov colour,12
mov count,2
mov bx,0
mov col,0d 
mov si,offset labels
mov begin,0
allbig:
push bx
mov dx,0
mov row,3d
all:
push dx           
drawstring col,row,count,labels,colour ,begin
add begin,2
pop dx
inc dx
add row,3
sub col,2
cmp dx,4
jne all
pop bx
inc bx
cmp bx,2
jne signglestep
add col,8
signglestep:  
add col, 8
cmp bx,4
jne allbig
endm drawlabel
updatereg macro  
 local allbig
 local all
 local signglestep
 mov colour,43
mov count,4
mov bx,0
mov col,3d 
mov si,offset registers 
mov begin,0
allbig:
push bx
mov dx,0
mov row,3d
all:
push dx           
drawstring col,row,count,registers,colour ,begin
add begin,4
pop dx
inc dx
add row,3
sub col,4
cmp dx,4
jne all
pop bx
inc bx
cmp bx,2
jne signglestep
add col,8
signglestep:  
add col, 8
cmp bx,4
jne allbig
 endm updatereg
drawlinevert macro col,row,colour,count
local back
mov cx,col ;Column
mov dx,row ;Row
mov al,colour ;Pixel color
mov ah,0ch ;Draw Pixel Command
back: int 10h
inc dx
cmp dx,count
jnz back
endm drawlinevert
setcursor macro col,row
mov ah,02h  
mov dh, row    ;row 
mov dl, col     ;column
int 10h
endm setcursor
drawchar macro colour,count,char
mov ah,09h
mov bl,colour  ;colour
mov cx,count     ;no.of times
mov al,char      ;print B
int 10h  
endm drawchar
updatememo1 macro
local theloop
mov ax,16d
mov row,3
mov col,18
mov begin,0
mov count,2
theloop:
push ax
drawstring col,row,count,memo1,colour,begin
pop ax
inc row
mov col,18
add begin,2
dec ax
cmp ax,0
ja theloop

endm updatememo1
updatememo2 macro
local theloop
mov ax,16d
mov row,3
mov col,21
mov begin,0
mov count,2
theloop:
push ax
drawstring col,row,count,memo2,colour,begin
pop ax
inc row
mov col,21
add begin,2
dec ax
cmp ax,0
ja theloop

endm updatememo2
drawrectangle macro 
setcursor col,row
mov ah,9 ;Display
mov bh,0 ;Page 0
mov al,0 ;Letter D
mov cx,10h ;5 times
mov bl,00h ;Green (A) on white(F) background
int 10h
endm drawrectangle
updatescore1 macro
mov col,18
mov row ,20
mov begin,0
mov colour,67h
drawstring col,row,count,score1,colour,begin
endm updatescore1
updatescore2 macro
mov col,21
mov row ,20
mov begin,0
drawstring col,row,count,score2,colour,begin
endm updatescore2
drawstring macro col,row,count,mes,colour,begin
local todraw
local toend
mov si,0
mov di,offset mes
mov ax,begin
add di,ax
todraw:
mov dl,[di]
cmp dl,'$'
je toend
cmp dl,13
je toend
setcursor col,row
drawchar colour,1,[di]
inc di
inc col
inc si
cmp si,count
jb todraw
toend:
endm drawstring
updateall macro
local levelhidefch
mov col,0
mov row,19d
drawrectangle

mov row,0
inc col
mov chr,'0'
mov count ,10h
mov colour,38h


 
updatereg
drawlabel
mov begin,0
mov col,18
mov row ,19
mov count,5
drawstring col,row,count,mes,colour,begin
updatescore1
updatescore2
mov col,4
mov row,17
mov begin,0
drawstring col,row,20,firstname,colour,begin
mov col,30
mov row,17
mov begin,0
drawstring col,row,20,secondname,colour,begin

setcursor 18,21

drawchar 04h,5,'X'
cmp level,50
je levelhidefch
setcursor 19,22
drawchar colour,1,forbiddenchar2
setcursor 22,22
drawchar colour,1,forbiddenchar1
levelhidefch:
updatememo1
updatememo2
drawlinevert 159,20,198,152
drawlinevert 167,20,198,152
call print_error
mov error,0
;call shootgame
;call iswinner
endm updateall
displaycommand macro switch
local thesec
mov al,switch
mov col,0
mov row,19d
cmp al,0ffh
jne thesec
add col,23
thesec:
drawrectangle 
setcursor col,row
mov ah,0AH
mov dx,offset command-2
int 21h
endm displaycommand
 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;org 100h
.MODEL LARGE 


.stack 64
.data

send_chat_invitation db 'You sent a chat invitation to ','$'
send_game_invitation db 'You sent a game invitation to ','$'
recieve_chat_invitation db 'sent you a chat invitation, to accept press F1','$'
recieve_game_invitation db 'sent you a game invitation, to accept press F2','$'

char db '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','$'
mes db 'score','$'
score1 db '00','$'
score2 db '00','$'
forbidden1 db '!','$'
forbidden2 db '!','$'
;;;;;;;;;;;;;;;[0];;;;[1];;;;[2];;;;[3];;;;[4];;;;[5];;;;[6];;;[7];;;;;[8];;;[9];;;;[10];;;[11];;;[12];;;[13];;;[14];;;[15]
registers db '0000','0000','0000','0000','0000','0000','0000','0000','0000','0000','0000','0000','0000','0000','0000','0000','$'
lev2_registers db 64 dup('0'),'$'
labels db 'AX','BX','CX','DX','SI','DI','SP','BP','AX','BX','CX','DX','SI','DI','SP','BP','$'
memo1 db '00','00','00','00','00','00','22','00','00','00','00','00','00','00','00','00','00','$'
memo2 db '00','00','00','00','00','00','00','00','00','00','00','00','00','00','00','00','00','$'
name1 db 'PLAYER1','$'
name2 db 'PLAYER2','$'


msg1 db "For Player 1 Please Enter Your Name :$"  
msg12 db "For Player 2 Please Enter Your Name :$"


msg2 db "For player 1 Initial Points :$" 

msg13 db "For player 2 Initial Points :$" 
 

msg3 db "To start chatting press F1 :$"

msg4 db "To start game press F2 :$"

msg5 db "To end the program press ESC :$"

msg6 db "Press enter key to continue :$"

msg7 db "-$"

msg8 db "Entered chatting mode :$"

msg9 db "Entered game mode :$"

msg10 db ":$"

msg11 db "Press F3 to end the chat with $" 

msg14 db "For player 1 choose level :$" 

msg15 db "For Level One Enter 1 $" 

msg16 db "For Level Two Enter 2 $" 

msg17 db "Entered level two $"  

msg18 db "For player 1 choose forbidden char :$"

msg19 db "For player 2 choose forbidden char :$"

msg20 db "The winner is : $"

error1     db 'Size Mismatch','$'
error2     db 'Memory to Memory Operation','$'
error3     db 'Invalid register name','$'
error4     db 'Incorrect Addressing Mode','$'
msgendsrdata db 'End Send & Recieve','$'
reg_labels db ' AX : ',' BX : ',' CX : ',' DX : ',' SI : ',' DI : ',' SP : ',' BP : ','$'
; ah_l db ?,'ah','$'
level_str db 2 dup('$'),'$'
col1 db 0
row1 db 0
col2 db 0
row2 db 12d

      flying_value dw  ?

      shoot_level db  1


my_chat_inv db 0
your_chat_inv db 0
my_game_inv db 0
your_game_inv db 0

bool_x db 0
      bool_y db 0

game_count db 4

p1_img DB 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 16, 16, 16, 5, 5, 5, 5, 5, 5, 5, 5, 16, 5, 5, 5, 5, 5
 DB 5, 5, 5, 5, 16, 5, 5, 5, 5, 5, 5, 5, 5, 5, 16, 5, 5, 5, 5, 5, 5, 5, 5, 5, 16, 5, 16, 5, 5, 5, 5, 5, 5, 5, 16, 16, 16, 5, 5, 5
 DB 5, 5, 5, 5, 16, 16, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
p2_img DB 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 16, 16, 16, 16, 40, 40, 40
 DB 40, 40, 40, 40, 40, 40, 16, 40, 40, 40, 40, 40, 40, 16, 16, 16, 16, 40, 40, 40, 40, 40, 40, 16, 40, 40, 40, 40, 40, 40, 40, 40, 40, 16, 16, 16, 16, 40, 40, 40
 DB 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40
p3_img DB 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 16, 16, 16, 47, 47, 47
 DB 47, 47, 47, 47, 16, 47, 47, 47, 47, 47, 47, 47, 47, 47, 16, 16, 16, 47, 47, 47, 47, 47, 47, 47, 16, 47, 47, 47, 47, 47, 47, 47, 47, 47, 16, 16, 16, 47, 47, 47
 DB 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47
p4_img DB 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 16, 55, 55, 55, 55, 55, 55, 55, 55, 55, 16, 55, 55, 55, 55, 55, 55
 DB 55, 55, 55, 16, 55, 55, 55, 55, 55, 55, 55, 55, 55, 16, 16, 16, 16, 55, 55, 55, 55, 55, 55, 16, 55, 55, 16, 55, 55, 55, 55, 55, 55, 16, 55, 55, 16, 55, 55, 55
 DB 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55
p5_img DB 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 16, 16, 16, 16, 44, 44, 44, 44, 44, 44, 16, 44, 44, 16, 44, 44, 44
 DB 44, 44, 44, 16, 44, 44, 44, 44, 44, 44, 44, 44, 44, 16, 16, 16, 16, 44, 44, 44, 44, 44, 44, 44, 44, 44, 16, 44, 44, 44, 44, 44, 44, 16, 16, 16, 16, 44, 44, 44
 DB 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44
 p_up_x dw 2
 p_up_y dw 175
target_value dw 105eh
desired db '105e'
 img_sizeX  equ 10
      img_sizeY  equ 10
      initial_x dw 0020h
      initial_y dw 0010h
      multiplier dw  0003h
      gun_sizeX  equ 10
      gun_sizeY  equ 10
      y     dw  130                                                                
      x     dw  2
      value_g dw  ?
      run   dw  1
      level db  '1','$'
      msg_hits db 'no.hits : ','$'
      g_img DB  31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 47, 47, 47, 47, 31, 31, 31, 31, 47, 47, 47, 47, 47, 47, 47, 47, 31, 31, 47, 47, 47, 16, 16, 16, 47, 47, 31
            DB  47, 47, 47, 47, 16, 47, 47, 47, 47, 47, 47, 47, 47, 47, 16, 16, 16, 47, 47, 47, 47, 47, 47, 47, 16, 47, 47, 47, 47, 47, 31, 47, 47, 47, 16, 16, 16, 47, 47, 31
            DB  31, 31, 31, 47, 47, 47, 47, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31
      b_img DB  31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 55, 55, 55, 55, 31, 31, 31, 31, 55, 55, 16, 55, 55, 55, 55, 55, 31, 31, 55, 55, 16, 55, 55, 55, 55, 55, 31
            DB  55, 55, 55, 16, 55, 55, 55, 55, 55, 55, 55, 55, 55, 16, 16, 16, 16, 55, 55, 55, 55, 55, 55, 16, 55, 55, 16, 55, 55, 55, 31, 55, 55, 16, 55, 55, 16, 55, 55, 31
            DB  31, 31, 31, 55, 55, 55, 55, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31
      y_img DB  31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 44, 44, 44, 44, 31, 31, 31, 31, 44, 44, 16, 16, 16, 16, 44, 44, 31, 31, 44, 44, 16, 44, 44, 16, 44, 44, 31
            DB  44, 44, 44, 16, 44, 44, 44, 44, 44, 44, 44, 44, 44, 16, 16, 16, 16, 44, 44, 44, 44, 44, 44, 44, 44, 44, 16, 44, 44, 44, 31, 44, 44, 16, 16, 16, 16, 44, 44, 31
            DB  31, 31, 31, 44, 44, 44, 44, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31
      r_img DB  31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 40, 40, 40, 40, 31, 31, 31, 31, 40, 40, 16, 40, 40, 40, 40, 40, 31, 31, 40, 40, 16, 40, 40, 40, 40, 40, 31
            DB  40, 40, 40, 16, 40, 40, 40, 40, 40, 40, 40, 40, 16, 16, 16, 16, 40, 40, 40, 40, 40, 40, 40, 16, 40, 40, 40, 40, 40, 40, 31, 40, 40, 16, 16, 16, 16, 40, 40, 31
            DB  31, 31, 31, 40, 40, 40, 40, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31
            
      gun_img DB 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 42, 42, 42, 42, 31, 31, 31, 31, 31, 42, 31, 31, 31, 31, 42, 31, 31
              DB 31, 31, 42, 31, 42, 42, 31, 42, 31, 31, 31, 31, 42, 31, 42, 42, 31, 42, 31, 31, 31, 31, 42, 31, 31, 31, 31, 42, 31, 31, 31, 31, 31, 42, 42, 42, 42, 31, 31, 31 
              DB 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31

        x_gun dw 160
        y_gun dw 100
      count1 dw 0ffffh
      count2 dw 0008h
changeforbidenchar1 db 1
changeforbidenchar2 db 1

incialscore db 0

incialscore2 db 0 

finalincialscore db 0

found db 0 ;the forbiden char 

test_str db "and bx, 75$"  
error db "0"
temp_forbiden_char db '%','$'
    
 sendPos dw 0000d
 recPos dw 1200d
begin dw 0
switch db 0
tem1 db 0
tem2 db 0
p1_active db 0

return_value db 0
fsi db 0
ssi db 0
gaya db 0
toesc db 0
 ;rax dd '1234','$'
; rbx dd '1030'
; rcx dd '5000'
; rdx dd '0600'
; rsi dd '0204'
; rdi dd '0990'
; rsp dd '0500'
; rbp dd '0320'



db 16,?
command db 17 DUP('$') 

db 16,?
temp_command db 17 DUP('$') 


; name db 30 dup('$')
; comm db 30,?,30 dup('$')
count dw ?
colour db ?
col db ?
row db ?
chr db ?
theval dd ?

    clear_once_p1     db 1
    clear_once_p2     db 1


;;;;;;;;;;;;;;;;;;;;;;
    db 16,?
firstname db 17 DUP('$')  

   db 16,?
secondname db 17 DUP('$')

forbiddenchar1 db ? 

forbiddenchar2 db ?

 msg db ?
 val db ?

 winningreg dw 105eh
;;;;;;;;;;;;;;;;;;;;;;


cur_inst db ?
cur_par1 db ?
cur_isval db 0
cur_par2 db ?
value db ?
value2 dw ?
isEight db ?
par1 db ?
par2 db ?
par3 dw ?
par4 dw ?
wheretoexecute db 31h
temp_wheretoexecute db 31h


extra_power_chance db 1

temp_level db '1','$'


;new_targetvalue db 6,?,6 dup('$'')
temp_col db ?
ax_user dw ?
c_user db ?
bg    db  100 dup(?)

.code

print_error proc
mov col,0
mov row,24
drawlinehor 60800,198,3200
mov al,[error]
;sub al,30h
cmp al,0
jne e112345
jmp far ptr end_up_p12345
e112345:
setcursor 0,24
cmp al,1
jne e212345 
mov dx,offset error1
jmp far ptr p_error
e212345:
cmp al,2
jne e312345
mov dx,offset error2
jmp far ptr p_error
e312345:
cmp al,3
jne e412345
mov dx,offset error3
jmp far ptr p_error
e412345:
cmp al,4
jne end_up_p12345
mov dx,offset error4
p_error:
mov ah,9
int 21h
end_up_p12345:
ret
print_error endp

; convert_str_num proc
;     mov di,4
;     mov cx,0
;     mov bx,1000h
    ;mov si,offset registers
; convertreg:
;     mov ax,0
;     mov al,[si]
;     sub al,30h
;     mul bx
;     add cx,ax
;     mov al,4
;     ror bx,al
;     inc si 
;     dec di
;     jnz convertreg  
;     ret      
; convert_str_num endp 
; iswinner proc
;     mov ax,[target_value]
;     mov bx,16 
;     mov si,offset registers  
;     ;inc si
; lp_iswin:
;     push bx
;     push ax
;     call convert_str_num
;     pop ax
;     pop bx
;     cmp ax,cx
;     ;jz                ;Winner
;     dec bx
;     jnz lp_iswin
; end_lp_r:      
;     ret
; iswinner endp 



; shootgame proc 
;             ;    mov ax, @data
;             ;    mov DS, ax
;             ;    mov ax,0A000h
;             ;    mov es,ax
;             ;    mov ah,0                  ;Graphic Mode
;             ;    mov al,13h
;             ;    int 10h
;                mov ax, 0000h             ; reset mouse
;                int 33h
;       beginmain:
;                mov ax, 0001h             ; show mouse
;                int 33h
;                mov ax,initial_x
;                mul [multiplier]
;                add ax,100
;                mov initial_x,ax
;                mov x,ax
;                mov multiplier,ax
;                cmp ax,305
;                jbe init_y
;       dec_ix:  sub ax,350
;                cmp ax,305
;                ja dec_ix
;                mov initial_x,ax
;                mov x,ax
;       init_y:  mov ax,initial_y
;                mul [multiplier]
;                add ax,100
;                mov initial_y,ax
;                mov y,ax
;                mov dx,ax
;                add dx,200
;                add dx,[multiplier]
;                mov multiplier,dx
;                cmp ax,185
;                jbe stgame
;       dec_iy:  sub ax,240
;                cmp ax,185
;                ja dec_iy
;                mov initial_y,ax 
;                mov y,ax
;       stgame:
;                mov run,1
;             ;    mov di,0
;             ;    mov al,0eh                ;yellow
;             ;    mov cx,0fa00h
;             ;    Rep stosb
;                mov al,level
;                cmp al,1
;                jnz st2
;                mov value_g,3
;                jmp initial
;       st2:     cmp al,2
;                jnz st3
;                mov value_g,4
;                jmp initial
;       st3:     cmp al,3
;                jnz st4
;                mov value_g,5
;                jmp initial
;       st4:     mov value_g,7
;                jmp initial
;       initial:
;                mov ax,[initial_x]
;                cmp ax,160
;                ja decx
;                mov ax,[x]
;                add ax,10                 ;steps
;                cmp ax,305
;                jae ENDING1
;                mov x,ax
;                jmp p_y
;       decx:    mov ax,[x]
;                sub ax,10                 ;steps
;                cmp ax,15
;                jbe ENDING1
;                mov x,ax
;       p_y:     mov ax,[initial_y]
;                cmp ax,100
;                ja decy
;                mov ax,[y]
;                add ax,5                 ;steps
;                cmp ax,185
;                jae ENDING1
;                mov y,ax
;                jmp p_img 
;       decy:    mov ax,[y]
;                sub ax,5                  ;steps
;                cmp ax,15
;                jbe ENDING1
;                mov y,ax
;       p_img:   MOV CX, img_sizeX
;                add CX, [x]
;                MOV DX, img_sizeY
;                add dx, [y]
;                mov al,level
;                cmp al,1
;                jnz l2
;                mov DI, offset g_img
;                mov si, offset bg
;                jmp Start
;       l2:      cmp al,2
;                jnz l3
;                mov DI, offset b_img
;                mov si, offset bg
;                jmp Start
;       l3:      cmp al,3
;                jnz l4
;                mov DI, offset y_img
;                mov si, offset bg
;                jmp Start
;       l4:      mov DI, offset r_img
;                mov si, offset bg
;                jmp Start
;       ENDING1: mov run,0
;                MOV CX, img_sizeX
;                add CX, [x]
;                MOV DX, img_sizeY
;                add dx, [y]
;                mov DI, offset bg
;                jmp Start1
      
;       chk1:                         
;                mov ax,3
;                int 33h
;                shr cx,1
;                cmp cx,[x]
;                jnc  k
;                jmp return
;       k:       mov ax,[x]
;                add ax,15
;                cmp cx,ax
;                jc con_1
;                jmp return
;       con_1:
;                cmp dx,[y]
;                jnc con_2
;                jmp return
;       con_2:
;                mov ax,[y]
;                add ax,15
;                cmp dx,ax
;                jnc return
;                mov ax,[value_g]
;                dec ax
;                cmp ax,1
;                jc  ENDING1
;                mov value_g,ax
;                   ; mov		ax, 0000h
;                   ; mov		es, ax
;                   ; mov		es:[041ah], 041eh
;                   ; mov		es:[041ch], 041eh				; Clears keyboard buffer
;                   ; pop		es
;                   ; pop		ax
;                jmp return
;       initial1:
;                jmp initial

;       Drawit:  
;       ;take background pixel color before drawing
;               mov ax,0002h
;                int 33h
;                mov ah,0Dh
;                mov bh,0
;                int 10h
;                mov bx,sI
;                mov [bx],al
;                mov ax,0001h
;                int 33h
               
;       ; draw
;                MOV AH,0Ch          
;                mov al, [DI]       
;                cmp al,31  
;                jz  Start
;                MOV BH,00h  
;                INT 10h  
               
;       Start:   
;                inc si
;                inc DI
;                DEC Cx               
;                cmp cx,[x]
;                JNZ Drawit   
;                MOV CX, img_sizeX
;                add CX, [x]
       
;                DEC DX 
;                cmp dx,[y]
;                jnz Drawit

;       ;loop for delay
;                mov di,0008h
;                mov cx,0ffffh
;       delayloop:     
;                dec cx
;                jnz delayloop
;                mov cx,0ffffh
;                dec di
;                jnz delayloop
               
;                ;get keypress
;                mov ah,1
;                int 16h
;                cmp al,20h
;                jnz  return
;                jmp chk1
;       return:      
;                ;to draw background
;                MOV CX, img_sizeX  
;                add CX, [x]
;                MOV DX, img_sizeY
;                add dx, [y]
;                mov si, offset bg
;                jmp Start1
               
;       Drawit1:
;                mov ax,0002h
;                int 33h
;                MOV AH,0Ch                
;                mov al, [si]             
;                cmp al,31    
;                jz  Start
;                MOV BH,00h     
;                INT 10h  
;                mov ax,0001h
;                int 33h
;       Start1:  
;                inc si
;                DEC Cx              
;                cmp cx,[x]
;                JNZ Drawit1   
;                MOV CX, img_sizeX
;                add CX, [x]
       
;                DEC DX      
;                cmp dx,[y]
;                jnz Drawit1
;                mov ax,run
;                cmp ax,0
;                jz  ENDING

;                jmp initial1

;       ENDING:  
;                inc level
;                jmp beginmain
;                hlt
; ret
; endp shootgame

; print_error proc
; mov al,[error]
; sub al,30h
; cmp al,0
; jz end_up_p
; setcursor 0,24
; cmp al,1
; jne e2 
; mov dx,offset error1
; jmp p_error
; e2:
; cmp al,2
; jne e3
; mov dx,offset error2
; jmp p_error
; e3:
; cmp al,3
; jne e4
; mov dx,offset error3
; jmp p_error
; e4:
; cmp al,4
; jne end_up_p
; mov dx,offset error4
; p_error:
; mov ah,9
; int 21h
; end_up_p:
; ret
; endp print_error

setpar proc

    push dx
    push bx
    push cx
    cmp  switch, 0FFH
    jz setparfirst
    jmp setparsecond



    setparfirst:
            cmp cur_par1, 1
            jne setpar_con
            mov bx, offset registers[0*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con:
            cmp cur_par1, 2
            jne setpar_con1
            mov bx, offset registers[1*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con1:
            cmp cur_par1, 3
            jne setpar_con2
            mov bx, offset registers[2*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con2:
            cmp cur_par1, 4
            jne setpar_con3
            mov bx, offset registers[3*2]
            call getValueOfString
            mov par1, dl
        setpar_con3:
            cmp cur_par1, 5
            jne setpar_con4
            mov bx, offset registers[4*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con4:
            cmp cur_par1, 6
            jne setpar_con5
            mov bx, offset registers[5*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con5:
            cmp cur_par1, 7
            jne setpar_con6
            mov bx, offset registers[6*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con6:
            cmp cur_par1, 8
            jne setpar_con7
            mov bx, offset registers[7*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con7:
            cmp cur_par1, 9
            jne setpar_con8
            mov bx, offset registers[0*2]
            mov cx, 4
            call getValueOfString
            mov par3, dx
        setpar_con8:
            cmp cur_par1, 10
            jne setpar_con9
            mov bx, offset registers[2*2]
            mov cx, 4
            call getValueOfString
            mov par3, dx
        setpar_con9:
            cmp cur_par1, 11
            jne setpar_con10
            mov bx, offset registers[4*2]
            mov cx, 4
            call getValueOfString
            mov par3, dx
        setpar_con10:
            cmp cur_par1, 12
            jne setpar_con11
            mov bx, offset registers[6*2]
            mov cx, 4
            call getValueOfString
            mov par3, dx
        setpar_con11:
            cmp cur_par1, 13
            jne setpar_con12
            mov bx, offset registers[8*2]
            mov cx, 4
            call getValueOfString
            mov par3, dx
        setpar_con12:
            cmp cur_par1, 14
            jne setpar_con13
            mov bx, offset registers[10*2]
            mov cx, 4
            call getValueOfString
            mov par3, dx
        setpar_con13:
            cmp cur_par1, 15
            jne setpar_con14
            mov bx, offset registers[12*2]
            mov cx, 4
            call getValueOfString
            mov par3, dx
        setpar_con14:
            cmp cur_par1, 16
            jne setpar_con15
            mov bx, offset registers[14*2]
            mov cx, 4
            call getValueOfString
            mov par3, dx
        setpar_con15:
            cmp cur_par1, 17
            jne setpar_con16
            mov bx, offset registers[2*2]
            mov cx, 4
            call getValueOfString
            mov bx, offset memo1[0*2]
            add bx, dx
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con16:
            cmp cur_par1, 18
            jne setpar_con17
            mov bx, offset registers[10*2]
            mov cx, 4
            call getValueOfString
            mov bx, offset memo1[0*2]
            add bx, dx
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con17:
            cmp cur_par1, 19
            jne setpar_con18
            mov bx, offset registers[8*2]
            mov cx, 4
            call getValueOfString
            mov bx, offset memo1[0*2]
            add bx, dx
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con18:
            cmp cur_par1, 20
            jne setpar_con19
            mov bx, offset memo1[0*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con19:
            cmp cur_par1, 21
            jne setpar_con20
            mov bx, offset memo1[1*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con20:
            cmp cur_par1, 22
            jne setpar_con21
            mov bx, offset memo1[2*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con21:
            cmp cur_par1, 23
            jne setpar_con22
            mov bx, offset memo1[3*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con22:
            cmp cur_par1, 24
            jne setpar_con23
            mov bx, offset memo1[4*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con23:
            cmp cur_par1, 25
            jne setpar_con24
            mov bx, offset memo1[5*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con24:
            cmp cur_par1, 26
            jne setpar_con25
            mov bx, offset memo1[6*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con25:
            cmp cur_par1, 27
            jne setpar_con26
            mov bx, offset memo1[7*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con26:
            cmp cur_par1, 28
            jne setpar_con27
            mov bx, offset memo1[8*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con27:
            cmp cur_par1, 29
            jne setpar_con28
            mov bx, offset memo1[9*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con28:
            cmp cur_par1, 30
            jne setpar_con29
            mov bx, offset memo1[10*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con29:
            cmp cur_par1, 31
            jne setpar_con30
            mov bx, offset memo1[11*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con30:
            cmp cur_par1, 32
            jne setpar_con31
            mov bx, offset memo1[12*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con31:
            cmp cur_par1, 33
            jne setpar_con32
            mov bx, offset memo1[13*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con32:
            cmp cur_par1, 34
            jne setpar_con33
            mov bx, offset memo1[14*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con33:
            cmp cur_par1, 35
            jne setpar_con34
            mov bx, offset memo1[15*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar_con34:

        cmp cur_isval,1d
        jnz skip_setpar_con
        jmp finishsetpar
        skip_setpar_con:

            cmp cur_par2, 1
            jne setpar_2con
            mov bx, offset registers[0*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con:
            cmp cur_par2, 2
            jne setpar_2con1
            mov bx, offset registers[1*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con1:
            cmp cur_par2, 3
            jne setpar_2con2
            mov bx, offset registers[2*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con2:
            cmp cur_par2, 4
            jne setpar_2con3
            mov bx, offset registers[3*2]
            call getValueOfString
            mov par2, dl
        setpar_2con3:
            cmp cur_par2, 5
            jne setpar_2con4
            mov bx, offset registers[4*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con4:
            cmp cur_par2, 6
            jne setpar_2con5
            mov bx, offset registers[5*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con5:
            cmp cur_par2, 7
            jne setpar_2con6
            mov bx, offset registers[6*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con6:
            cmp cur_par2, 8
            jne setpar_2con7
            mov bx, offset registers[7*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con7:
            cmp cur_par2, 9
            jne setpar_2con8
            mov bx, offset registers[0*2]
            mov cx, 4
            call getValueOfString
            mov par4, dx
        setpar_2con8:
            cmp cur_par2, 10
            jne setpar_2con9
            mov bx, offset registers[2*2]
            mov cx, 4
            call getValueOfString
            mov par4, dx
        setpar_2con9:
            cmp cur_par2, 11
            jne setpar_2con10
            mov bx, offset registers[4*2]
            mov cx, 4
            call getValueOfString
            mov par4, dx
        setpar_2con10:
            cmp cur_par2, 12
            jne setpar_2con11
            mov bx, offset registers[6*2]
            mov cx, 4
            call getValueOfString
            mov par4, dx
        setpar_2con11:
            cmp cur_par2, 13
            jne setpar_2con12
            mov bx, offset registers[8*2]
            mov cx, 4
            call getValueOfString
            mov par4, dx
        setpar_2con12:
            cmp cur_par2, 14
            jne setpar_2con13
            mov bx, offset registers[10*2]
            mov cx, 4
            call getValueOfString
            mov par4, dx
        setpar_2con13:
            cmp cur_par2, 15
            jne setpar_2con14
            mov bx, offset registers[12*2]
            mov cx, 4
            call getValueOfString
            mov par4, dx
        setpar_2con14:
            cmp cur_par2, 16
            jne setpar_2con15
            mov bx, offset registers[14*2]
            mov cx, 4
            call getValueOfString
            mov par4, dx
        setpar_2con15:
            cmp cur_par2, 17
            jne setpar_2con16
            mov bx, offset registers[2*2]
            mov cx, 4
            call getValueOfString
            mov bx, offset memo1[0*2]
            add bx, dx
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con16:
            cmp cur_par2, 18
            jne setpar_2con17
            mov bx, offset registers[10*2]
            mov cx, 4
            call getValueOfString
            mov bx, offset memo1[0*2]
            add bx, dx
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con17:
            cmp cur_par2, 19
            jne setpar_2con18
            mov bx, offset registers[8*2]
            mov cx, 4
            call getValueOfString
            mov bx, offset memo1[0*2]
            add bx, dx
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con18:
            cmp cur_par2, 20
            jne setpar_2con19
            mov bx, offset memo1[0*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con19:
            cmp cur_par2, 21
            jne setpar_2con20
            mov bx, offset memo1[1*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con20:
            cmp cur_par2, 22
            jne setpar_2con21
            mov bx, offset memo1[2*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con21:
            cmp cur_par2, 23
            jne setpar_2con22
            mov bx, offset memo1[3*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con22:
            cmp cur_par2, 24
            jne setpar_2con23
            mov bx, offset memo1[4*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con23:
            cmp cur_par2, 25
            jne setpar_2con24
            mov bx, offset memo1[5*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con24:
            cmp cur_par2, 26
            jne setpar_2con25
            mov bx, offset memo1[6*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con25:
            cmp cur_par2, 27
            jne setpar_2con26
            mov bx, offset memo1[7*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con26:
            cmp cur_par2, 28
            jne setpar_2con27
            mov bx, offset memo1[8*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con27:
            cmp cur_par2, 29
            jne setpar_2con28
            mov bx, offset memo1[9*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con28:
            cmp cur_par2, 30
            jne setpar_2con29
            mov bx, offset memo1[10*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con29:
            cmp cur_par2, 31
            jne setpar_2con30
            mov bx, offset memo1[11*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con30:
            cmp cur_par2, 32
            jne setpar_2con31
            mov bx, offset memo1[12*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con31:
            cmp cur_par2, 33
            jne setpar_2con32
            mov bx, offset memo1[13*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con32:
            cmp cur_par2, 34
            jne setpar_2con33
            mov bx, offset memo1[14*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con33:
            cmp cur_par2, 35
            jne setpar_2con34
            mov bx, offset memo1[15*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar_2con34:

        jmp finishsetpar
 
        setparsecond:
            cmp cur_par1, 1
            jne setpar2_con
            mov bx, offset registers[16*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con:
            cmp cur_par1, 2
            jne setpar2_con1
            mov bx, offset registers[17*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con1:
            cmp cur_par1, 3
            jne setpar2_con2
            mov bx, offset registers[18*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con2:
            cmp cur_par1, 4
            jne setpar2_con3
            mov bx, offset registers[19*2]
            call getValueOfString
            mov par1, dl
        setpar2_con3:
            cmp cur_par1, 5
            jne setpar2_con4
            mov bx, offset registers[20*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con4:
            cmp cur_par1, 6
            jne setpar2_con5
            mov bx, offset registers[21*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con5:
            cmp cur_par1, 7
            jne setpar2_con6
            mov bx, offset registers[22*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con6:
            cmp cur_par1, 8
            jne setpar2_con7
            mov bx, offset registers[23*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con7:
            cmp cur_par1, 9
            jne setpar2_con8
            mov bx, offset registers[16*2]
            mov cx, 4
            call getValueOfString
            mov par3, dx
        setpar2_con8:
            cmp cur_par1, 10
            jne setpar2_con9
            mov bx, offset registers[18*2]
            mov cx, 4
            call getValueOfString
            mov par3, dx
        setpar2_con9:
            cmp cur_par1, 11
            jne setpar2_con10
            mov bx, offset registers[20*2]
            mov cx, 4
            call getValueOfString
            mov par3, dx
        setpar2_con10:
            cmp cur_par1, 12
            jne setpar2_con11
            mov bx, offset registers[22*2]
            mov cx, 4
            call getValueOfString
            mov par3, dx
        setpar2_con11:
            cmp cur_par1, 13
            jne setpar2_con12
            mov bx, offset registers[24*2]
            mov cx, 4
            call getValueOfString
            mov par3, dx
        setpar2_con12:
            cmp cur_par1, 14
            jne setpar2_con13
            mov bx, offset registers[26*2]
            mov cx, 4
            call getValueOfString
            mov par3, dx
        setpar2_con13:
            cmp cur_par1, 15
            jne setpar2_con14
            mov bx, offset registers[28*2]
            mov cx, 4
            call getValueOfString
            mov par3, dx
        setpar2_con14:
            cmp cur_par1, 16
            jne setpar2_con15
            mov bx, offset registers[30*2]
            mov cx, 4
            call getValueOfString
            mov par3, dx
        setpar2_con15:
            cmp cur_par1, 17
            jne setpar2_con16
            mov bx, offset registers[18*2]
            mov cx, 4
            call getValueOfString
            mov bx, offset memo2[0*2]
            add bx, dx
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con16:
            cmp cur_par1, 18
            jne setpar2_con17
            mov bx, offset registers[26*2]
            mov cx, 4
            call getValueOfString
            mov bx, offset memo2[0*2]
            add bx, dx
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con17:
            cmp cur_par1, 19
            jne setpar2_con18
            mov bx, offset registers[24*2]
            mov cx, 4
            call getValueOfString
            mov bx, offset memo2[0*2]
            add bx, dx
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con18:
            cmp cur_par1, 20
            jne setpar2_con19
            mov bx, offset memo2[0*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con19:
            cmp cur_par1, 21
            jne setpar2_con20
            mov bx, offset memo2[1*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con20:
            cmp cur_par1, 22
            jne setpar2_con21
            mov bx, offset memo2[2*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con21:
            cmp cur_par1, 23
            jne setpar2_con22
            mov bx, offset memo2[3*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con22:
            cmp cur_par1, 24
            jne setpar2_con23
            mov bx, offset memo2[4*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con23:
            cmp cur_par1, 25
            jne setpar2_con24
            mov bx, offset memo2[5*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con24:
            cmp cur_par1, 26
            jne setpar2_con25
            mov bx, offset memo2[6*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con25:
            cmp cur_par1, 27
            jne setpar2_con26
            mov bx, offset memo2[7*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con26:
            cmp cur_par1, 28
            jne setpar2_con27
            mov bx, offset memo2[8*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con27:
            cmp cur_par1, 29
            jne setpar2_con28
            mov bx, offset memo2[9*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con28:
            cmp cur_par1, 30
            jne setpar2_con29
            mov bx, offset memo2[10*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con29:
            cmp cur_par1, 31
            jne setpar2_con30
            mov bx, offset memo2[11*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con30:
            cmp cur_par1, 32
            jne setpar2_con31
            mov bx, offset memo2[12*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con31:
            cmp cur_par1, 33
            jne setpar2_con32
            mov bx, offset memo2[13*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con32:
            cmp cur_par1, 34
            jne setpar2_con33
            mov bx, offset memo2[14*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con33:
            cmp cur_par1, 35
            jne setpar2_con34
            mov bx, offset memo2[15*2]
            mov cx, 2
            call getValueOfString
            mov par1, dl
        setpar2_con34:
        

        cmp cur_isval,1d
        jnz skip_setpar2_con
        jmp finishsetpar
        skip_setpar2_con:

            cmp cur_par2, 1
            jne setpar2_2con
            mov bx, offset registers[16*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con:
            cmp cur_par2, 2
            jne setpar2_2con1
            mov bx, offset registers[17*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con1:
            cmp cur_par2, 3
            jne setpar2_2con2
            mov bx, offset registers[18*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con2:
            cmp cur_par2, 4
            jne setpar2_2con3
            mov bx, offset registers[19*2]
            call getValueOfString
            mov par2, dl
        setpar2_2con3:
            cmp cur_par2, 5
            jne setpar2_2con4
            mov bx, offset registers[20*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con4:
            cmp cur_par2, 6
            jne setpar2_2con5
            mov bx, offset registers[21*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con5:
            cmp cur_par2, 7
            jne setpar2_2con6
            mov bx, offset registers[22*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con6:
            cmp cur_par2, 8
            jne setpar2_2con7
            mov bx, offset registers[23*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con7:
            cmp cur_par2, 9
            jne setpar2_2con8
            mov bx, offset registers[16*2]
            mov cx, 4
            call getValueOfString
            mov par4, dx
        setpar2_2con8:
            cmp cur_par2, 10
            jne setpar2_2con9
            mov bx, offset registers[18*2]
            mov cx, 4
            call getValueOfString
            mov par4, dx
        setpar2_2con9:
            cmp cur_par2, 11
            jne setpar2_2con10
            mov bx, offset registers[20*2]
            mov cx, 4
            call getValueOfString
            mov par4, dx
        setpar2_2con10:
            cmp cur_par2, 12
            jne setpar2_2con11
            mov bx, offset registers[22*2]
            mov cx, 4
            call getValueOfString
            mov par4, dx
        setpar2_2con11:
            cmp cur_par2, 13
            jne setpar2_2con12
            mov bx, offset registers[24*2]
            mov cx, 4
            call getValueOfString
            mov par4, dx
        setpar2_2con12:
            cmp cur_par2, 14
            jne setpar2_2con13
            mov bx, offset registers[26*2]
            mov cx, 4
            call getValueOfString
            mov par4, dx
        setpar2_2con13:
            cmp cur_par2, 15
            jne setpar2_2con14
            mov bx, offset registers[28*2]
            mov cx, 4
            call getValueOfString
            mov par4, dx
        setpar2_2con14:
            cmp cur_par2, 16
            jne setpar2_2con15
            mov bx, offset registers[30*2]
            mov cx, 4
            call getValueOfString
            mov par4, dx
        setpar2_2con15:
            cmp cur_par2, 17
            jne setpar2_2con16
            mov bx, offset registers[18*2]
            mov cx, 4
            call getValueOfString
            mov bx, offset memo2[0*2]
            add bx, dx
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con16:
            cmp cur_par2, 18
            jne setpar2_2con17
            mov bx, offset registers[26*2]
            mov cx, 4
            call getValueOfString
            mov bx, offset memo2[0*2]
            add bx, dx
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con17:
            cmp cur_par2, 19
            jne setpar2_2con18
            mov bx, offset registers[24*2]
            mov cx, 4
            call getValueOfString
            mov bx, offset memo2[0*2]
            add bx, dx
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con18:
            cmp cur_par2, 20
            jne setpar2_2con19
            mov bx, offset memo2[0*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con19:
            cmp cur_par2, 21
            jne setpar2_2con20
            mov bx, offset memo2[1*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con20:
            cmp cur_par2, 22
            jne setpar2_2con21
            mov bx, offset memo2[2*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con21:
            cmp cur_par2, 23
            jne setpar2_2con22
            mov bx, offset memo2[3*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con22:
            cmp cur_par2, 24
            jne setpar2_2con23
            mov bx, offset memo2[4*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con23:
            cmp cur_par2, 25
            jne setpar2_2con24
            mov bx, offset memo2[5*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con24:
            cmp cur_par2, 26
            jne setpar2_2con25
            mov bx, offset memo2[6*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con25:
            cmp cur_par2, 27
            jne setpar2_2con26
            mov bx, offset memo2[7*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con26:
            cmp cur_par2, 28
            jne setpar2_2con27
            mov bx, offset memo2[8*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con27:
            cmp cur_par2, 29
            jne setpar2_2con28
            mov bx, offset memo2[9*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con28:
            cmp cur_par2, 30
            jne setpar2_2con29
            mov bx, offset memo2[10*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con29:
            cmp cur_par2, 31
            jne setpar2_2con30
            mov bx, offset memo2[11*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con30:
            cmp cur_par2, 32
            jne setpar2_2con31
            mov bx, offset memo2[12*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con31:
            cmp cur_par2, 33
            jne setpar2_2con32
            mov bx, offset memo2[13*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con32:
            cmp cur_par2, 34
            jne setpar2_2con33
            mov bx, offset memo2[14*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con33:
            cmp cur_par2, 35
            jne setpar2_2con34
            mov bx, offset memo2[15*2]
            mov cx, 2
            call getValueOfString
            mov par2, dl
        setpar2_2con34: 
    finishsetpar:
pop cx
pop bx
pop dx
ret
setpar endp

getpar proc

    cmp switch, 0FFH
    jz getparfirst
    jmp getparsecond

    getparfirst:
        cmp cur_par1, 1
        jne getpar_con1
            convString2h par1, registers[0*2]
        getpar_con1:
        cmp cur_par1, 2
        jne getpar_con2
            convString2h par1, registers[1*2]
        getpar_con2:
        cmp cur_par1, 3
        jne getpar_con3
            convString2h par1, registers[2*2]
        getpar_con3:
        cmp cur_par1, 4
        jne getpar_con4
            convString2h par1, registers[3*2]
        getpar_con4:
        cmp cur_par1, 5
        jne getpar_con5
            convString2h par1, registers[4*2]
        getpar_con5:
        cmp cur_par1, 6
        jne getpar_con6
            convString2h par1, registers[5*2]
        getpar_con6:
        cmp cur_par1, 7
        jne getpar_con7
            convString2h par1, registers[6*2]
        getpar_con7:
        cmp cur_par1, 8
        jne getpar_con8
            convString2h par1, registers[7*2]
        getpar_con8:
        cmp cur_par1, 9
        jne getpar_con9
            convString4 par3, registers[0*2]
        getpar_con9:
        cmp cur_par1, 10
        jne getpar_con10
            convString4 par3, registers[2*2]
        getpar_con10:  
        cmp cur_par1, 11
        jne getpar_con11
            convString4 par3, registers[4*2]
        getpar_con11:  
        cmp cur_par1, 12
        jne getpar_con12
            convString4 par3, registers[6*2]
        getpar_con12:  
        cmp cur_par1, 13
        jne getpar_con13
            convString4 par3, registers[8*2]
        getpar_con13:  
        cmp cur_par1, 14
        jne getpar_con14
            convString4 par3, registers[10*2]
        getpar_con14:
        cmp cur_par1, 15
        jne getpar_con15
            convString4 par3, registers[12*2]
        getpar_con15:    
        cmp cur_par1, 16
        jne getpar_con16
            convString4 par3, registers[14*2]
        getpar_con16:    
        ; cmp cur_par1, 17
        ; jne getpar_con17
        ;     convString4 par3, registers[10*2]  
        ; getpar_con17:    
        ; cmp cur_par1, 18
        ; jne getpar_con18
        ;     convString4 par3, registers[10*2] 
        ; getpar_con18:    
        ; cmp cur_par1, 19
        ; jne getpar_con19
        ;     convString4 par3, registers[10*2] 
        getpar_con19:
        cmp cur_par1, 20
        jne getpar_con20
            convString2h par1, memo1[0*2]
        getpar_con20:
        cmp cur_par1, 21
        jne getpar_con21
            convString2h par1, memo1[1*2]
        getpar_con21:
        cmp cur_par1, 22
        jne getpar_con22
            convString2h par1, memo1[2*2]
        getpar_con22:
        cmp cur_par1, 23
        jne getpar_con23
            convString2h par1, memo1[3*2]
        getpar_con23:
        cmp cur_par1, 24
        jne getpar_con24
            convString2h par1, memo1[4*2]
        getpar_con24:
        cmp cur_par1, 25
        jne getpar_con25
            convString2h par1, memo1[5*2]
        getpar_con25:
        cmp cur_par1, 26
        jne getpar_con26
            convString2h par1, memo1[6*2]
        getpar_con26:
        cmp cur_par1, 27
        jne getpar_con27
            convString2h par1, memo1[7*2]
        getpar_con27:
        cmp cur_par1, 28
        jne getpar_con28
            convString2h par1, memo1[8*2]
        getpar_con28:
        cmp cur_par1, 29
        jne getpar_con29
            convString2h par1, memo1[9*2]
        getpar_con29:
        cmp cur_par1, 30
        jne getpar_con30
            convString2h par1, memo1[10*2]
        getpar_con30:
        cmp cur_par1, 31
        jne getpar_con31
            convString2h par1, memo1[11*2]
        getpar_con31:
        cmp cur_par1, 32
        jne getpar_con32
            convString2h par1, memo1[12*2] 
        getpar_con32:
        cmp cur_par1, 33
        jne getpar_con33
            convString2h par1, memo1[13*2]
        getpar_con33:
        cmp cur_par1, 34
        jne getpar_con34
            convString2h par1, memo1[14*2]
        getpar_con34:
        cmp cur_par1, 35
        jne getpar_con35
            convString2h par1, memo1[15*2]
        getpar_con35:
        cmp cur_par1, 36
        jne getpar_con36
            convString2h par1, memo1[16*2]
        getpar_con36:                                                               
        jmp exit_getpar

    getparsecond:
                cmp cur_par1, 1
        jne getpar_ccon1
            convString2h par1, registers[16*2]
        getpar_ccon1:
        cmp cur_par1, 2
        jne getpar_ccon2
            convString2h par1, registers[17*2]
        getpar_ccon2:
        cmp cur_par1, 3
        jne getpar_ccon3
            convString2h par1, registers[18*2]
        getpar_ccon3:
        cmp cur_par1, 4
        jne getpar_ccon4
            convString2h par1, registers[19*2]
        getpar_ccon4:
        cmp cur_par1, 5
        jne getpar_ccon5
            convString2h par1, registers[20*2]
        getpar_ccon5:
        cmp cur_par1, 6
        jne getpar_ccon6
            convString2h par1, registers[21*2]
        getpar_ccon6:
        cmp cur_par1, 7
        jne getpar_ccon7
            convString2h par1, registers[22*2]
        getpar_ccon7:
        cmp cur_par1, 8
        jne getpar_ccon8
            convString2h par1, registers[23*2]
        getpar_ccon8:
        cmp cur_par1, 9
        jne getpar_ccon9
            convString4 par3, registers[16*2]
        getpar_ccon9:
        cmp cur_par1, 10
        jne getpar_ccon10
            convString4 par3, registers[18*2]
        getpar_ccon10:  
        cmp cur_par1, 11
        jne getpar_ccon11
            convString4 par3, registers[20*2]
        getpar_ccon11:  
        cmp cur_par1, 12
        jne getpar_ccon12
            convString4 par3, registers[22*2]
        getpar_ccon12:  
        cmp cur_par1, 13
        jne getpar_ccon13
            convString4 par3, registers[24*2]
        getpar_ccon13:  
        cmp cur_par1, 14
        jne getpar_ccon14
            convString4 par3, registers[26*2]
        getpar_ccon14:
        cmp cur_par1, 15
        jne getpar_ccon15
            convString4 par3, registers[28*2]
        getpar_ccon15:    
        cmp cur_par1, 16
        jne getpar_ccon16
            convString4 par3, registers[30*2]
        getpar_ccon16:    
        ; cmp cur_par1, 17
        ; jne getpar_ccon17
        ;     convString4 par3, registers[10*2]  
        ; getpar_ccon17:    
        ; cmp cur_par1, 18
        ; jne getpar_ccon18
        ;     convString4 par3, registers[10*2] 
        ; getpar_ccon18:    
        ; cmp cur_par1, 19
        ; jne getpar_ccon19
        ;     convString4 par3, registers[10*2] 
        getpar_ccon19:
        cmp cur_par1, 20
        jne getpar_ccon20
            convString2h par1, memo2[0*2]
        getpar_ccon20:
        cmp cur_par1, 21
        jne getpar_ccon21
            convString2h par1, memo2[1*2]
        getpar_ccon21:
        cmp cur_par1, 22
        jne getpar_ccon22
            convString2h par1, memo2[2*2]
        getpar_ccon22:
        cmp cur_par1, 23
        jne getpar_ccon23
            convString2h par1, memo2[3*2]
        getpar_ccon23:
        cmp cur_par1, 24
        jne getpar_ccon24
            convString2h par1, memo2[4*2]
        getpar_ccon24:
        cmp cur_par1, 25
        jne getpar_ccon25
            convString2h par1, memo2[5*2]
        getpar_ccon25:
        cmp cur_par1, 26
        jne getpar_ccon26
            convString2h par1, memo2[6*2]
        getpar_ccon26:
        cmp cur_par1, 27
        jne getpar_ccon27
            convString2h par1, memo2[7*2]
        getpar_ccon27:
        cmp cur_par1, 28
        jne getpar_ccon28
            convString2h par1, memo2[8*2]
        getpar_ccon28:
        cmp cur_par1, 29
        jne getpar_ccon29
            convString2h par1, memo2[9*2]
        getpar_ccon29:
        cmp cur_par1, 30
        jne getpar_ccon30
            convString2h par1, memo2[10*2]
        getpar_ccon30:
        cmp cur_par1, 31
        jne getpar_ccon31
            convString2h par1, memo2[11*2]
        getpar_ccon31:
        cmp cur_par1, 32
        jne getpar_ccon32
            convString2h par1, memo2[12*2] 
        getpar_ccon32:
        cmp cur_par1, 33
        jne getpar_ccon33
            convString2h par1, memo2[13*2]
        getpar_ccon33:
        cmp cur_par1, 34
        jne getpar_ccon34
            convString2h par1, memo2[14*2]
        getpar_ccon34:
        cmp cur_par1, 35
        jne getpar_ccon35
            convString2h par1, memo2[15*2]
        getpar_ccon35:
        cmp cur_par1, 36
        jne getpar_ccon36
            convString2h par1, memo2[16*2]
        getpar_ccon36:
                                                                        

exit_getpar:
ret
getpar endp

intial proc
    Mov dx,3fbh
    mov al,10000000b
    out dx,al

    mov dx,3f8h
    mov al,0ch
    out dx,al

    mov dx,3f9h
    mov al,00H
    out dx,al

    mov dx,3fbh
    mov al,00011011b
    out dx,al

    ret

intial ENDP

res proc 

    mov dx,3fdh
    check: in al,dx
    and al,1
    jz check
    mov dx,03f8h
    in al,dx
    mov val,al

    ret

res ENDP

send proc 

    mov dx,3fdh
    again: in al,dx
    and al,00100000b
    jz again
    mov dx,3f8h
    mov al,msg
    out dx,al
    ret

send ENDP

drawHorizontalLine proc 
       mov cx,80d
       draw:
         mov dx,offset msg7
         mov ah,9
         int 21h
         dec cx
         jnz draw  
         ret
drawHorizontalLine endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Excute8 proc
    
    cmp cur_inst,1d
    jne addinst_con
    jmp addinst
    addinst_con:
    
    cmp cur_inst,2d
    jne adcinst_con
    jmp adcinst
    adcinst_con:

    
    cmp cur_inst,3d
    jne andinst_con
    jmp andinst
    andinst_con:
    
    cmp cur_inst,4d
    jne subinst_con
    jmp subinst
    subinst_con:
    
    cmp cur_inst,5d
    jne sbbinst_con
    jmp sbbinst
    sbbinst_con:
    
    cmp cur_inst,6d
    jne shrinst_con
    jmp shrinst
    shrinst_con:
    
    cmp cur_inst,7d
    jne shlinst_con
    jmp shlinst
    shlinst_con:
    
    cmp cur_inst,8d
    jne movinst_con
    jmp movinst
    movinst_con:
    
    cmp cur_inst,9d
    jne mulinst_con
    jmp mulinst
    mulinst_con:
    
    cmp cur_inst,10d
    jne xorinst_con
    jmp xorinst
    xorinst_con:
    
    cmp cur_inst,11d
    jne rorinst_con
    jmp rorinst
    rorinst_con:
    
    cmp cur_inst,12d
    jne rolinst_con
    jmp rolinst
    rolinst_con:
    
    cmp cur_inst,13d
    jne incinst_con
    jmp incinst
    incinst_con:
    
    cmp cur_inst,14d
    jne decinst_con
    jmp decinst
    decinst_con:
    
    cmp cur_inst,15d
    jne divinst_con
    jmp divinst
    divinst_con:
    
    cmp cur_inst,16d
    jne clcinst_con
    jmp clcinst
    clcinst_con:
    
    
   addinst:
        cmp cur_isval,1d
        jne Notval1
        mov ah,par1
        add ah,value
        mov par1,ah
        jmp exit2
        Notval1:
            mov ah,par1
            mov bh,par2
            add ah,bh
            mov par1,ah
            jmp exit2
            
       
    adcinst:
        cmp cur_isval,1d
        jne Notval2
        mov ah,par1
        adc ah,value
        mov par1,ah
        jmp exit2
        Notval2:
            mov ah,par1
            mov bh,par2
            adc ah,bh
            mov par1,ah
            jmp exit2 
            
            
    andinst:
        cmp cur_isval,1d
        jne Notval3
        mov ah,par1
        and ah,value
        mov par1,ah
        jmp exit2
        Notval3:
            mov ah,par1
            mov bh,par2
            and ah,bh
            mov par1,ah
            jmp exit2                       
    
    
    
    subinst:
        cmp cur_isval,1d
        jne Notval4
        mov ah,par1
        sub ah,value
        mov par1,ah
        jmp exit2
        Notval4:
            mov ah,par1
            mov bh,par2
            sub ah,bh
            mov par1,ah
            jmp exit2
    
    
     sbbinst:
        cmp cur_isval,1d
        jne Notval5
        mov ah,par1
        sbb ah,value
        mov par1,ah
        jmp exit2
        Notval5:
            mov ah,par1
            mov bh,par2
            sbb ah,bh
            mov par1,ah
            jmp exit2
    
    
    
    shrinst:
        cmp cur_isval,1d
        jne Notval6
        mov ah,par1
        mov cl, value
        shr ah,cl
        mov par1,ah
        jmp exit2
        Notval6:
            mov ah,par1
            mov bh,par2
            mov cl, bh
            shr ah,cl
            mov par1,ah
            jmp exit2
    
    
    shlinst:
        cmp cur_isval,1d
        jne Notval7
        mov ah,par1
        mov cl, value
        shl ah,cl
        mov par1,ah
        jmp exit2
        Notval7:
            mov ah,par1
            mov bh,par2
            mov cl, bh
            shl ah,cl
            mov par1,ah
            jmp exit2
    
    
    movinst:
        cmp cur_isval,1d
        jne Notval8
        mov ah,par1
        mov ah,value
        mov par1,ah
        jmp exit2
        Notval8:
            mov ah,par1
            mov bh,par2
            mov ah,bh
            mov par1,ah
            jmp exit2        
    
    
    mulinst:    ;;;;;;;;;;IMPORTANT
        cmp cur_isval,1d
        jne Notval9
        mov bl,value
        ;;;;;;;;;;;;;; 
        mov ah,0
        mov si, offset ax_user
        mov al, byte ptr [si]
        mul bl 
        mov ax_user,ax
        ;;;;;;;;;;;;;;
        jmp exit2
        Notval9:
            mov bl,par1
            ;;;;;;;;;;;;;; 
            mov ah,0
            mov si, offset ax_user
            mov al,byte ptr [si]
            mul bl 
            mov ax_user,ax
            ;;;;;;;;;;;;;;
            jmp exit2
    
    
    xorinst:
        cmp cur_isval,1d
        jne Notval10
        mov ah,par1
        xor ah,value
        mov par1,ah
        jmp exit2
        Notval10:
            mov ah,par1
            mov bh,par2
            xor ah,bh
            mov par1,ah
            jmp exit2             
    
    
    rorinst:
        cmp cur_isval,1d
        jne Notval11
        mov ah,par1
        mov cl, value
        ror ah,cl
        mov par1,ah
        jmp exit2
        Notval11:
            mov ah,par1
            mov bh,par2
            mov cl, bh
            ror ah,cl
            mov par1,ah
            jmp exit2
            
    
     rolinst:
        cmp cur_isval,1d
        jne Notval12
        mov ah,par1
        mov cl, value
        rol ah,cl
        mov par1,ah
        jmp exit2
        Notval12:
            mov ah,par1
            mov bh,par2
            mov cl, bh
            rol ah,cl
            mov par1,ah
            jmp exit2
     
    
    
    incinst:
        mov ah,par1
        inc ah
        mov par1,ah
        jmp exit2 
    
    
    decinst:
        mov ah,par1
        dec ah
        mov par1,ah
        jmp exit2    
    
    
    
     divinst:    ;;;;;;;;;;IMPORTANT
        cmp cur_isval,1d
        jne Notval13
        mov bl,value
        ;;;;;;;;;;;;;; 
        mov ax,ax_user
        div bl
        mov si, offset ax_user
        mov [si],ax
        ;;;;;;;;;;;;;;
        jmp exit2
        Notval13:
            mov bl,par1
            ;;;;;;;;;;;;;; 
            mov ax,ax_user
            div bl 
            mov si, offset ax_user
            mov [si],ax
            ;;;;;;;;;;;;;;
            jmp exit2                    
    
    clcinst:
        mov ah,0
        mov c_user,ah        
             
            
       
    
exit2:
    ret 
Excute8 endp   



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 



Excute16 proc
    
    cmp cur_inst,1d
    jne addinst1_con
    jmp addinst1
    addinst1_con:
    
    cmp cur_inst,2d
    jne adcinst1_con
    jmp adcinst1
    adcinst1_con:
    
    cmp cur_inst,3d
    jne andinst1_con
    jmp andinst1
    andinst1_con:
    
    cmp cur_inst,4d
    jne subinst1_con
    jmp subinst1
    subinst1_con:
    
    cmp cur_inst,5d
    jne sbbinst1_con
    jmp sbbinst1
    sbbinst1_con:
    
    cmp cur_inst,6d
    jne shrinst1_con
    jmp shrinst1
    shrinst1_con:
    
    cmp cur_inst,7d
    jne shlinst1_con
    jmp shlinst1
    shlinst1_con:
    
    cmp cur_inst,8d
    jne movinst1_con
    jmp movinst1
    movinst1_con:
    
    ; cmp cur_inst,9d
    ; jne mulinst1_con
    ; jmp mulinst1
    ; mulinst1_con:
    
    cmp cur_inst,10d
    jne xorinst1_con
    jmp xorinst1
    xorinst1_con:
    
    cmp cur_inst,11d
    jne rorinst1_con
    jmp rorinst1
    rorinst1_con:
    
    cmp cur_inst,12d
    jne rolinst1_con
    jmp rolinst1
    rolinst1_con:
    
    cmp cur_inst,13d
    jne incinst1_con
    jmp incinst1
    incinst1_con:
    
    cmp cur_inst,14d
    jne decinst1_con
    jmp decinst1
    decinst1_con:
    
    ; cmp cur_inst,15d
    ; jne divinst1_con
    ; jmp divinst1
    ; divinst1_con:
    
    cmp cur_inst,16d
    jne clcinst1_con
    jmp clcinst1
    clcinst1_con:
    
    
   addinst1:
        cmp cur_isval,1d
        jne Notvacll1
        mov ax,par3
        add ax,word ptr[offset value2]
        mov par3,ax
        jmp exit3
        Notvacll1:
            mov ax,par3
            mov bx,par4
            add ax,bx
            mov par3,ax
            jmp exit3
            
       
    adcinst1:
        cmp cur_isval,1d
        jne Notvacll2
        mov ax,par3
        adc ax,word ptr[offset value2]
        mov par3,ax
        jmp exit3
        Notvacll2:
            mov ax,par3
            mov bx,par4
            adc ax,bx
            mov par3,ax
            jmp exit3 
            
            
    andinst1:
        cmp cur_isval,1d
        jne Notvacll3
        mov ax,par3
        and ax,word ptr[offset value2]
        mov par3,ax
        jmp exit3
        Notvacll3:
            mov ax,par3
            mov bx,par4
            and ax,bx
            mov par3,ax
            jmp exit3                       
    
    
    
    subinst1:
        cmp cur_isval,1d
        jne Notvacll4
        mov ax,par3
        sub ax,word ptr[offset value2]
        mov par3,ax
        jmp exit3
        Notvacll4:
            mov ax,par3
            mov bx,par4
            sub ax,bx
            mov par3,ax
            jmp exit3
    
    
     sbbinst1:
        cmp cur_isval,1d
        jne Notvacl5
        mov ax,par3
        sbb ax,word ptr[offset value2]
        mov par3,ax
        jmp exit3
        Notvacl5:
            mov ax,par3
            mov bx,par4
            sbb ax,bx
            mov par3,ax
            jmp exit3
    
    
    
    shrinst1:
        ; cmp cur_isval,1d
        ; jne Notvacl6
        ; mov ax,par3
        ; mov si, 
        ; mov cl,byte ptr [offset value2] 
        ; shr ax, cl
        ; mov par3,ax
        ; jmp exit3
        ;ilegal
        ;  Notvacl6:
        ;     mov ax,par3
        ;     mov bx,par4
        ;     shr ax,bx
        ;     mov par3,ax
        ;     jmp exit3
    
    
    shlinst1:
        ; cmp cur_isval,1d
        ; jne Notvacl7
        ; mov ax,par3
        ; mov cl, [offset value2]
        ; shl ax, cl
        ; mov par3,ax
        ; jmp exit3
        ;ilegal
        ;  Notvacl7:
        ;     mov ax,par3
        ;     mov bx,par4
        ;     shl ax,bx
        ;     mov par3,ax
        ;     jmp exit3
    
    
    movinst1:
        cmp cur_isval,1d
        jne Notvacl8
        mov ax,par3
        mov ax, word ptr[offset value2]
        mov par3,ax
        jmp exit3
        Notvacl8:
            mov ax,par3
            mov bx,par4
            mov ax,bx
            mov par3,ax
            jmp exit3        
    
    
    ; mulinst1:    ;;;;;;;;;;IMPORTANT
    ;     cmp cur_isval,1d
    ;     jne Notvacl9
    ;     mov bl,value2
    ;     ;;;;;;;;;;;;;; 
    ;     mov ah,0
    ;     mov si, offset ax_user + 1
    ;     mov al, byte ptr [si]
    ;     mul bl 
    ;     mov ax_user,ax
    ;     ;;;;;;;;;;;;;;
    ;     jmp exit3
    ;     Notvacl9:
    ;         mov si, offset par3
    ;         mov bl, byte ptr [si]
    ;         ;;;;;;;;;;;;;; 
    ;         mov ah,0
    ;         mov si, offset ax_user + 1
    ;         mov al, byte ptr [si]
    ;         mul bl 
    ;         mov ax_user,ax
    ;         ;;;;;;;;;;;;;;
    ;         jmp exit3
    
    
    xorinst1:
        cmp cur_isval,1d
        jne Notvacl10
        mov ax,par3
        xor ax,word ptr[offset value2]
        mov par3,ax
        jmp exit3
        Notvacl10:
            mov ax,par3
            mov bx,par4
            xor ax,bx
            mov par3,ax
            jmp exit3             
    
    
    rorinst1:
        ; cmp cur_isval,1d
        ; jne Notvacl11
        ; mov ax,par3
        ; mov cl, [offset value2]
        ; ror ax,cl
        ; mov par3,ax
        ; jmp exit3
        ; Notvacl11:
            ; mov ax,par3
            ; mov bx,par4
            ; ror ax,bx
            ; mov par3,ax
            ; jmp exit3
            
    
     rolinst1:
        ; cmp cur_isval,1d
        ; jne Notvacl12
        ; mov ax,par3
        ; mov cl, [offset value2]
        ; rol ax, cl
        ; mov par3,ax
        ; jmp exit3
        ; Notvacl12:
            ; mov ax,par3
            ; mov bx,par4
            ; rol ax,bx
            ; mov par3,ax
            ; jmp exit3
     
    
    
    incinst1:
        mov ax,par3
        inc ax
        mov par3,ax
        jmp exit3 
    
    
    decinst1:
        mov ax,par3
        dec ax
        mov par3,ax
        jmp exit3    
    
    
    
    ;  divinst1:    ;;;;;;;;;;IMPORTANT
    ;     cmp cur_isval,1d
    ;     jne Notvacl13
    ;     mov si, offset value2
    ;     mov bl, byte ptr[si]
    ;     ;;;;;;;;;;;;;; 
    ;     mov ax,ax_user
    ;     div bl 
    ;     mov si, offset ax_user
    ;     mov [si],ax
    ;     ;;;;;;;;;;;;;;
    ;     jmp exit3
    ;     Notvacl13:
    ;         mov si, offset par3
    ;         mov bl, byte ptr [si]
    ;         ;;;;;;;;;;;;;; 
    ;         mov ax,ax_user
    ;         div bl 
    ;         mov si, offset ax_user
    ;         mov [si],ax
    ;         ;;;;;;;;;;;;;;
    ;         jmp exit3                    
    
    clcinst1:
        mov ax,0
        mov [c_user],al        
             
            
       
    
exit3:
    ret 
Excute16 endp   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

inst proc

    ;FIRST CHAR 
    cmp byte ptr [bx], 97
    jz str_a
    cmp byte ptr [bx], 115
    jz str_s
    cmp byte ptr [bx], 109
    jz str_m
    cmp byte ptr [bx], 120
    jz str_x
    cmp byte ptr [bx], 114
    jz str_r
    cmp byte ptr [bx], 105
    jz str_i
    cmp byte ptr [bx], 100
    jz str_d
    cmp byte ptr [bx], 99
    jz str_c
    jnz  notvalid_intermediate

    ;SECOND CHAR 

    str_a:
    inc bx
    cmp byte ptr [bx], 100
    jz str_ad
    cmp byte ptr [bx], 110
    jz str_an
    jnz notvalid_intermediate

    str_s:
    inc bx
    cmp byte ptr [bx], 117
    jz str_su
    cmp byte ptr [bx], 98
    jz str_sb
    cmp byte ptr [bx], 104
    jz str_sh
    jnz notvalid_intermediate

    str_m:
    inc bx
    cmp byte ptr [bx], 111
    jz str_mo
    cmp byte ptr [bx], 117
    jz str_mu
    jnc notvalid_intermediate

    str_x:
    inc bx
    cmp byte ptr [bx], 111
    jz str_xo
    jnz notvalid_intermediate

    str_r:
    inc bx
    cmp byte ptr [bx], 111
    jz str_ro
    jnz notvalid_intermediate

    str_i:
    inc bx
    cmp byte ptr [bx], 110
    jz str_in
    jnz notvalid_intermediate

    str_d:
    inc bx
    cmp byte ptr [bx], 101
    jz str_de
    cmp byte ptr [bx], 105
    jz str_di
    jnz notvalid_intermediate

    str_c:
    inc bx
    cmp byte ptr [bx], 108
    jz str_cl
    jnz notvalid_intermediate

    ;THIRD CHAR 

    str_ad:
    inc bx
    cmp byte ptr [bx], 100
    jz str_add
    cmp byte ptr [bx], 99
    jz str_adc
    jnz notvalid_intermediate

    str_an:
    inc bx
    cmp byte ptr [bx], 100
    jz str_and
    jnz notvalid_intermediate

    str_su:
    inc bx
    cmp byte ptr [bx], 98
    jz str_sub
    jnz notvalid_intermediate

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    notvalid_intermediate:
        jmp notvalid_intermediate_2
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    str_sb:
    inc bx
    cmp byte ptr [bx], 98
    jz str_sbb
    jnz notvalid_intermediate_2

    str_sh:
    inc bx
    cmp byte ptr [bx], 114
    jz str_shr
    cmp byte ptr [bx], 108
    jz str_shl
    jnz notvalid_intermediate

    str_mo:
    inc bx
    cmp byte ptr [bx], 118
    jz str_mov
    jnz notvalid_intermediate

    

    str_mu:
    inc bx
    cmp byte ptr [bx], 108
    jz str_mul
    jnz notvalid_intermediate

    str_xo:
    inc bx
    cmp byte ptr [bx], 114
    jz str_xor
    jnz notvalid_intermediate

    
    
    str_ro:
    inc bx
    cmp byte ptr [bx], 114
    jz str_ror
    cmp byte ptr[bx], 108
    jz str_rol
    jnz notvalid_intermediate_2

    str_in:
    inc bx
    cmp byte ptr [bx], 99
    jz str_inc
    jnz notvalid_intermediate_2

    str_de:
    inc bx
    cmp byte ptr [bx], 99
    jz str_dec
    jnz notvalid_intermediate_2

    str_di:
    inc bx
    cmp byte ptr [bx], 118
    jz str_div
    jnz notvalid_intermediate_2

    str_cl:
    inc bx
    cmp byte ptr [bx], 99
    jz str_clc
    jnz notvalid_intermediate_2

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    notvalid_intermediate_2:
        jmp notvalid

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;Instructions

    str_add:
        mov dx, 1
        jmp finish

    str_adc:
        mov dx, 2
        jmp finish

    str_and:
        mov dx, 3
        jmp finish

    str_sub:
        mov dx, 4
        jmp finish

    str_sbb:
        mov dx, 5
        jmp finish

    str_shr:
        mov dx, 6
        jmp finish

    str_shl:
        mov dx, 7
        jmp finish

    str_mov:
        mov dx, 8
        jmp finish

    str_mul:
        mov dx, 9
        jmp finish

    str_xor:
        mov dx, 10
        jmp finish

    str_ror:
        mov dx, 11
        jmp finish

    str_rol:
        mov dx, 12
        jmp finish

    str_inc:
        mov dx, 13
        jmp finish

    str_dec:
        mov dx, 14
        jmp finish

    str_div:
        mov dx, 15
        jmp finish

    str_clc:
        mov dx, 16
        jmp finish

    notvalid:
        mov dx, 0
    finish:
    ret
inst ENDP


getValue proc

;;offset of par in bx and the result in dx

push cx
push ax
pushf

mov cx, 0
mov dx, 0
countValue:
inc cx
inc bx
cmp byte ptr [bx], 32
jnz con
jmp calcvalue
con:
cmp byte ptr [bx], 36
jnz countValue

calcvalue:

dec bx

cmp byte ptr [bx], 104
jz hex
jnz decimal

hex:
    dec cx
    sub bx, cx
    dec bx
    dec cx
    Hex_loop: 
    mov ax, [bx]
    mov al, ah
    mov ah, 0
    cmp ax, 58
    jnc char_hex
    sub al, 30H
    jmp cont
    char_hex:
    sub al, 87
    cont:
    push cx
    push ax
    mov al, cl
    mov ch, 4
    mov ah, 0
    mul ch
    mov cx, ax
    pop ax
    shl ax, cl
    pop cx
    add dx, ax
    inc bx
    dec cx
    cmp cx, 0FFFFH
    jnz Hex_loop
    jmp finish_getnumval
decimal:
    sub bx, cx
    dec cx
    clc
    pushf
    decimal_loop: 
    mov ax, [bx]
    mov al, ah
    mov ah, 0
    sub al, 30H
    cmp cx, 0
    jz skip_mul
    push cx
    push bx
    push dx
    mov bx, 10
    multi:
    mov dx, 0
    mul bx
    dec cx
    cmp cx, 0
    jnz multi
    pop dx
    pop bx
    pop cx
    skip_mul:
    popf
    adc dx, ax
    pushf
    inc bx
    dec cx
    cmp cx, 0FFFFH
    jnz decimal_loop 
    popf 
    finish_getnumval:

popf
pop ax
POP cx

ret
getValue endp



getValueOfString proc near

;;offset of par in bx and size of string in cx and the result in dx

push ax
pushf

dec cx
mov dx, 0
getValueOfStringCon:
mov ah, 0
mov al, byte ptr [bx]
cmp al, 58
jnc char_hexh
sub al, 30H
jmp conth
char_hexh:
sub al, 87
conth:
push cx
push ax
mov al, cl
mov ch, 4
mov ah, 0
mul ch
mov cx, ax
pop ax
shl ax, cl
pop cx
add dx, ax
inc bx
dec cx
cmp cx, 0FFFFH
jnz getValueOfStringCon


popf
pop ax

ret
getValueOfString endp


par     proc

;;offset of par in bx and the result in dx

    cmp byte ptr [bx], 97
    jnz par_ac
    jmp par_a
    par_ac:
    cmp byte ptr [bx], 98
    jnz par_bc
    jmp par_b
    par_bc:
    cmp byte ptr [bx], 99
    jnz par_cc
    jmp par_c
    par_cc:
    cmp byte ptr [bx], 100
    jnz par_dc
    jmp par_d
    par_dc:
    cmp byte ptr [bx], 115
    jnz par_sc
    jmp par_s
    par_sc:
    cmp byte ptr [bx], 91
    jnz par_p2c
    jmp par_p2
    par_p2c:
    jmp notvalidpar

    par_a:
        inc bx
        cmp byte ptr [bx], 120
        jnz par_axc
        jmp par_ax
        par_axc:
        cmp byte ptr [bx], 104
        jnz par_ahc
        jmp par_ah
        par_ahc:
        cmp byte ptr [bx], 108
        jnz par_alc
        jmp par_al
        par_alc:
        jmp notvalidpar

    par_b:
        inc bx
        cmp byte ptr [bx], 120
        jnz par_bxc
        jmp par_bx
        par_bxc:
        cmp byte ptr [bx], 104
        jnz par_bhc
        jmp par_bh
        par_bhc:
        cmp byte ptr [bx], 108
        jnz par_blc
        jmp par_bl
        par_blc:
        cmp byte ptr [bx], 112
        jnz par_bpc
        jmp par_bp
        par_bpc:
        jmp notvalidpar

    par_c:
        inc bx
        cmp byte ptr [bx], 120
        jnz par_cxc
        jmp par_cx
        par_cxc:
        cmp byte ptr [bx], 104
        jnz par_chc
        jmp par_ch
        par_chc:
        cmp byte ptr [bx], 108
        jnz par_clc
        jmp par_cl
        par_clc:
        jmp notvalidpar

    par_d:
        inc bx
        cmp byte ptr [bx], 120
        jnz par_dxc
        jmp par_dx
        par_dxc:
        cmp byte ptr [bx], 104
        jnz par_dhc
        jmp par_dh
        par_dhc:
        cmp byte ptr [bx], 108
        jnz par_dlc
        jmp par_dl
        par_dlc:
        cmp byte ptr [bx], 105
        jnz par_dic
        jmp par_di
        par_dic:
        jmp notvalidpar

    par_s:
        inc bx
        cmp byte ptr [bx], 112
        jnz par_spc
        jmp par_sp
        par_spc:
        cmp byte ptr [bx], 105
        jnz par_sic
        jmp par_si
        par_sic:
        jmp notvalidpar
        
    par_p2:
    inc bx
    cmp byte ptr [bx], 98
    jnz par_p2bc
    jmp par_p2b
    par_p2bc:
    cmp byte ptr [bx], 115
    jnz par_p2sc
    jmp par_p2s
    par_p2sc:
    cmp byte ptr [bx], 100
    jnz par_p2dc
    jmp par_p2d
    par_p2dc:
    cmp byte ptr [bx], 48
    jnz par_p20_c
    jmp par_p20
    par_p20_c:
    cmp byte ptr [bx], 49
    jnz par_p21c
    jmp par_p21
    par_p21c:
    cmp byte ptr [bx], 50
    jnz par_p22c
    jmp par_p22
    par_p22c:
    cmp byte ptr [bx], 51
    jnz par_p23c
    jmp par_p23
    par_p23c:
    cmp byte ptr [bx], 52
    jnz par_p24c
    jmp par_p24
    par_p24c:
    cmp byte ptr [bx], 53
    jnz par_p25c
    jmp par_p25
    par_p25c:
    cmp byte ptr [bx], 54
    jnz par_p26c
    jmp par_p26
    par_p26c:
    cmp byte ptr [bx], 55
    jnz par_p27c
    jmp par_p27
    par_p27c:
    cmp byte ptr [bx], 56
    jnz par_p28c
    jmp par_p28
    par_p28c:
    cmp byte ptr [bx], 57
    jnz par_p29c
    jmp par_p29
    par_p29c:
    jmp notvalidpar

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    par_ax:
        mov dx, 9
        jmp finishpar
    par_ah:
        mov dx, 1
        jmp finishpar
    par_al:
        mov dx, 2
        jmp finishpar
    par_bx:
        mov dx, 10
        jmp finishpar
    par_bh:
        mov dx, 3
        jmp finishpar
    par_bl:
       mov dx, 4
        jmp finishpar
    par_bp:
        mov dx, 16
        jmp finishpar
    par_cx:
        mov dx, 11
        jmp finishpar
    par_ch:
        mov dx, 5
        jmp finishpar
    par_cl:
        mov dx, 6
        jmp finishpar
    par_dx:
        mov dx, 12
        jmp finishpar
    par_dh:
        mov dx, 7
        jmp finishpar
    par_di:
        mov dx, 14
        jmp finishpar
    par_dl:
        mov dx, 8
        jmp finishpar
    par_si:
        mov dx, 13
        jmp finishpar
    par_sp:
        mov dx, 15
        jmp finishpar
        
    par_p2b:
        inc bx
        cmp byte ptr [bx], 120
        jnz par_p2bxc
        jmp par_p2bx
        par_p2bxc:
        jmp notvalidpar

    par_p2s:
        inc bx
        cmp byte ptr [bx], 105
        jnz par_p2sic
        jmp par_p2si
        par_p2sic:
        jmp notvalidpar

    par_p2d:
        inc bx
        cmp byte ptr [bx], 105
        jnz par_p2dic
        jmp par_p2di
        par_p2dic:
        jmp notvalidpar

    par_p20:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p20p2c
        jmp par_p20p2
        par_p20p2c:
        cmp byte ptr [bx], 104
        jnz par_p20hc
        jmp par_p20h
        par_p20hc:
        cmp byte ptr [bx], 97
        jnz par_p20ac
        jmp par_p20a
        par_p20ac:
        cmp byte ptr [bx], 98
        jnz par_p20bc
        jmp par_p20b
        par_p20bc:
        cmp byte ptr [bx], 99
        jnz par_p20cc
        jmp par_p20c
        par_p20cc:
        cmp byte ptr [bx], 100
        jnz par_p20dc
        jmp par_p20d
        par_p20dc:
        cmp byte ptr [bx], 101
        jnz par_p20ec
        jmp par_p20e
        par_p20ec:
        cmp byte ptr [bx], 102
        jnz par_p20fc
        jmp par_p20f
        par_p20fc:
        jmp notvalidpar

    par_p21:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p21p2c
        jmp par_p21p2
        par_p21p2c:
        cmp byte ptr [bx], 104
        jnz par_p21hc
        jmp par_p21h
        par_p21hc:
        jmp notvalidpar
    par_p22:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p22p2c
        jmp par_p22p2
        par_p22p2c:
        cmp byte ptr [bx], 104
        jnz par_p22hc
        jmp par_p22h
        par_p22hc:
        jmp notvalidpar
    par_p23:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p23p2c
        jmp par_p23p2
        par_p23p2c:
        cmp byte ptr [bx], 104
        jnz par_p23hc
        jmp par_p23h
        par_p23hc:
        jmp notvalidpar
    par_p24:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p24p2c
        jmp par_p24p2
        par_p24p2c:
        cmp byte ptr [bx], 104
        jnz par_p24hc
        jmp par_p24h
        par_p24hc:
        jmp notvalidpar
    par_p25:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p25p2c
        jmp par_p25p2
        par_p25p2c:
        cmp byte ptr [bx], 104
        jnz par_p25hc
        jmp par_p25h
        par_p25hc:
        jmp notvalidpar
    par_p26:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p26p2c
        jmp par_p26p2
        par_p26p2c:
        cmp byte ptr [bx], 104
        jnz par_p26hc
        jmp par_p26h
        par_p26hc:
        jmp notvalidpar
    par_p27:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p27p2c
        jmp par_p27p2
        par_p27p2c:
        cmp byte ptr [bx], 104
        jnz par_p27hc
        jmp par_p27h
        par_p27hc:
        jmp notvalidpar
   par_p28:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p28p2c
        jmp par_p28p2
        par_p28p2c:
        cmp byte ptr [bx], 104
        jnz par_p28hc
        jmp par_p28h
        par_p28hc:
        jmp notvalidpar
    par_p29:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p29p2c
        jmp par_p29p2
        par_p29p2c:
        cmp byte ptr [bx], 104
        jnz par_p29hc
        jmp par_p29h
        par_p29hc:
        jmp notvalidpar

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    par_p2bx:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p2bxp2c
        jmp par_p2bxp2
        par_p2bxp2c:
        jmp notvalidpar
    par_p2si:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p2sip2c
        jmp par_p2sip2
        par_p2sip2c:
        jmp notvalidpar
    par_p2di:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p2dip2c
        jmp par_p2dip2
        par_p2dip2c:
        jmp notvalidpar
    par_p20p2:
        mov dx, 20
        jmp finishpar
    par_p20h:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p20hp2c
        jmp par_p20hp2
        par_p20hp2c:
        jmp notvalidpar
    par_p20a:
        inc bx
        cmp byte ptr [bx], 104
        jnz par_p20ahc
        jmp par_p20ah
        par_p20ahc:
        jmp notvalidpar
    par_p20b:
        inc bx
        cmp byte ptr [bx], 104
        jnz par_p20bhc
        jmp par_p20bh
        par_p20bhc:
        jmp notvalidpar
    par_p20c:
        inc bx
        cmp byte ptr [bx], 104
        jnz par_p20chc
        jmp par_p20ch
        par_p20chc:
        jmp notvalidpar
    par_p20d:
        inc bx
        cmp byte ptr [bx], 104
        jnz par_p20dhc
        jmp par_p20dh
        par_p20dhc:
        jmp notvalidpar
    par_p20e:
        inc bx
        cmp byte ptr [bx], 104
        jnz par_p20ehc
        jmp par_p20eh
        par_p20ehc:
        jmp notvalidpar
    par_p20f:
        inc bx
        cmp byte ptr [bx], 104
        jnz par_p20fhc
        jmp par_p20fh
        par_p20fhc:
        jmp notvalidpar
    par_p21p2:
        mov dx, 21
        jmp finishpar  
    par_p21h:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p21hp2c
        jmp par_p21hp2
        par_p21hp2c:
        jmp notvalidpar
    par_p22p2:
        mov dx, 22
        jmp finishpar
    par_p22h:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p22hp2c
        jmp par_p22hp2
        par_p22hp2c:
        jmp notvalidpar
    par_p23p2:
        mov dx, 23
        jmp finishpar 
    par_p23h:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p23hp2c
        jmp par_p23hp2
        par_p23hp2c:
        jmp notvalidpar
    par_p24p2:
        mov dx, 24
        jmp finishpar
    par_p24h:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p24hp2c
        jmp par_p24hp2
        par_p24hp2c:
        jmp notvalidpar
    par_p25p2:
        mov dx, 25
        jmp finishpar
    par_p25h:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p25hp2c
        jmp par_p25hp2
        par_p25hp2c:
        jmp notvalidpar
    par_p26p2:
        mov dx, 26
        jmp finishpar
    par_p26h:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p26hp2c
        jmp par_p26hp2
        par_p26hp2c:
        jmp notvalidpar
    par_p27p2:
        mov dx, 27
        jmp finishpar
    par_p27h:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p27hp2c
        jmp par_p27hp2
        par_p27hp2c:
        jmp notvalidpar
    par_p28p2:
        mov dx, 28
        jmp finishpar
    par_p28h:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p28hp2c
        jmp par_p28hp2
        par_p28hp2c:
        jmp notvalidpar
    par_p29p2:
        mov dx, 29
        jmp finishpar 
    par_p29h:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p29hp2c
        jmp par_p29hp2
        par_p29hp2c:
        jmp notvalidpar

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    par_p2bxp2:
        mov dx, 17
        jmp finishpar
    par_p2sip2:
        mov dx, 19
        jmp finishpar
    par_p2dip2:
        mov dx, 18
        jmp finishpar
    par_p20hp2:
        mov dx, 20
        jmp finishpar 
    par_p20ah:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p20ahp2c
        jmp par_p20ahp2
        par_p20ahp2c:
        jmp notvalidpar
    par_p20bh:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p20bhp2c
        jmp par_p20bhp2
        par_p20bhp2c:
        jmp notvalidpar
    par_p20ch:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p20chp2c
        jmp par_p20chp2
        par_p20chp2c:
        jmp notvalidpar
    par_p20dh:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p20dhp2c
        jmp par_p20dhp2
        par_p20dhp2c:
        jmp notvalidpar
    par_p20eh:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p20ehp2c
        jmp par_p20ehp2
        par_p20ehp2c:
        jmp notvalidpar
    par_p20fh:
        inc bx
        cmp byte ptr [bx], 93
        jnz par_p20fhp2c
        jmp par_p20fhp2
        par_p20fhp2c:
        jmp notvalidpar
    par_p21hp2:
        mov dx, 21
        jmp finishpar 
    par_p22hp2:
        mov dx, 22
        jmp finishpar
    par_p23hp2:
        mov dx, 23
        jmp finishpar
    par_p24hp2:
        mov dx, 24
        jmp finishpar 
    par_p25hp2:
        mov dx, 25
        jmp finishpar
    par_p26hp2:
        mov dx, 26
        jmp finishpar
    par_p27hp2:
        mov dx, 27
        jmp finishpar 
    par_p28hp2:
        mov dx, 28
        jmp finishpar 
    par_p29hp2:
        mov dx, 29
        jmp finishpar

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    par_p20ahp2:
        mov dx, 30
        jmp finishpar 
    par_p20bhp2:
        mov dx, 31
        jmp finishpar 
    par_p20chp2:
        mov dx, 32
        jmp finishpar 
    par_p20dhp2:
        mov dx, 33
        jmp finishpar 
    par_p20ehp2:
        mov dx, 34
        jmp finishpar 
    par_p20fhp2:
        mov dx, 35
        jmp finishpar 
    notvalidpar:
        mov dx, 0
    finishpar:
    ret
par ENDP 

checkHex proc     ;when found = 1 nottrue command 
;;offset in si, output in dx
    push cx
    push ax
    push bx
    mov cx,0
    mov dx, 1
    search:
        mov bx,[si+1]
        mov ax,[si]
        cmp al,36d
        je exit
        cmp al,32d
        je exit
        cmp al,47d
        jc isfound
        cmp al,58d
        jnc loop1_ch
        inc si
        jmp search
        loop1_ch:
            cmp al,96d
            jc isfound
            cmp al,103d
            jnc isfound
            inc si
            jmp search    
        
    isfound: 
        inc si 
        cmp al,104d
        jne loop3
        cmp bl,32d
        je search
        cmp bl,36d
        je search
        loop3:
            mov dx,0  
            cmp ax,32d
            jne search 
            cmp ax,36d
            jne search
    
  exit: 
    pop bx
    pop ax
    pop cx
    ret
  checkHex endp 

skipSpaces proc
;;set the offset of the String in BX
    dec bx
    skip_con:
    inc bx
    cmp byte ptr [bx], 32
    jz skip_con
    ret
skipSpaces endp

Execute proc
;;set the offset of the codeString in BX

    call skipSpaces
    call inst
    inc bx
    mov si, offset cur_inst
    mov [si], dx
    call skipSpaces
    call par
    inc bx
    inc si
    mov [si], dx
    call skipSpaces
    cmp byte ptr [bx], 44 ;;;;;;;;;;;;;;;;;;;;;;;;;لسا فى شغل هنا
    inc bx
    call skipSpaces
    push si
    mov si, bx
    call checkHex
    pop si
    inc si
    mov [si], dl
    cmp dx, 0
    jz trypar
    call getValue
    mov cur_par2,36
    inc si
    inc si
    mov [si], dx
    inc si
    mov [si], dx
    jmp exucon
    trypar:
    call par
    inc si
    mov [si], dx
    cmp cur_par1,0
    jne exucon
    mov error,3
    jmp end_execute
    exucon:

    
    mov isEight,0
    ;CheckingIf8
    cmp cur_par1, 9
    jc eight
    cmp cur_par1, 17
    jc exuc_con


    eight:
    mov isEight, 1
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;catchingErrors 

    ;size mismatch
    ;;;;;;;;;;;;;;;;;;;;;;;
    cmp cur_par2, 9
    jb exuc_con2
    cmp cur_par2,16
    ja exuc_con2
    mov error, 1        ;1 is size mismatch
    jmp end_execute
    exuc_con:
    cmp cur_par2, 9
    jnc exuc_con2 
    mov error, 1        ;1 is size mismatch
    jmp end_execute
    exuc_con2:

    ;memory to memory
    ;;;;;;;;;;;;;;;;;;;;;;;
    cmp cur_par1, 17
    jc exuc_con3
    cmp cur_par2, 17
    jc exuc_con3
    cmp cur_par2, 36
    jae exuc_con3
    mov error, 2        ;2 is memory to memory
    jmp end_execute
    exuc_con3:
    
    call setpar
    
    cmp isEight,1d
    jne is16
    call Excute8
   ; jmp finalex
    is16:
        call Excute16 
    finalex:
    call getpar

    mov [cur_isval], 0
    end_execute:
    mov cur_par1,0
    mov cur_par2,0
    ret

Execute ENDP


; powerup_4 proc
;         mov ax,3
;          int 33h
;          cmp bx,1
;          jnz end_p
;          cmp dx,165
;          jb end_p
;          cmp dx,175
;          ja end_p
;          cmp cx,52
;          jb end_p
;          cmp cx,62
;          ja end_p
;     p5:  mov al,[clear_once]
;          cmp al,1
;          jnz end_p
;          cmp switch,00h
;          jne ply2 
;          mov ax,[offset score1]
;          jmp e_p4
;     ply2: mov ax,[offset score2]
;          jmp e_p4    
;        e_p4:
;         cmp ax,30
;         jb  end_p
;         p_5
; end_p:
; ret
; endp powerup_4


clearScreen_1 macro x,y,z,w
    mov ax,0600h
mov bh,07
mov cl,x
mov ch,y
mov dl,z
mov dh,w
int 10h
endm   clearScreen_1

setcursor macro col,row
mov ah,2 
mov dh, row    ;row 
mov dl, col     ;column
mov bh,0
int 10h
endm setcursor
;;;;;;;
;;;;;;;
getcursor macro x,y
mov ah,3h
mov bh,0h
int 10h
mov x,dl
mov y,dh
endm getcursor
; preparefpart macro
; local loop_get_len1
; local exit_f_part1

;  clearScreen_1 0,0,80d,11d
;  setcursor 0,0
;   mov dx,offset firstname
;        mov ah,9
;        int 21h   
;   ;getcursor col1,row1
;   mov al,1
;   mov bx,offset firstname
; loop_get_len1:
;   mov ah,[bx]
;   cmp ah,'$'
;   je exit_f_part1
;   inc al
;   inc bx
;   jmp loop_get_len1
; exit_f_part1:
;   mov col1,al
;   mov row1,0
;   setcursor col1,row1
;    mov ah,2
;   mov dl,':'
;   int 21h
;   inc col1
; endm preparefpart

; preparespart macro
; local loop_get_len2
; local exit_f_part2
; clearScreen_1 0,13d,80d,24d
; setcursor 0,13d
; mov dx,offset secondname
;        mov ah,9
;        int 21h   
; mov al,1
;   mov bx,offset secondname
; loop_get_len2:
;   mov ah,[bx]
;   cmp ah,'$'
;   je exit_f_part2
;   inc al
;   inc bx
;   jmp loop_get_len2
; exit_f_part2:
;   mov col2,al
;   mov row2,13d
;   setcursor col1,row1
;    mov ah,2
;   mov dl,':'
;   int 21h
;   inc col2

; endm preparespart

preparespart macro

clearScreen_1 0,14d,80d,24d
setcursor 0,14d
 
  mov col2,0
  mov row2,14d
  setcursor col1,row1
  

endm preparespart

preparefpart macro


 clearScreen_1 0,1,80d,11d
 setcursor 0,1
  
  mov col1,0
  mov row1,1
  setcursor col1,row1
  

endm preparefpart

initialise macro
mov dx,03fbh
mov al,10000000b
out dx,al



mov dx,03f8h
mov al,0ch
out dx,al


mov dx,03f9h
mov al,00h
out dx,al



mov dx,03fbh
mov al,00110011b
out dx,al


endm initialise

drawHorizontalLine_1 proc 
      mov ah,2
 mov bh,0
 mov dx,0c00h
 int 10h

 mov cx,80d
  kol:
mov ah,2
mov dl,'-'
int 21h
dec cx
jnz kol
  
        
         ret
drawHorizontalLine_1 endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
chattingproc proc near
            clearScreen_1 0,0,80d,24d
            setcursor 40d,0
  mov dx,offset firstname
       mov ah,9
       int 21h   
          preparefpart
          setcursor 0,12d
       call drawHorizontalLine_1
        setcursor 40d,13d
  mov dx,offset secondname
       mov ah,9
       int 21h  
       preparespart
  
      mov ax,0
      mov dx,0
      mov cx,0
      mov bx,0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;SEND && Recieve
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

initialise
repeat:
   mov ax,0
   mov dx , 3FDH		; Line Status Register
   in al , dx
   AND al , 00100000b
   jnz never
jmp far ptr recieve
never:


   mov al,0
    mov ah,1
    int 16h
    jnz contchat
    jmp recieve
   
contchat:
    mov ah,0
    int 16h
    cmp ah,3dh
    jne cont_chat1
    mov your_chat_inv,0
    mov my_chat_inv,0
    mov al,ah
    mov dx , 3F8H		; Transmit data register
    out dx , al
    jmp far ptr exitret
    cont_chat1: 
    mov dx , 3F8H		; Transmit data register
    out dx , al
    mov ah,2

     inc col1;next letter
     mov cl,col1
     cmp cl,80d
     jb samerow1
     mov col1,0;next line
 inc row1
 mov cl,row1
     cmp cl,12d
     jb dontscroll
      preparefpart
      dontscroll:
    
   samerow1:
   setcursor col1,row1
mov dl,al
int 21h

  mov		ax, 0000h
 mov		es, ax
mov		es:[041ah], 041eh
 mov		es:[041ch], 041eh				; Clears keyboard buffer
 pop		es
  pop		ax

     mov al,0
    out dx , al

    



recieve:
mov ax,0
   mov dx , 3FDH		; Line Status Register
   in al , dx
   and al,1
    jnz dont
jmp far ptr repeat
    dont:
   mov dx , 03F8H
   in al , dx 
    cmp al,3dh
    jne cont_chat2
    mov your_chat_inv,0
    mov my_chat_inv,0
    jmp far ptr exitret
    cont_chat2:
   inc col2;next letter
   mov cl,col2
     cmp cl,80d
     jb samerow2
     mov col2,0;next line
 inc row2
 mov cl,row2
     cmp cl,24d
     jb dontscroll2
      preparespart
      dontscroll2:
    
   samerow2:
   setcursor col2,row2
   mov ah,2
   mov dl,al
   int 21h
   jmp repeat

exitret:
jmp far ptr loop_to_start_main

ret
chattingproc endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;  SI:Source    DI:Destination
srdata proc
mov cl,1
mov bl,0
mov bh,0

rsrepeat:
   mov ax,0
   mov dx , 3FDH		; Line Status Register
   in al , dx
   AND al , 00100000b
   jnz rscont_check_SEND
jmp far ptr rsrecieve
rscont_check_SEND:
    cmp bh,0
    je rscont_check_SEND1
    jmp far ptr exitcondition
rscont_check_SEND1:
    mov al, [ si ]
    cmp al, '$'
    jne cont_send
    ; mov dx , 3F8H		; Transmit data register
    ; mov al,'#'
    ; out dx , al
    mov bh,0ffh
    mov dx , 3F8H		; Transmit data register
    mov al,'#'
    out dx , al
    jmp rsrecieve
cont_send:
    mov dx , 3F8H		; Transmit data register
    out dx , al
    inc si

;;;;;;;;;;;;;;;;;;;;;;;;;;
rsrecieve:
cmp bl,00H
je cont_rsrecieve
jmp far ptr exitcondition
cont_rsrecieve:
mov ax,0
   mov dx , 3FDH		; Line Status Register
   in al , dx
   and al,1
    jnz rsdont          ;magalesh 7aga
    cmp cl,1            ;hal ba3at 2abl keda wala la2
    je rsrecieve
    jmp exitcondition
    rsdont:                 ;galy 7aga
   mov dx , 03F8H
   in al , dx              ;ha5rog mn el proc
   cmp al,'#'
   jne cont_rsrecieve1
   mov bl,0ffh
   jmp exitcondition
;    cmp al,0
;    jne cont_rsrecieve1
;    jmp exitcondition
cont_rsrecieve1:
    
   mov [di],al
;    mov ah,2
;    mov dl,al
;    int 21h                 ;print char
   inc di
;    mov dx , 03F8H
;    mov al,0
;    out dx,al
;    cmp cl,1
;    jne startagain
   mov cl,0
; startagain:

exitcondition:
    cmp bx,0h
    jne rsexit1
    jmp far ptr rsrepeat
rsexit1:
    cmp bx,00ffh
    jne rsexit2
   jmp far ptr rsrepeat
rsexit2:
    cmp bx,0ff00h
    jne rsexit3
   jmp far ptr rsrecieve
rsexit3:
   cmp bx,0ffffh
    je exit_rsproc
; rsnever:

; cmp bl,0FFH
; je recieve
; ;cmp bh,0ffh
; ;je exitcondition
; cmp bx,0
; je repeat
; cmp bx,00ffh
; je Send
; cmp bx,0ff00h
; je recieve
; cmp bx,0FFFFH
; je exit

exit_rsproc:
    ; mov ah,3
    ; mov bh,0
    ; int 10h
    ; inc dh
    ; mov dl,0
    ; mov ah,2
    ; int 10h
    ; mov ah, 9
    ; mov dx, offset msgendsrdata
    ; int 21h
    ; mov ah,3
    ; mov bh,0
    ; int 10h
    ; inc dh
    ; mov dl,0
    ; mov ah,2
    ; int 10h
ret
srdata endp

send_inv_proc proc far
mov dx , 3FDH ; Line Status Register
send_inv_proc_AGAIN: In al , dx ;Read Line Status
AND al , 00100000b
JZ send_inv_proc_AGAIN
;If empty put the VALUE in Transmit data register
mov dx , 3F8H ; Transmit data register
mov al,ah
out dx , al
ret
send_inv_proc endp





; clearbuffer proc near
; push ax
; push es
;   mov		ax, 0000h
;  mov		es, ax
; mov		es:[041ah], 041eh
;  mov		es:[041ch], 041eh				; Clears keyboard buffer
;  pop		es
;   pop		ax

;      mov al,0
;     out dx , al
; ret
; clearbuffer endp
p_5 macro
    cmp switch,0
    je clr_r_p1
    jmp clr_r_p2
clr_r_p1:
    cmp clear_once_p1,0
    jne cont_clr_r_p1
    jmp end_p_5
    cont_clr_r_p1:
    mov bx,offset score1
    ; mov cx,2
    call getValue
    cmp dx,30
    jae cont1_clr_r_p1
    jmp end_p_5
    cont1_clr_r_p1:
    sub dx,30
    convString2 dl,score1
    mov si,offset registers
    mov cx,64
clr_r_1:
    mov al,30h
    mov [si],al
    inc si
    loop clr_r_1
    ; mov al,[score1]
    ; sub al,30
    ; mov score1,al
    mov al,[clear_once_p1]
    dec al
    mov clear_once_p2,al
clr_r_p2:
    cmp clear_once_p2,0
    jne cont_clr_r_p2
    jmp end_p_5
    cont_clr_r_p2:
    mov bx,offset score2
    ; mov cx,2
    call getValue
    cmp dx,30
    jb end_p_5
    sub dx,30
    convString2 dl,score2
    mov si,offset registers
    mov cx,64
clr_r_2:
    mov al,30h
    mov [si],al
    inc si
    loop clr_r_2
    ; mov al,[score2]
    ; sub al,30
    ; mov score2,al
    mov al,[clear_once_p2]
    dec al
    mov clear_once_p2,al 
end_p_5:
endm 

p_3 macro
        ; mov ah,0
        ; int 16h 
        ;  mov al,x
        cmp switch,0
        je chfcp1
        jmp chfcp2
        
        chfcp1:
          cmp changeforbidenchar1,1
          je cont_chfcp1
          jmp endp_3
        cont_chfcp1:
          ;cmp score1,8
          mov bx,offset score1
        ;   mov cx,2
          call getValue
          cmp dx,8
          jae cont_chfcp2
          jmp endp_3
          cont_chfcp2:
          sub dx,8
          convString2 dl,score1
          mov ah,0
          int 16h
        ;   mov new_char,al
          mov forbiddenchar1,al
          mov si,offset forbiddenchar1
          mov di,offset temp_forbiden_char
          call srdata
        ;   pop dx
        ;   ;mov al,[score1]
        ;   sub dx,8
        ;   convString2 dl,score1
          mov al,[changeforbidenchar1]
          dec al
          mov changeforbidenchar1,al
          jmp endp_3

        chfcp2:
          cmp changeforbidenchar2,1
          jne endp_3
          ;cmp score2,8
          mov bx,offset score2
        ;   mov cx,2
          call getValue
          cmp dx,8
          jb endp_3
          sub dx,8
          convString2 dl,score2
          mov si,offset temp_forbiden_char
          mov di,offset forbiddenchar2
          call srdata
          mov al,[changeforbidenchar2]
          dec al
          mov changeforbidenchar1,al
          jmp endp_3
        ;   mov new_char,al
        ;   mov forbiddenchar2,al
        ;   mov si,offset forbiddenchar1
        ;   mov di,offset forbiddenchar2
        ;   call srdata
          ;mov al,[score2]
        ;   sub dx,8
        ;   convString2h dl,score2
        ;   mov al,[changeforbidenchar2]
        ;   dec al
        ;   mov changeforbidenchar2,al
        ;   jmp endp_3

endp_3:
endm

p_1 proc
    cmp switch,0
    je w_p1
    mov si,offset temp_command
    mov di,offset command
    call srdata
    jmp ex_comnd_p1
    w_p1:
    displaycommand switch
    mov si,offset command
    mov di,offset temp_command
    call srdata
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;في حاجة ناقصة اني مش ببعت ال command ;;;;;;;;;;
    ex_comnd_p1:
    mov si, offset switch
    not byte ptr [si]

    removeEnter  command
    convertLower command
    
    convertLower forbiddenchar1
    convertLower forbiddenchar2

    mov found,0

    cmp switch,00H
    je p1_pup
    jmp far ptr p2_pup
    p1_pup:
    checkValidity command,forbiddenchar2,found
    cmp found,1
    je minus1_pup
    jmp far ptr ex_pup
    minus1_pup:
    mov bx,offset score1
    call getValue
    dec dx
    convString2 dl,score1
    
    jmp far ptr end_p_1

    p2_pup:
    checkValidity command,forbiddenchar1,found
    cmp found,1
    je minus2_pup
    jmp far ptr ex_pup
    minus2_pup:
    mov bx,offset score2
    call getValue 
    dec dx
    convString2 dl,score2
    jmp far ptr end_p_1

    ex_pup:
    mov bx, offset command
    call Execute
    mov si, offset switch
    not byte ptr [si]
end_p_1:
ret
p_1 endp

p_2 proc
    cmp switch,0
    je w_p2
    mov si,offset temp_command
    mov di,offset command
    call srdata
    jmp ex_comnd_p2
    w_p2:
    displaycommand switch
    mov si,offset command
    mov di,offset temp_command
    call srdata
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;في حاجة ناقصة اني مش ببعت ال command ;;;;;;;;;;
    ex_comnd_p2:
    removeEnter  command
    convertLower command
    
    convertLower forbiddenchar1
    convertLower forbiddenchar2

    mov found,0
    cmp switch,00H
    je p1_pup2
    jmp far ptr p2_pup2

    ; cmp switch,00H
    ; je p1_pup
    ; jne p2_pup
    p1_pup2:
    checkValidity command,forbiddenchar2,found
    cmp found,1
    je minus1_pup2
    jmp far ptr ex_pup2
    minus1_pup2:
    mov bx,offset score1
    call getValue
    dec dx
    convString2 dl,score1
    
    jmp far ptr end_p_2

    p2_pup2:
    checkValidity command,forbiddenchar1,found
    cmp found,1
    je minus2_pup2
    jmp far ptr ex_pup2
    minus2_pup2:
    mov bx,offset score2
    call getValue 
    dec dx
    convString2 dl,score2
    jmp far ptr end_p_2

    ex_pup2:
    mov bx, offset command
    call Execute
    mov si, offset switch
    not byte ptr [si]
    mov bx, offset command
    call Execute
    mov si, offset switch
    not byte ptr [si]
end_p_2:
ret
p_2 endp

; p_6 proc
;     mov ah,0AH
;     mov dx,offset new_targetvalue
;     int 21h
;     mov si,offset new_targetvalue
;     call convert_str_num
;     mov ax,cx
;     mov bx,16 
;     mov si,offset registers
; lp_r:
;     push bx
;     push ax
;     call convert_str_num
;     pop ax
;     pop bx
;     cmp ax,cx
;     jz end_p6
;     dec bx
;     jnz lp_r
;     mov ax,[new_targetvalue] 
;     mov extra_value,ax
         
; end_p6: 
;     dec extra_power_chance
;     ret
; p_6 endp

; convert_str_num proc
;     mov di,4
;     mov cx,0
;     mov bx,1000h
;     ;mov si,offset registers
; convertreg:
;     mov ax,0
;     mov al,[si] 
;     cmp 
;     sub al,30h
; convert:
;     mul bx
;     add cx,ax
;     ror bx,4
;     inc si 
;     dec di
;     jnz convertreg  
;     ret      
; convert_str_num endp 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

chatingame proc


repeat2:
   mov ax,0
   mov dx , 3FDH		; Line Status Register
   in al , dx
   AND al , 00100000b
   jnz never2
jmp far ptr recieve2
never2:


;    mov al,0
    mov ah,1
    int 16h
    jnz contchat2
    jmp recieve2
   
contchat2:
mov ah,0
int 16h
cmp ah,3bh
jne now
mov al,ah
mov dx , 3F8H		; Transmit data register
out dx , al
;jmp far ptr miu
 jmp far ptr gameloop1
now:
cmp ah,01h
jne nevermind
mov dx , 3F8H		; Transmit data register
mov al,ah
    out dx , al
    ; mov toesc,1
;      mov		ax, 0000h
;  mov		es, ax
; mov		es:[041ah], 041eh
;  mov		es:[041ch], 041eh				; Clears keyboard buffer
;  pop		es
;   pop		ax
; mov  my_chat_inv,0
 mov  my_game_inv,0
;   mov your_chat_inv,0
  mov your_game_inv,0
;   mov switch,0
    ;jmp far ptr miu
    jmp far ptr loop111
nevermind:
    mov dx , 3F8H		; Transmit data register
    out dx , al
    mov ah,2

   inc col1;next letter
   mov cl,col1
     cmp cl,40d
     jb samerow11
     mov cl,fsi
     inc cl
     mov col1,cl;scroll
 mov row1,0
 setcursor col1,row1
mov ah,9 ;Display
mov bh,0 ;Page 0
mov al,0 ;Letter D
mov cx,0
mov cl,39d
sub cl,fsi

mov bl,00h ;Green (A) on white(F) background
int 10h 
   samerow11:
   setcursor col1,row1
mov dl,al
int 21h

  mov		ax, 0000h
 mov		es, ax
mov		es:[041ah], 041eh
 mov		es:[041ch], 041eh				; Clears keyboard buffer
 pop		es
  pop		ax

     mov al,0
    out dx , al

recieve2:
mov ax,0
   mov dx , 3FDH		; Line Status Register
   in al , dx
   and al,1
    jnz dont2
jmp far ptr repeat2
    dont2:
    
   mov dx , 03F8H
   in al , dx 
cmp al,3bh
    jne dbot
jmp far ptr gameloop1
;jmp far ptr miu
 ;jmp far ptr mum
    dbot:
    cmp al,01h
    jne dbot2
     mov		ax, 0000h
 mov		es, ax
mov		es:[041ah], 041eh
 mov		es:[041ch], 041eh				; Clears keyboard buffer
 pop		es
  pop		ax
    ; mov  my_chat_inv,0
 mov  my_game_inv,0
;   mov your_chat_inv,0
  mov your_game_inv,0
    ; mov switch,0
    ; mov toesc,1
;     mov		ax, 0000h
;  mov		es, ax
; mov		es:[041ah], 041eh
;  mov		es:[041ch], 041eh				; Clears keyboard buffer
;  pop		es
;   pop		ax
  ;jmp far ptr miu  
  jmp far ptr loop111
dbot2:
   inc col2;next letter
   mov cl,col2
     cmp cl,39d
     jb samerow22
     mov cl,ssi
     
     mov col2,cl;scroll
 mov row2,1
 setcursor col2,row2
mov ah,9 ;Display
mov bh,0 ;Page 0
mov al,0 ;Letter D
mov cx,0
mov cl,39d
sub cl,ssi
mov bl,00h ;Green (A) on white(F) background
int 10h 
   samerow22:
   mov row2,1
   setcursor col2,row2
   mov ah,2
   mov dl,al
   int 21h
   jmp repeat2

; miu:
; mov gaya,1h
ret
  chatingame endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

draw_img proc
    jmp Start_img
      Drawit_img:
               mov ah,0Dh
               mov bh,0
               int 10h
               mov bx,sI
               mov [bx],al
               MOV AH,0Ch          
               mov al, [DI]       
               cmp al,31  
               jz  Start_img
               MOV BH,00h  
               INT 10h  
               
      Start_img:   
               inc si
               inc DI
               DEC Cx               
               cmp cx,[x]
               JNZ Drawit_img
               MOV CX, img_sizeX
               add CX, [x]
       
               DEC DX 
               cmp dx,[y]
               jnz Drawit_img
               ret
draw_img endp

draw_gun proc
    jmp Start_gun
      Drawit_gun:  
               mov ah,0Dh
               mov bh,0
               int 10h
               mov bx,sI
               mov [bx],al
               MOV AH,0Ch          
               mov al, [DI]       
               cmp al,31  
               jz  Start_gun
               MOV BH,00h  
               INT 10h  
               
      Start_gun:   
               inc si
               inc DI
               DEC Cx               
               cmp cx,[x_gun]
               JNZ Drawit_gun
               MOV CX, img_sizeX
               add CX, [x_gun]
       
               DEC DX 
               cmp dx,[y_gun]
               jnz Drawit_gun
               ret
draw_gun endp

gun_hit proc
    cmp ah,4dh
    jne left
    mov bx,[x_gun]
    cmp bx,308
    jb move_right
    jmp far ptr end_gun_hit
    move_right:
    add bx,3
    mov x_gun,bx
    left:
    cmp ah,4bh
    jne up
    mov bx,[x_gun]
    cmp bx,3
    ja move_left
    jmp far ptr end_gun_hit
    move_left:
    sub bx,2
    mov x_gun,bx
    up:
    cmp ah,50h
    jne down
    mov bx,[y_gun]
    cmp bx,188
    jb move_up
    jmp far ptr end_gun_hit
    move_up:
    add bx,3
    mov y_gun,bx
    down:
    cmp ah,48h
    jne end_gun_hit
    mov bx,[y_gun]
    cmp bx,2
    ja move_down
    jmp far ptr end_gun_hit
    move_down:
    sub bx,3
    mov y_gun,bx
    end_gun_hit:
    ret
gun_hit endp

if_shoot proc
mov cx,[x_gun]
mov dx,[y_gun]
        cmp cx,[x]
               jnc  k_if_shoot
               jmp end_if_shoot
      k_if_shoot:
               mov ax,[x]
               add ax,15
               cmp cx,ax
               jc con_1_if_shoot
               jmp end_if_shoot
      con_1_if_shoot:
               cmp dx,[y]
               jnc con_2_if_shoot
               jmp end_if_shoot
      con_2_if_shoot:
               mov ax,[y]
               add ax,15
               cmp dx,ax
               jnc end_if_shoot
               mov ax,[flying_value]
               dec ax
               cmp ax,1
               jc  ENDING2
               mov flying_value,ax
               jmp end_if_shoot
               ENDING2:
               mov run,0
    end_if_shoot:
    ret
if_shoot endp

shoot_game PROC 
               mov ax, @data
               mov DS, ax
               mov ax,0A000h
               mov es,ax
               mov ah,0                  ;Graphic Mode
               mov al,13h
               int 10h
               
      beginmain:
               mov ax,initial_x
               mul [multiplier]
               add ax,100
               mov initial_x,ax
               mov x,ax
               mov multiplier,ax
               cmp ax,305
               jbe init_y
      dec_ix:  sub ax,350
               cmp ax,305
               ja dec_ix
               mov initial_x,ax
               mov x,ax
      init_y:  mov ax,initial_y
               mul [multiplier]
               add ax,100
               mov initial_y,ax
               mov y,ax
               mov dx,ax
               add dx,200
               add dx,[multiplier]
               mov multiplier,dx
               cmp ax,185
               jbe stgame
      dec_iy:  sub ax,240
               cmp ax,185
               ja dec_iy
               mov initial_y,ax 
               mov y,ax
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
      stgame:
               mov run,1
               mov di,0
            ;    mov al,03h               
            ;    mov cx,0fa00h
            ;    Rep stosb
            drawlinehor 0,198,64000
               mov al,shoot_level
               cmp al,1
               jnz st2
               mov flying_value,3
               jmp initial
      st2:     cmp al,2
               jnz st3
               mov flying_value,4
               jmp initial
      st3:     cmp al,3
               jnz st4
               mov flying_value,5
               jmp initial
      st4:     mov flying_value,7
               jmp initial
      initial:
               mov ax,[x]
               cmp ax,308
               jb x_in_b
               mov bool_x,1
            x_in_b:
               cmp ax,12
               ja x_in_m
               mov bool_x,0
            x_in_m:
                cmp bool_x,0
                jne dec_x
                add ax,7
                mov x,ax
                jmp y_b
            dec_x:
                sub ax,7
                mov x,ax
            y_b:
               mov ax,[y]
               cmp ax,188
               jb y_in_b
               mov bool_y,1
            y_in_b:
               cmp ax,12
               ja y_in_m
               mov bool_y,0
            y_in_m:
                cmp bool_y,0
                jne dec_y
                add ax,4
                mov y,ax
                jmp p_img
            dec_y:
                sub ax,4
                mov y,ax
      p_img:   MOV CX, img_sizeX
               add CX, [x]
               MOV DX, img_sizeY
               add dx, [y]
               mov al,shoot_level
               cmp al,1
               jnz l2
               mov DI, offset g_img
               mov si, offset bg
               jmp Start
      l2:      cmp al,2
               jnz l3
               mov DI, offset b_img
               mov si, offset bg
               jmp Start
      l3:      cmp al,3
               jnz l4
               mov DI, offset y_img
               mov si, offset bg
               jmp Start
      l4:      mov DI, offset r_img
               mov si, offset bg
               jmp Start
      ENDING1: 
               mov cx,[x]
               mov dx,[y]
               mov initial_x,cx
               mov initial_y,dx
               jmp Start1
      
      chk1:                         
               shr cx,1
               cmp cx,[x]
               jnc  k
               jmp return
      k:       mov ax,[x]
               add ax,15
               cmp cx,ax
               jc con_1
               jmp return
      con_1:
               cmp dx,[y]
               jnc con_2
               jmp return
      con_2:
               mov ax,[y]
               add ax,15
               cmp dx,ax
               jnc return
               mov ax,[flying_value]
               dec ax
               cmp ax,1
               jc  ENDING1
               mov flying_value,ax
               jmp return
      initial1:
               jmp initial
      Start:  
      call draw_img
        mov DI, offset gun_img
        mov si, offset bg
      MOV CX, img_sizeX
        add CX, [x_gun]
        MOV DX, img_sizeY
        add dx, [y_gun]
        call draw_gun

                mov count1,0ffffh
                mov count2,0002h
      lbl:     
               mov ah,1
               int 16h
               jz cont_loop
               mov ah,0
               int 16h
               cmp al,20h
               je shoot
               call gun_hit
               jmp cont_loop
               shoot:
               call if_shoot
            cont_loop:
               dec count1
               jnz lbl
               mov count1,0ffffh

               dec count2
               jnz lbl
               mov ah,1
               int 16h
               cmp al,20h
               jnz  return
               jmp chk1
      return:
      start1:      
               mov di,0
            ;    mov al,03h               
            ;    mov cx,0fa00h
            ;    Rep stosb
            drawlinehor 0,198,64000
               mov ah,02h
               mov dl,0
               mov dh,24d
               mov bh,0h
               int 10h
               mov ah,3h
                mov bh,0h
                int 10h
               mov ah, 9
                mov dx, offset msg_hits
                int 21h
                mov ah,3h
                mov bh,0h
                int 10h
                mov ax,[flying_value]
                mov dl,al
                add dl,30h
                mov ah,2
                int 21h
               mov ax,run
               cmp ax,0
               jz  ENDING

               jmp far ptr initial1

      ENDING:  
               inc shoot_level
                mov bx,offset score1
                call getValue
                add dx,flying_value
                convString2 dl,score1
               ;jmp beginmain
               ret
shoot_game ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

startmain proc
 loop1: 
     
       ;clearing screen and set the cursor
       clearScreen
       mov dh,0  
       mov dl,0
       mov bh,0
       mov ah,2
       int 10h  
       
       ;show message 1
       push dx 
       mov dx,offset msg1
       mov ah,9
       int 21h 
       
       ;get the username  
       getname firstname  
       pop dx 
       add dh,2
       inc dl
       push dx
       mov ah,2
       int 10h  
                  
       
       ;check the validty of the username 
       mov found,0d
       checkValidityforchar firstname[0],found
       cmp found,1d
       je loop1
       
                  
       ;show the username
       mov dx,offset firstname
       mov ah,9
       int 21h
       pop dx  
       add dh,2
       mov dl,0
       mov ah,2
       int 10h 
       push dx 
       
       ;check the validty of the username
       
      
       
     
            ;show message 2
            mov dx,offset msg2
            mov ah,9
            int 21h 
       
       ;get the intial score 
       getnum incialscore 
       pop dx
       add dh,2
       mov dl,0
       mov ah,2 
       push dx
       int 10h  
       
       ;show the intial score
       twobit incialscore
       
       ;set the cursor
       pop dx
       add dh,2
       mov dl,0
       mov ah,2  
       int 10h  
       
       ;show message 6
       mov dx,offset msg6
       mov ah,9
       int 21h 
       
       ;get the enter key
       loop6:
            mov ah,07
            int 21h
            cmp al,13d
            ; je loop111
            jne loop6
                  clearScreen    
       ;get the info of second player

       convString2 incialscore, score1


mov si,offset score1
mov di,offset score2
call srdata
mov si,offset firstname
mov di,offset secondname
call srdata
    mov bx,offset score1
    call getvalue
    mov incialscore,dl
    ;mov ,dl
    mov bx,offset score2
    call getvalue
    mov incialscore2,dl

;     call getValueOfString
;     mov incialscore,dl
;     mov bx,offset score2
;     mov cx,2
;     call getValueOfString
;     mov incialscore2,dl

; ;convString2h incialscore,score1
; ;convString2h incialscore2,score2
; mov dl,incialscore
; mov dh,incialscore2
mov dh,[incialscore]
mov dl,[incialscore2]
cmp dl,dh
ja sc1
mov finalincialscore,dl
convString2 dl,score1
convString2 dl,score2
jmp loop111
sc1:
mov finalincialscore,dh
convString2 dh,score1
convString2 dh,score2
; clearScreen
; setcursor 0,0
; mov dx,offset score2
;  mov ah,9
; int 21h
; setcursor 0,1
; mov dx,offset secondname
;  mov ah,9
; int 21h
;jmp far ptr exitmainproc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

       loop111: 
       loop_to_start_main:

       ;clearing screen and set the cursor
       clearScreen
       mov dh,0  
       mov dl,0
       mov bh,0
       mov ah,2
       int 10h  
       
       ;show message 1
            
       ;clearing screen and set the cursor
           contmain: 
           pop ax
           clearScreen
            mov dh,0  
            mov dl,0
            mov bh,0
            mov ah,2
            int 10h   
       
       
       ;drawing horizontal line
      
       mov dl,0
       mov dh,22d
       mov ah,2
       int 10h

       call drawHorizontalLine
     
        
       ;show message 3 
       mov dl,20d
       mov dh,5d
       mov ah,2
       int 10h   
       mov dx,offset msg3
       mov ah,9
       int 21h 
       
       ;show message 4 
       mov dl,20d
       mov dh,8d
       mov ah,2
       int 10h   
       mov dx,offset msg4
       mov ah,9
       int 21h  
       
       ;show message 5
       mov dl,20d
       mov dh,12d
       mov ah,2
       int 10h   
       mov dx,offset msg5
       mov ah,9
       int 21h 
       
       ;know what key was entered 
       loop9:
       
        mov ah, 1
        int 16h 
        jnz np
    jmp far ptr recievee
    np:
        mov ah,0
        int 16h
        call send_inv_proc
        cmp ah, 3bH
        je chatting
        cmp ah, 3CH
        jne next
        jmp   gaming
        
        next:
            cmp ah, 01h
            jne recievee
            jmp far ptr  exitmainproc
        
       chatting:
       cmp your_chat_inv,1
       jne send_ch_inv
       call chattingproc
       jmp far ptr loop_to_start_main
send_ch_inv:
    setcursor 0,23
    mov ah, 9
    mov dx, offset send_chat_invitation
    int 21h
    mov ah,9
    mov dx, offset secondname
    int 21h
    mov my_chat_inv,1
    jmp far ptr loop9

gaming:
 cmp your_game_inv,1
       jne send_gm_inv
      mov switch,0ffh
      jmp far ptr gamemood
send_gm_inv:
    setcursor 0,23
    mov ah, 9
    mov dx, offset send_game_invitation
    int 21h
    mov ah,9
    mov dx, offset secondname
    int 21h
    mov my_game_inv,1
    jmp far ptr loop9

    recievee:
    mov dx , 3FDH ; Line Status Register
    in al , dx
    AND al , 1
    jnz f_recievee
    jmp far ptr loop9
f_recievee:
    ;If Ready read the VALUE in Receive data register
    mov dx , 03F8H
    in al , dx
    mov ah,2
    mov dl,al
    int 21h
    cmp al,3bH
    jne check_cont
        cmp my_chat_inv,1
        jne recieve_ch_inv
       call chattingproc
       jmp far ptr loop_to_start_main
recieve_ch_inv:
    setcursor 0,24
    mov ah, 9
    mov dx, offset secondname
    int 21h
    ; mov dl,ssi+1
    ; mov ah,2
    ; int 21h
    mov al,0
    mov di, offset secondname
    str_len:
    mov ah,[di]
    inc al
    inc di
    cmp ah,'$'
    jne str_len
    mov temp_col,al
    setcursor temp_col,24
    mov dx, offset recieve_chat_invitation
    mov ah,9
    int 21h
    mov your_chat_inv,1
    jmp far ptr loop9


 check_cont:
      
    cmp al,3cH
    jne escpase_main
    cmp my_game_inv,1
        jne recieve_gm_inv
      jmp far ptr gamemood
       jmp far ptr loop_to_start_main
recieve_gm_inv:
    setcursor 0,24
    mov ah, 9
    mov dx, offset secondname
    int 21h
    ; mov dl,ssi+1
    ; mov ah,2
    ; int 21h
    mov al,0
    mov di, offset secondname
    str_lenn:
    mov ah,[di]
    inc al
    inc di
    cmp ah,'$'
    jne str_lenn
    mov temp_col,al
    setcursor temp_col,24
    mov dx, offset recieve_game_invitation
    mov ah,9
    int 21h
    mov your_game_inv,1
    jmp far ptr loop9

escpase_main:
cmp al,01h
je lb
jmp far ptr loop9
lb:
mov ah,al
jmp far ptr  exitmainproc


       ;game mode 
       gamemood:
       cont_gamemood:
           clearScreen
           cmp switch,00H
           je select_level
           jmp far ptr level1
           select_level:
           mov dh,0  
           mov dl,0
           mov bh,0
           mov ah,2
           int 10h
           mov dx,offset msg14
           mov ah,9
           int 21h 
           ;show message 15 
           mov dl,20d
           mov dh,5d
           mov ah,2
           int 10h   
           mov dx,offset msg15
           mov ah,9
           int 21h 
           
           ;show message 16 
           mov dl,20d
           mov dh,8d
           mov ah,2
           int 10h   
           mov dx,offset msg16
           mov ah,9
           int 21h 
           loop13:    
               mov ah,00H
               int 16h
               mov level,al
               cmp al,49d  ;level one
               je level1
               cmp al,50d
               je level1
               jne loop13
            ;    clearScreen
            ;    mov dh,0  
            ;    mov dl,0
            ;    mov bh,0
            ;    mov ah,2
            ;    int 10h
            ;    mov dx,offset msg17
            ;    mov ah,9
            ;    int 21h  
            ;    jmp exitmainproc
           
           
           
           
           level1:
               clearScreen
               cmp switch,0
               jne loop14
               mov dh,0  
               mov dl,0
               mov bh,0
               mov ah,2
               int 10h
               mov dx,offset msg18
               mov ah,9
               int 21h 
               mov ah,07
               int 21h
               mov forbiddenchar1,al
               mov found,0d
               checkValidityforforbiddenchar forbiddenchar1,found
               cmp found,1d
               je level1
               jmp send_level_fchar
               
               loop14:
                   clearScreen
                   mov dh,0  
                   mov dl,0
                   mov bh,0
                   mov ah,2
                   int 10h
                   mov dx,offset msg19
                   mov ah,9
                   int 21h 
                   mov ah,07
                   int 21h
                   mov forbiddenchar2,al
                   mov found,0d
                   checkValidityforforbiddenchar forbiddenchar2,found
                   cmp found,1d
                   je loop14
                   ;cmp level,49
                   ;jne fill_regs
                   jmp far ptr send_level_fchar
                ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                send_level_fchar:
                cmp switch,00H
                   jne re_level
                ;    mov dx , 3FDH ; Line Status Register
                ;     se_level_AGAIN: In al , dx ;Read Line Status
                ;     AND al , 00100000b
                ;     JZ se_level_AGAIN
                ;     ;If empty put the VALUE in Transmit data register
                ;     mov dx , 3F8H ; Transmit data register
                ;     mov al,level
                ;     out dx , al
                    mov si,offset level
                    mov di,offset temp_level
                    call srdata
                    mov si,offset forbiddenchar1
                    mov di,offset forbiddenchar2
                    call srdata
                    jmp far ptr fill_regs

                   re_level:
                   mov si,offset temp_level
                    mov di,offset level
                    call srdata
                    mov si,offset forbiddenchar2
                    mov di,offset forbiddenchar1
                    call srdata
                    ; mov si,offset registers
                    ; mov di,offset lev2_registers
                    ; call srdata
                    push bx
                    mov bl,forbiddenchar1
                    mov bh,forbiddenchar2
                    mov forbiddenchar1,bh
                    mov forbiddenchar2,bl
                    pop bx
                
                fill_regs:
                cmp level,50
                je fill_regs1
                jmp far ptr exitmainproc
                fill_regs1:
                clearScreen
                   mov dh,0  
                   mov dl,0
                   mov bh,0
                   mov ah,2
                   int 10h
                   mov bl,6
                   mov bh,8
                   mov si,offset reg_labels
                   mov di,offset registers
                reg_nums:
                   mov ah,2
                    mov dl,[si]
                    int 21h
                    inc si
                    dec bl
                    jnz reg_nums
                    mov bl,4
                enter_v_reg:
                    mov ah,07
                    int 21h
                    mov ah,2
                    mov dl,al
                    int 21h
                    mov [di],al
                    inc di
                    dec bl
                    jnz enter_v_reg
                    mov bl,6
                    dec bh
                    jnz reg_nums


                ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                   
                ;    mov dx , 3FDH ; Line Status Register
                ;     re_level_CHK: in al , dx
                ;     AND al , 1
                ;     JZ re_level_CHK
                ;     ;If Ready read the VALUE in Receive data register
                ;     mov dx , 03F8H
                ;     in al , dx
                ;     mov level , al
                ;     mov ah, 9
                ;     mov dx, offset send_chat_invitation
                ;     int 21h
                send_recieve_reg:
                    cmp level,50
                    jne exitmainproc
                    mov si,offset registers
                    mov di,offset lev2_registers
                    call srdata
                    mov si,offset registers
                    mov di,offset lev2_registers
                    add si,32d
                    mov cx,32
                f_regs:
                    mov al,[di]
                    mov [si],al
                    inc di
                    inc si
                    loop f_regs

;jmp far ptr loop9  
exitmainproc:
    mov return_value,0ffh

startmain endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


main proc far  
    cmp return_value,0ffh
    je returned_successfully
    mov ax,@data
    mov ds,ax 
    initialise
    call startmain
returned_successfully:
cmp ah,01h
jne cont_returned_successfully
jmp far ptr exitmain
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cont_returned_successfully:
mov ax,0a000h
mov es,ax

mov ah,0;video mode
mov al,13h
int 10h

convString2 finalincialscore, score1
convString2 finalincialscore, score2

drawlinehor 0,198,64000;background
drawlinehor 0,00,6400;background
mov row,3d
mov col,20d
mov al,0
mov ax,0000h
drawmem:setcursor col,row
mov cx,1
push ax
mov bx,offset char
 xlat   
 mov bl,92h
 mov ah,9
int 10h ;drawchar
pop ax
inc al
add row,1
cmp al,10h
jnz drawmem
mov si,offset p1_img
            mov di,5
        d_up:      
            p_p_up p_up_x,p_up_y
            ;add si,100
            add p_up_x,12
            dec di
            jnz d_up
updateall

 mov al,0
mov di, offset firstname
str_len3:
mov ah,[di]
inc al
inc di
cmp ah,'$'
jne str_len3
mov fsi,al

mov al,0
mov di, offset secondname
str_len2:
mov ah,[di]
inc al
inc di
cmp ah,'$'
jne str_len2
mov ssi,al
mov col,0
mov row,0
mov begin,0
mov colour,84h
drawstring col,row,20,firstname,colour,begin
mov cl,fsi
inc cl
mov col1,cl
mov row1,0

mov col,0
mov row,1
mov begin,0
drawstring col,row,20,secondname,colour,begin


mov cl,ssi
mov col2,cl
mov row2,1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; mov switch,0ffh
    gameloop:
    dec game_count
    jnz gameloop2
    mov al,4
    mov game_count,al
    call Shoot_game
    mov si,offset score1
    mov di,offset score2
    call srdata
gameloop2:
    ;after_shoot_game:
    updateall
    call chatingame
    ; mov si, offset switch
    ; not byte ptr [si]
gameloop1:
cmp switch,00H
je my_round
mov col,24d
mov row,19d
drawrectangle 
mov si,offset temp_command
mov di,offset command
call srdata
setcursor 24d,19d
mov ah, 9
mov dx, offset command
int 21h
jmp  far ptr cont_round
my_round:
    displaycommand switch
    mov si,offset command
    mov di,offset temp_command
    call srdata
cont_round:
    cmp level,50
    jne ginlevelone
    cmp switch,0
    jne recieve_wheretoexecute
    mov ah,0
    int 16h
    mov wheretoexecute,al
    mov si,offset wheretoexecute
    mov di,offset temp_wheretoexecute
    call srdata
    jmp ginlevelone
    recieve_wheretoexecute:
    mov si,offset temp_wheretoexecute
    mov di,offset wheretoexecute
    call srdata
ginlevelone:
    removeEnter  command
    convertLower command
    
    convertLower forbiddenchar1
    convertLower forbiddenchar2

    mov ah, byte ptr [command]
    mov al, byte ptr [command+1]
    cmp ax,'p1'
    je cont_p1
    jmp cont_p_2
cont_p1:
    cmp switch,00H
    jne p1_p2
    mov bx,offset score1
    call getValue
    ;call getValueOfString
    cmp dx,5
    jae lbl_p1_1
    jmp gameloop
lbl_p1_1:
    push dx
    call p_1
    pop dx
    sub dx,5
    convString2 dl,score1
    jmp upd
p1_p2:
    mov bx,offset score2
    ; mov cx,2
    call getValue
    cmp dx,5
    jae lbl_p2_1
    mov si, offset switch
    not byte ptr [si]
    jmp gameloop
lbl_p2_1:
    push dx
    call p_1
    pop dx
    sub dx,5
    convString2 dl,score2
    jmp upd

cont_p_2:
    cmp ax,'p2'
    je cont_p2
    jmp cont_p_3
cont_p2:
    cmp switch,00H
    jne p2_p2
    mov bx,offset score1
    ; mov cx,2
    call getValue
    cmp dx,3
    jae lbl_p1_2
    jmp gameloop
lbl_p1_2:
    push dx
    call p_2
    pop dx
    sub dx,3
    convString2 dl,score1
    jmp upd
p2_p2:
    mov bx,offset score2
    ; mov cx,2
    call getValue
    cmp dx,3
    jae lbl_p2_2
    mov si, offset switch
    not byte ptr [si]
    jmp gameloop
lbl_p2_2:
    push dx
    call p_2
    pop dx
    sub dx,5
    convString2 dl,score2
    jmp upd
cont_p_3:
    cmp ax,'p3'
    je cont1_p_5
    jmp cont_p_5
    cont1_p_5:
    p_3
    jmp end_power_up
cont_p_5:
    cmp ax,'p5'
    je ex_pu5
    jmp cont_game
ex_pu5:
    p_5
    jmp end_power_up

; cont_p_6:
;     cmp level,50
;     jne cont_game
;     cmp ax,'p6'
;     je ex_pu6
;     jmp cont_game
; ex_pu6:
;     call p_6

end_power_up:
mov si, offset switch
    not byte ptr [si]
    updateall
    jmp far ptr gameloop1

cont_game:
    cmp wheretoexecute,31h
    je contaslevelone
    mov si, offset switch
    not byte ptr [si]
contaslevelone:
    mov found,0

    cmp switch,00H
    je p1
    jne p2
    p1:
    checkValidity command,forbiddenchar2,found
    cmp found,1
    je minus1
    jmp ex
    minus1:
    mov bx,offset score1
    call getValue
    dec dx
    convString2 dl,score1
    
    jmp upd

    p2:
    checkValidity command,forbiddenchar1,found
    cmp found,1
    je minus2
    jmp ex
    minus2:
    mov bx,offset score2
    call getValue 
    dec dx
    convString2 dl,score2
    jmp upd

    ex:
    mov bx, offset command
    call Execute

    
    upd:
    updateall
    cmp wheretoexecute,31h
    je exitleveltwo
    mov si, offset switch
    not byte ptr [si]
    exitleveltwo:
    mov si, offset switch
    not byte ptr [si]
 mov ax,word ptr score1
    cmp ax,'00'
    jne notwin
    jmp far ptr secondwin
    notwin:
    mov ax,word ptr score2
    cmp ax,'00'
    jne notwin2

    jmp far ptr firstwin

    notwin2: 

    mov ax,@data
    mov es,ax
   
     mov si, offset registers
     mov di,offset desired
     mov bx,0
iswin:
push si
      mov cx,4
    repe cmpsb
    cmp cx,0
    ja notequal

    
    cmp bx,8
    jb secondwin
    jae firstwin
notequal:
pop si
add si,4
mov di,offset desired
inc BX
cmp bx,16d
    jb iswin
    jmp gameloop
thewinner:
    cmp cx,8
    jc secondwin
    jmp firstwin


    jmp gameloop

    secondwin:
        mov ah,0
        mov al,3
        int 10h
        clearScreen
         mov dx,offset msg20
       mov ah,9
       int 21h 
        mov dx,offset secondname
       mov ah,9
       int 21h
        jmp exitmain

    firstwin:
    mov ah,0
        mov al,3
        int 10h
        clearScreen
     mov dx,offset msg20
       mov ah,9
       int 21h 
        mov dx,offset firstname
       mov ah,9
       int 21h
        jmp exitmain
       
 exitmain: 
 ;clearScreen
 hlt
 main endp 
 end main