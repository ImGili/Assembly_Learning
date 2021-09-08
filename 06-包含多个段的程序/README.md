# 包含多个段的程序
# 在代码段中使用栈
这个程序将数据和栈放在了代码段（cs）中，其功能是将数据逆序排列

这里使用end start规定了代码的入口，即代码段便宜地址ip的起始位置。
1.asm
```nasm
assume cs:codesg
codesg segment
    dw 0123h, 0456h, 0789h, 0abch, 0defh, 0fedh, 0cbah, 0987h
    dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ;这里多加了16个字数据，是因为pus操作会多向栈里添加几个字的数据

start:  mov ax, cs
        mov ss, ax
        mov sp, 30h

        mov bx, 0
        mov cx, 8
    s:  push cs:[bx]
        add bx, 2
        loop s

        mov bx, 0
        mov cx, 8
    s0: pop cs:[bx]
        add bx, 2
        loop s0

        mov ax, 4c00h
        int 21h
codesg ends

end start
```

# 将数据、栈和代码放入不同的段中
上面是将数据、栈和代码都放进了代码段，然而一个段地址最多只能存放64KB（偏移地址16位，即最大地址数位$2^{16}$，所以是$\frac{2^{16}}{2^{10}}=2^{6}=64KB$的数据，一个数据是一个B），所以要将数据、代码和栈放在各自不同的段内，以增加数据空间。

> 这里的assume是伪指令，只是声明了段名字，但是cs:code，这里并不对段寄存器进行赋值，只是在表示这个符号和cs有关联

```nasm
assume cs:code, ds:data, ss:stack
data segment
    dw 0123h, 0456h, 0789h, 0abch, 0defh, 0fedh, 0cbah, 0987h
data ends

stack segment
    dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ;这里多加了16个字数据，是因为pus操作会多向栈里添加几个字的数据
stack ends

code segment
start:  mov ax, stack
        mov ss, ax
        mov sp, 30h

        mov ax, data
        mov ds, ax
        
        mov bx, 0
        mov cx, 8
    s:  push [bx]
        add bx, 2
        loop s

        mov bx, 0
        mov cx, 8
    s0: pop [bx]
        add bx, 2
        loop s0

        mov ax, 4c00h
        int 21h
code ends

end start
```
