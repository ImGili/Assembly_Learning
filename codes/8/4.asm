/*
 * @Author: ImGili
 * @Description: 寻址方式综合应用
    根据data完成table
 */

assume cs:codesg, ds:datasg, ss:stacksg

datasg segment
	db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983'
	db '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992'
	db '1993', '1994', '1995'
	;以上表示21年的21个字符串
	dd 16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065, 87479, 140417, 197514
	dd 345980, 590827, 803530, 1183000, 1843000, 2759000, 3753000, 4649000, 5937000
	;以上表示21年公司收入的21个dword型数据
	dw 3, 7, 9, 13, 28, 38, 130, 220, 476, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226
	dw 11542, 14430, 15257, 17800
	;以上表示21年公司雇员人数的21个word型数据
datasg ends 

table segment
   db 21 dup ('year summ ne ?? ')
table ends

stacksg segment
   db 16 dup (0)
stacksg ends

codesg segment
   start:   mov ax, datasg
            mov ds, ax

            mov ax, table
            mov es, ax

            mov ax, stacksg
            mov ss, ax
            mov sp, 0010H
;------------------------------年份和平均收入复制------------------------------
            ; 先传输datasg中 4个字节的数据，即第一、第二行的数据，所以循环2次
            mov cx, 2
            mov si, 0
            mov di, 0
      s0:   push cx
            ; 21个年份，所以要循环21次
            mov cx, 21
      s1:   push cx

            ; 4个字节，所以要循环4遍
            mov cx, 4
            mov bx, 0   ; 数组索引清零
      s2:   mov al, ds:[di][bx]
            mov es:[si][bx], al
            inc bx
            loop s2

            pop cx
            add si, 0010H ; 指向下一行
            add di, 0004H ; di指向下一个数据的首地址
            loop s1
            ; 第二遍循环时，就是si和di指向的就是收入数据和table的首地址
            mov si, 0005H 
            mov di, 0054H
            pop cx
            loop s0
;------------------------------雇员人数复制------------------------------
            mov cx, 21
            mov si, 000AH
            mov di, 00A8H
      s3:   push cx

            mov cx, 2
            mov bx, 0   ; 数组索引清零
      s4:   mov al, ds:[di][bx]
            mov es:[si][bx], al
            inc bx

            loop s4

            add si, 0010H
            add di, 0002H

            pop cx
            loop s3

;------------------------------计算平均收入------------------------------
            ; 此时每个表的结构化的数据已经完成，结构化调用表内数据，并可以结构化赋值
            mov cx, 21
            mov si, 0   ; 表头首地址
      s5:   mov ax, es:[si].05H  ; 收入的第一个字节地址
            mov dx, es:[si].07H  ; 收入的第三个字节地址
            div word ptr es:[si].0AH   ; 按字进行除法运算
            mov es:[si].0DH, ax        ; 将商赋值道表中
            add si, 0010H
            loop s5


            mov ax, 4c00h
            int 21h

      

codesg ends
end start