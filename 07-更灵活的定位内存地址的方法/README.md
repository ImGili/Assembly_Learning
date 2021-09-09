# or 和 and指令

``and al, 10111111B`` 将``al``和``10111111B``做并运算，这个指令是指将al的第六位置0。

``or al, 00100000B`` 将``al``和``10111111B``做或运算，这个指令是指将al的第5位置1。

# ASCII码
字符安装ASCII编码成16进制数，显卡按照ASCII码进行解密，在屏幕上显示字符。

# 以字符的形式给出数据
```nasm
assume cs:codesg, ds:datasg
datasg segment
    db 'unIX'
data  ends
```

# 大小写字母转换问题
> 不需要判断语句，也不需要对字符的ascii码进行加减，**只需要将数据的第5位置0，就变成大写，第5位置1，就变成小写**

将第一个字符串全部变成大写，将第二个字符串全部变成小写。

1.asm

```nasm
assume cs:codesg, ds:datasg
datasg segment
    db  'Basic'
    db  'MinIX'
datasg ends

codesg segment

start:  mov ax, datasg
        mov ds, ax

        mov bx, 0
        mov cx, 5
    s:  mov al, [bx]
        and al, 11011111B
        mov [bx], al
        inc bx
        loop s

        mov bx, 5
        mov cx, 3
    s0:  mov al, [bx]
        or al, 00100000B
        mov [bx], al
        inc bx
        loop s0

    mov ax, 4c00h
    int 21h

codesg ends

end start
```
# 用[bx+idate]大方式进行数组处理
可简化以上程序

```nasm
assume cs:codesg, ds:datasg
datasg segment
    db  'Basic'
    db  'MinIX'
datasg ends

codesg segment

start:  mov ax, datasg
        mov ds, ax

        mov bx, 0
        mov cx, 5
    s:  mov al, [bx]
        and al, 11011111B
        mov [bx], al
        mov al, [bx+5]
        or al, 00100000B
        mov [bx+5], al
        inc bx
        loop s

    mov ax, 4c00h
    int 21h

codesg ends

end start
```