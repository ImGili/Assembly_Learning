assume cs : codesg
codesg segment

        mov ax, 0123H
        mov bx, 0456H
        add ax, [bx]
        add [bx], ax
        
        int 21H
codesg ends
end