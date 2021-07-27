# 利用段前缀将ffff:0 b 的数据拷贝到0020:0 b中
assume cs:code
code segment
    mov ax, 0ffffh
    mov ds, ax
    mov ax, 0020h
    mov es, ax
    mov bx, 0
    mov cx, 12
s:  mov dl, [bx]
    mov es:[bx], dl
    add bx, 1
    loop s

    mov ax, 4c00h
    int 21h

code ends
end