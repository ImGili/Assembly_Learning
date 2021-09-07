# [BX]和loop指令

# [BX]
5-1.asm
```nasm
assume cs : codesg

codesg segment

        mov ax, 0123H
        mov bx, 0456H
        add ax, [bx]
        add [bx], ax
        
        int 21H
codesg ends

end
```