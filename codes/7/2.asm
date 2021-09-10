/*
 * @Author: ImGili
 * @Description: 利用[bx+idata]内存访问方式，简化代码。
 */

assume cs:codesg, ds:datasg
datasg segment
    db  'Basic'
    db  'MinIX'
datasg ends

codesg segment

start:  mov ax, datasg
        mov ds, ax

        mov bx, 0
        mov cx, 5
    s:  mov al, [bx]
        and al, 11011111B
        mov [bx], al
        mov al, [bx+5]
        or al, 00100000B
        mov [bx+5], al
        inc bx
        loop s

    mov ax, 4c00h
    int 21h

codesg ends

end start