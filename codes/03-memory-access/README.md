# 内存访问
# DS和[address]
DS 是存放[address]数据段段段地址， address这个就是数据段偏移地址。

DS寄存器不能直接赋值，而是需要通过通用寄存器来间接赋值。
```nasm
mov ax, 1000
mov ds, ax
```

# 栈
SS寄存器控制栈顶的段寄存器，SP寄存器控制偏移地址。

# push和pop
push指令可以使得sp寄存器加1，pop可以使得sp减1。
```nasm
push ax
pop bx
```