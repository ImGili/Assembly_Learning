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
    dec.cp[0] = 'V';
    dec.cp[1] = 'A';
    dec.cp[2] = 'X';
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





