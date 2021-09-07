# 将0-63赋值到0020内存中
assume cs:code
code segment
    mov ax, 0020h
    mov ds, ax
    mov cx, 64 # 0-63应该是循环64次而不是63次（从0开始）
    mov bx, 0
s:  mov ds:[bx], bx
    inc bx
    loop s

    mov ax, 4c00h
    int 21h
code ends
end
    