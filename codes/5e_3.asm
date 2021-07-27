# 将 mov ax, 4c00h之前的指令复制到内存0020中
assume cs:code
code segment
    mov ax, cs
    mov ds, ax
    mov cx, 25
    mov ax, 0020h
    mov es, ax
    mov bx, 0

s:  mov al, [bx]
    mov es:[bx], al
    add bx, 1

    loop s
    mov ax, 4c00h
    int 21h
code ends
end