/*
 * @Author: ImGili
 * @Description: 测试跳转超过边界
 */

assume cs:codesg

codesg segment
    start:  jmp short s
            db 128 dup (0)
        s:  mov ax, 0

            mov ax, 4c00h
            int 21h
codesg ends
end start
