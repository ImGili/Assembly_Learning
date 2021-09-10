/*
 * @Author: ImGili
 * @Description: 
    有这么一家公司
    公司名称： DEC
    总裁：Ken Olen
    排名：137
    收入：40（40亿美元）
    著名产品：PDP（小型计算机）
    将数据存放在内存中，并完成以下修改
    （1）排名改为38名
    （2）DEC收入增加70亿
    （3）著名产品变为VAX系列计算机

    在数据中的首地址为``60h``

    以下是结构化内存访问方式
 */

assume cs:codesg, ds:datasg, ss:stacksg

datasg segment
    dw 0, 0, 0, 0, 0, 0
    dw 0, 0, 0, 0, 0, 0
    dw 0, 0, 0, 0, 0, 0
    dw 0, 0, 0, 0, 0, 0
    dw 0, 0, 0, 0, 0, 0
    dw 0, 0, 0, 0, 0, 0
    dw 0, 0, 0, 0, 0, 0
    dw 0, 0, 0, 0, 0, 0
    db 'DEC'
    db 'Ken Olsen'
    dw 137
    dw 40
    db 'PDP'

    
datasg ends

stacksg segment
    dw 0, 0, 0, 0, 0, 0, 0, 0
stacksg ends

codesg segment
    start:  mov ax, datasg
            mov ds, ax

            mov ax, stacksg
            mov ss, ax
            mov sp, 0

            mov bx, 60h
            ; 排名上升38名
            mov word ptr [bx].12, 38
            ; 收入上升70亿
            add word ptr [bx].14, 70

            ; 著名产品变成VAX
            mov si, 0
            mov byte ptr [bx].16[si], 'V'
            inc si

            mov byte ptr [bx].16[si], 'A'
            inc si

            mov byte ptr [bx].16[si], 'X'
            inc si

            mov ax, 4c00h
            int 21h

codesg ends
end start