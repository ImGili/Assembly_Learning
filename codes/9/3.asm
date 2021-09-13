/*
 * @Author: ImGili
 * @Description: 检测点9.1（2） 跳转到第一条指令
 */

assume cs:codesg, ds:datasg
datasg segment
    dd 12345678H
datasg ends

codesg segment
    start:  mov ax, datasg
            mov ds, ax
            mov bx, 0
            mov word ptr [bx], 0
            mov word ptr [bx+2], cs
            jmp dword ptr ds:[0]
codesg ends
end start