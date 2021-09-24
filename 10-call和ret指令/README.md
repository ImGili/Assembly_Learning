# call和ret指令
## ret和retf
``ret``

相当于``pop ip``

``retf``

相当于
```nasm
pop ip
pop cs
```

## call指令
``call 标记``相当于
```nasm
push ip
jump near ptr 标记
```
这个是段内跳转，标记是跳转的位移

### 检测点10.2
```nasm
assume cs:codesg, ss:stacksg

stacksg segment
    db 16 dup (0)
stacksg ends

codesg segment
start:  mov ax, stacksg
        mov ss, ax
        mov sp, 16
        mov ax, 0
        call s
        inc ax
    s:  pop ax
codesg ends
end start
```
这里``call s``指令``push ip``的``ip``是``inc ax``指令的``ip``。

## call far ptr 标记
``call far ptr 标记``相当于
```nasm
push cs
push ip
jump far ptr 标记
```
标记表明了段地址+偏移地址，实现的是段间跳转。