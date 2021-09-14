/*
 * @Author: ImGili
 * @Description: 实验9
    简单实现显示一个字符
 */

assume cs:codesg

codesg segment
    start:  mov ax, 0b800h
            mov es, ax

            mov byte ptr es:[0a0H+64], 41H
            mov byte ptr es:[0a0H+65], 02H

            mov ax, 4c00h
            int 21H
codesg ends
end start