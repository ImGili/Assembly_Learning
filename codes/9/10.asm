/*
 * @Author: ImGili
 * @Description: 实验9，在屏幕中间显示三行welcome to masm!
 */

assume cs:codesg, ds:datasg, ss:stacksg

datasg segment
    db 'welcome to masm!'
    db 02H, 24H, 71H
datasg ends

stacksg segment
    db 16 dup (0)
stacksg ends

codesg segment
    start:  mov ax, datasg
            mov ds, ax

            mov ax, stacksg
            mov ss, ax
            mov sp, 0

            mov ax, 0b800h
            mov es, ax

            mov bx, 0
            mov si, 10h
            mov cx, 3
        s0: push cx
            push si
            mov ah, ds:[si]
            mov cx, 16
            mov si, 0
            add si, 10*160 + 66
            mov di, 1
            add di, 10*160 + 66
            mov bx, 0
        s1: mov al, ds:[bx]
            mov es:[bx+si], al
            mov es:[bx+di], ah
            inc bx
            inc si
            inc di

            loop s1 

            pop si
            pop cx
            inc si
            mov ax, es
            add ax, 0ah
            mov es, ax
            loop s0

            mov ax, 4c00h
            int 21h

codesg ends
end start