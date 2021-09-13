/*
 * @Author: ImGili
 * @Description: 检测点9.3
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
            inc cx ; loop指令是先将cx-1，在判断cx是否为0。
            inc bx
            loop s

        
        ok: dec bx
            mov dx, bx

            mov ax, 4c00h
            int 21h
codesg ends
end start