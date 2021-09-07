assume cs : codesg
codesg segment

        mov ax, 0
        mov cx, 456
s:      add ax, 123
        loop s
        int 21H
codesg ends
end