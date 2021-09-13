/*
 * @Author: ImGili
 * @Description: 检测点9.1（1） 跳转到第一条指令
 */
assume cs:codesg, ds:datasg
datasg segment
    dw 0
datasg ends

codesg segment
    start:  mov ax, datasg
            mov ds, ax
            mov bx, 0
            jmp  word ptr ds:[bx+1]
codesg ends
end start
