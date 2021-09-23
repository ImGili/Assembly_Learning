assume cs:codesg, ds:datasg, ss:stacksg

datasg segment
    db 'welcome to masm!'
    db 02H, 24H, 71H
datasg ends

stacksg segment
    db 16 dup (0)
stacksg ends

codesg segment
    start:  mov ax, datasg
            mov ds, ax

            mov ax, 0b800h
            mov es, ax

            mov ax, stacksg
            mov ss, ax
            mov sp, 0

            ; 三行文字，循环3次
            mov cx, 3
            mov bx, 902H   ; 记录三行的首地址
            mov si, 0   ; 记录显示内存字符的偏移地址
            mov di, 0
        s0: push cx

            ; 8个字符，循环8次
            mov cx, 16
        s1: 
            mov al, 77H
            mov byte ptr es:[bx+si+0], 77H       ; 字符的字符数据
            mov al, ds:[di+16]
            mov es:[bx+si+1], al       ; 颜色属性赋值
            add si, 2                           ; 指向下一个字符
            inc di
            loop s1                             ; 跳转回s1
            
            pop cx
            add bx, 160                         ; 跳到下一行
            inc di                              ; 指向下一个字符
            loop s0

            mov ax, 4c00h
            int 21h

codesg ends
end start