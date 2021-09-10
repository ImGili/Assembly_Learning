/*
 * @Author: ImGili
 * @Description: 将数据段中，每个单词的每个字母转换为大写。
 */

assume cs:codesg, ds:datasg

datasg segment
    db 'ibm'
    db 'dec'
    db 'dos'
    db 'vax'

datasg ends

codesg segment
    start:  mov ax, datasg
            mov ds, ax
            
            mov bx, 0
            mov cx, 4
        s:  mov dx, cx

            mov si, 0
            mov cx, 3
        s0: mov al, [bx+si]
            and al, 11011111B
            mov [bx+si], al
            inc si
            loop s0
            add bx, 3
            mov cx, dx
            loop s

            mov ax, 4c00h
            int 21h

codesg ends
end start