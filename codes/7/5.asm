/*
 * @Author: ImGili
 * @Description: 使用内存，临时保存cx数值
 */
assume cs:codesg, ds:datasg

datasg segment
    db 'ibm             '
    db 'dec             '
    db 'dos             '
    db 'vax             '
    db 0
datasg ends

codesg segment
    start:  mov ax, datasg
            mov ds, ax

            mov bx, 0
            mov cx, 4
        s:  mov ds:[40h], cx
            
            mov cx, 3
            mov si, 0
        s0: mov al, ds:[bx+si]
            and al, 11011111B
            mov ds:[bx+si], al
            inc si
            loop s0

            add bx, 16

            mov cx, ds:[40h]
            loop s

            mov ax, 4c00h
            int 21h
codesg ends

end start