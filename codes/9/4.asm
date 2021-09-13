/*
 * @Author: ImGili
 * @Description: 检测点9.2 利用jcxz指令 找到内存中第一个0 并将其便宜地址保存到dx中
 */

assume cs:codesg, ds:datasg
datasg segment
 db 11h, 21h, 00h
datasg ends

codesg segment
    start:  mov ax, datasg
            mov ds, ax
            mov bx, 0
        s:  mov cl, ds:[bx]
            mov ch, 00H
            jcxz ok
            inc bx

            jmp short s
        
        ok: mov dx, bx

            mov ax, 4c00h
            int 21h
codesg ends
end start
