# bx,si,di和dp
能用在``[...]``中的寄存器只有``bx si di dp``

``dp``寄存器出现在``[...]``中默认段寄存器是ss

其他默认段寄存器就是ds

# 机器指令处理的数据在什么地方
``mov bx, [0]`` 在内存里

``mov bx, ax`` 在寄存器里

``mov bx, 1``  在指令缓冲器中


# 指令要处理的数据有多长
汇编中就两种数据长度： 字和字节。

## 当给出寄存器时

以下是进行字操作
```nasm
mov ax, 1
mov ax, bx
```

以下是进行字节操作
```nasm
mov al, 1
mov al, bl
```

## 显示的给出数据长度

```nasm
mov word ptr ds:[0], 1
mov byte ptr ds:[0], 1
```

## 只有push时
push只能进行字操作
```nasm
push bx
```

# 寻址方式的综合应用
有这么一家公司
公司名称： DEC
总裁：Ken Olen
排名：137
收入：40（40亿美元）
著名产品：PDP（小型计算机）

将这些数据存放在内存中，并完成以下修改
（1）排名改为38名
（2）DEC收入增加70亿
（3）著名产品变为VAX系列计算机

在数据中的首地址为``60h``

普通风格的内存访问模式
```nasm
    mov ax, datasg
    mov ds, ax

    mov ax, stacksg
    mov ss, ax
    mov sp, 0

    mov bx, 60h
    ; 排名上升38名
    mov word ptr [bx+12], 38
    ; 收入上升70亿
    add word ptr [bx+14], 70

    ; 著名产品变成VAX
    mov si, 0
    mov byte ptr [bx+16+si], 'V'
    inc si

    mov byte ptr [bx+16+si], 'A'
    inc si

    mov byte ptr [bx+16+si], 'X'
    inc si
```

参考c语言结构体风格

```c
struc company
{
    char cn[3];
    char hn[9];
    int pm;
    int sr;
    char cp[3];
};

struct company dec = {"DEC", "Ken Olen", 137, 40, "PDP"};

int main()
{
    dec.pm = 38;
    dec.sr += 70;
    int i = 0;
    dec.cp[i] = 'V';
    i++;
    dec.cp[i] = 'A';
    i++;
    dec.cp[i] = 'X';
    i++;
}

```

> 以``[bx].idata[si]``的形式，以结构化形式访问内存。


2.asm
```nasm
    mov ax, datasg
    mov ds, ax

    mov ax, stacksg
    mov ss, ax
    mov sp, 0

    mov bx, 60h
    ; 排名上升38名
    mov word ptr [bx].12, 38
    ; 收入上升70亿
    add word ptr [bx].14, 70

    ; 著名产品变成VAX
    mov si, 0
    mov byte ptr [bx].16[si], 'V'
    inc si

    mov byte ptr [bx].16[si], 'A'
    inc si

    mov byte ptr [bx].16[si], 'X'
    inc si

```

# div指令
被除数的数据长度是除数的两倍，商和余数和除数的数据长度相同。

除数是8位，则被除数默认保存在ax中，商保存在al中，余数保存在ah中

除数是16位，则被除数低16位保存在ax中，高16位保存在dx中，最后商会保存在ax中，余数保存在dx中

例：

div byte ptr ds:[0]

含义为：
$$
(al)=\frac{(ax)}{(ds)*16+0}的商\\

(ah)=\frac{(ax)}{(ds)*16+0}的余数
$$

div word ptr ds:[0]

含义为：
$$
(ax)=\frac{(dx)\times10000H+(ax)}{(ds)*16+0}的商\\

(dx)=\frac{(dx)\times10000H+(ax)}{(ds)*16+0}的余数
$$

# 伪指令dd
含义是存储一个double word类型的数据（32位）

例：

```nasm
assume cs:codesg, ds:datasg

datasg segment
dd 100001
dw 100
dw 0
datasg ends

codesg segment
    start:  mov ax, datasg
            mov ds, ax

            mov ax, ds:[0]
            mov dx, ds:[2]

            div word ptr ds:[4]

            mov ds:[6], ax

            mov ax, 4c00h
            int 21h
codesg ends
end start
```

# dup指令
重复的意思

``
; 重复两百个0字节
db 200 dup (0)
``