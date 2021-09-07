# 查看汇编将mov al, [1]这条指令编译成什么，其实是mov ax， 0
assume cs:code
code segment
    mov ax, 2000h
    mov ds, ax
    mov al, [0]
    mov bl, [1]
    mov cl, [2]
    mov dl, [3]

    mov ax, 4c00h
    int 21h
code ends
end