assume cs:codesg, ds:datasg

datasg segment
    db 'welcome to masm!'
datasg ends


codesg segment
    start:  
            mov ax, datasg
            mov ds, ax
            mov ax, 0b800h
            mov es, ax

            mov bx, 10*160+66 ; 第十行，第40列
            mov di, 0
            mov si, 0
            mov cx, 16
        s:  mov al, ds:[di]
            mov ah, 00000010B
            mov es:[bx+si], ax
            inc di
            add si, 2
            loop s
            mov ax, 4c00h
            int 21h
codesg ends
end start