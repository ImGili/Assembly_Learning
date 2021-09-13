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


