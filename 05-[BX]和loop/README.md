# [BX]和loop指令

# [BX]
就是使用寄存器代替偏移地址中的常量
1.asm
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

# loop指令
``s：``代表loop跳转到的指令地址标志位，``loop s``会自动翻译成``jump 0006``如果s对应的指令ip地址为0006
计算123*456
2.asm
```nasm
assume cs : codesg
codesg segment

        mov ax, 0
        mov cx, 456
s:      add ax, 123
        loop s
        int 21H
codesg ends
end
```

# 段前缀
利用段寄存器，显式制定内存地址。
```nasm
mov ax, ds:[0]
mov ax, cs:[0]
mov ax, ss:[0]
mov ax, es:[0]
```

# 一段安全的空间
这段代码会引起dos死机，因为这段地址存放了系统数据，不能修改。
3.asm
```nasm
assume cs : codesg
codesg segment

        mov ax, 0
        mov ds, ax
        mov ds:[26h] ax
        mov ax, 4c00h
        int 21H
codesg ends
end
```

安全的地址段为0:200 ～ 0:2ff