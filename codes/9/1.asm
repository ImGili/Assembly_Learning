assume cs:codesg

codesg segment
    s:  mov ax, bx
        mov si, offset s
        mov di, offset s0
        mov ax, cs:[si]
        mov cs:[di], ax

    s0: nop         ; nop的机器码是占1个字节
        nop
codesg ends

end s