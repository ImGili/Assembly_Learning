# 第一个程序
# 源程序
1.asm
```nasm
assume cs : codesg

codesg segment

        mov ax, 0123H
        mov bx, 0456H
        add ax, bx
        add ax, ax
        
        mov ax, 4c00H
        int 21H
codesg ends

end
```
# 编译
```
masm 1.asm
```

# 链接
```
link 1
```

# 调试程序
```
debug 1
```