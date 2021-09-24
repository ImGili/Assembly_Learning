assume cs:codesg, ss:stacksg

stacksg segment
    db 16 dup (0)
stacksg ends

codesg segment
start:  mov ax, stacksg
        mov ss, ax
        mov sp, 16
        mov ax, 0
        call s
        inc ax
    s:  pop ax
codesg ends
end start