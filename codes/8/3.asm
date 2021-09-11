/*
 * @Author: ImGili
 * @Description: div和dd指令的综合应用
    第一个数据（dword）除以第二个数据（word）的结果，保存到第三个数据中（word）
 */

assume cs:codesg, ds:datasg

datasg segment
dd 100001
dw 100
dw 0
datasg ends

codesg segment
    start:  mov ax, datasg
            mov ds, ax

            mov ax, ds:[0]
            mov dx, ds:[2]

            div word ptr ds:[4]

            mov ds:[6], ax

            mov ax, 4c00h
            int 21h
codesg ends
end start