# 程序直接崩溃，无响应
assume cs:code
code segment
    mov ax, 0
    mov ds, ax
    mov ds:[0026h], ax

    mov ax, 4c00h
    int 21h
code ends
end