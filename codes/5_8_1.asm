# 将ffff:0 b的数据复制到0020:0 b中
assume cs:code
code segment

    mov cx,12
    mov bx, 0
s:  mov ax, 0ffffh
    mov ds, ax
    mov dl, [bx]
    mov dh, 0

    mov ax, 0020h
    mov ds, ax
    mov [bx], dx

    add bx, 1

    loop s
    
    mov ax, 4c00h
    int 21h


code ends
end