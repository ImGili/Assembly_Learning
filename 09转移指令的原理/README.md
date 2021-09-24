# 转移指令的原理
**将修改ip、或者同时修改ip和cs的指令统称为转移指令**

只修改ip的指令称之为段内转移，如 jmp ax

同时修改ip和cs的指令称之为段间转移，如 jmp 1000:0

# 操作符offset
操作符offset，获取标记的偏移地址

``start: mov ax, offset start``相当于 ``start: mov ax, 0``,因为start的cs段的偏移地址为0

# 依据位移进行转移的jmp指令
## jmp short 8位标志

``short``跳转范围是``-128~127``，生成机器码位移的补码

```nasm
assume cs:codesg,
codesg segment
    start:  mov ax, 0
            mov bx, 0
            jmp short s
            add ax, 1
        s:  inc ax
codesg ends
```

``jmp short s``的机器码是``EB 03``，当执行到````jmp short s````时，``ip=0008H``,但是``s``标志的``ip=000BH``,所以程序在执行``EB 03``机器码的时候（这里的03是编译器自动生成的），ip自动加了3位，变成``000BH``。

## jmp near 16位标志
``near``跳转范围是``-32768~32767``，生成机器码位移的补码

# 依靠目的地址（段地址：偏移地址）的jmp指令（jmp far ptr）
``jmp far ptr``是段间转移，又称远转移
```nasm
assume cs:codesg
codesg segment
    start:  mov ax, 0
            mob bx, 0
            jmp far ptr s
            db 256 dup (0)
        s:  add ax, 1
            inc ax

codesg ends
end start
```
这里的``jmp far ptr s``被编译成``jmp 0BBD:010B``，机器码为``EA 0B01 BD0B``，机器码中带目标的偏移地址和段地址


# 依靠寄存器保存ip值来进行的jmp指令
``jmp ax``其中``ax``保存的是要转移的``ip``值。

# 转移地址保存在内存中的jmp指令
> ``jmp 2000:1000``这个指令在编译器时不认识的，只能够在debug中使用


转移地址在内存中的jmp指令有两种格式：
## jmp word ptr 内存单元地址（段内转移）
```nasm
    mov ax, 0123H
    mov ds:[0], ax
    jmp word ptr ds:[0]
```
这里的``ds:[0]``保存的是偏移地址
执行后``ip=0123H``
## jmp dword ptr 内存单元地址（段间转移）
(cs) = （内存单元地址 + 2）
(ip) = （内存单元地址)

```nasm
mov ax, 0123H
mov ds:[0], ax
mov word ptr ds:[2], 0

jmp dword ptr ds:[0]
```

执行后``cs = 0 ip = 0123H``

# 检测点
## 9.1
使得jmp指令跳转到第一条指令
```nasm
assume cs:codesg, ds:datasg
datasg segment
    dw 0
datasg ends

codesg segment
    start:  mov ax, datasg
            mov ds, ax
            mov bx, 0
            jmp  word ptr ds:[bx+1]
codesg ends
end start
```

## 9.2
```nasm
/*
 * @Author: ImGili
 * @Description: 跳转到第一条指令
 */

assume cs:codesg, ds:datasg
datasg segment
    dd 12345678H
datasg ends

codesg segment
    start:  mov ax, datasg
            mov ds, ax
            mov bx, 0
            mov word ptr [bx], 0
            mov word ptr [bx+2], cs
            jmp dword ptr ds:[0]
codesg ends
end start
```

# jcxz指令
``jcxz s``

如果``cx=0``则会跳转到``s``。

如果``cx!=0``，则无事发生，继续执行下一条指令。

相当于c语言的``if(cx==0) jmp short 标号``

检测点9.2 4.asm

# loop指令

**loop 是短跳转，跳转范围是``-128~127``**

``loop s`` 指令是先执行``cx--``，再进行判断，当``cx==0``时，不再跳转，而执行下一条指令；当``cx!=0``时，跳转到``s``标志点位置

# 为什么要根据位移进行跳转
因为根据位移进行跳转，就只考虑相对位置，也就是说，如果程序加载到其他程序时，如果是根据地址进行跳转，就会跳转到其他地方，而相对位移就允许程序地址的任意变动。

# 跳转超过边界
```nasm
assume cs:codesg

codesg segment
    start:  jmp short s
            db 128 dup (0)
        s:  mov ax, 0

            mov ax, 4c00h
            int 21h
codesg ends
end start
```
报错超过跳转边界

# 实验8
```nasm
/*
 * @Author: ImGili
 * @Description: 实验8
 */

assume cs:codesg
codesg segment
        mov ax, 4c00h
        int 21h


start:  mov ax, 0
    s:  nop
        nop

        mov di, offset s    ; 保存的是s标记的偏移地址
        mov si, offset s2   ; 保存的时s2标记的偏移地址
        mov ax, cs:[si]     ; 把s2地址两个字节的指令复制到s的两个nop中
        mov cs:[di], ax     ; s2地址的指令是跳转到s1

    s0: jmp short s         ; 跳转到s标志位置

    s1: mov ax, 0           ; 最后会被执行
        int 21h
        mov ax, 0
    
    s2: jmp short s1        ; 注意： 这里的机器码是保存到是相对位移，所以 s 标志此时的机器码是向上3行，执行第一句语句
        nop

codesg ends
end start

```

# 实验9
利用显示缓存区，在显示器上显示带颜色的文字

显示缓存区``B8000H~BFFFFH``

显示缓存区有8页（默认显示第0页），每页4000个字符，一行80个字符，每个字符包括字符的ascii码和属性总共加起来是2个字节，所以没行160个字节
偏移地址``000~09f``，第一行

偏移地址``0a0~13f``，第二行

偏移地址``140~1df``，第三行

偏移地址``f00~f9f``，第二十五行

``00~01``， 第一列

``02~03``， 第二列

``04~05``， 第三列

``9e~9f``， 第80列


> 第1行是不会显示的

实验9
> 可以利用栈将变量在循环外保存起来，这样在内嵌循环时就仍然可以使用内嵌循环外的寄存器，而不互相影响，绝妙！！
> 也可以使用段寄存器，实现换行（新思路）。（10.asm）
> 一开始有个小错误，就是栈是先进后出，我是先push的cx，所以就要后pop cx。