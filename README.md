# 汇编笔记

## 编译latex
```bash
xelatex Assembly.tex
```

## 编译示例
### Windows平台
#### 需求
* nasm汇编器
* mingw
```bash
nasm -f win64 test.asm

gcc test.obj -o test

./test
```
### MacOS平台
#### 需求
* nasm汇编器
* gcc
```bash
nasm -f macho64 test.asm

gcc -e main test.o -o tes
./test
```

## 调试
### MacOS
```bash
# 汇编test指令
nasm -f macho64 -g test.asm
# 链接程序生成二进制文件
gcc test.o -o test
# 启动调试器
lldb test
# 设置断点
break main
# 读取寄存器
register read ax
```
### Windows平台
```bash
# 汇编编译
nasm -f win64 -g test.asm
# 链接成二进制文件
gcc test.obj -o test
# gdb调试
gdb test
# 设置断点
b main
# 单步调试
ni
# 显示汇编指令
disassemble
# 查看内存数据
# 显示20个数据，x是以16进制，h是双字节
x /20xh 0x4480
# 设置寄存器的值
set $rip = 14441
```

### DOSBOX
```bash
# 编译
masm aaa.asm
link aaa.obj

# 调试
debug aaa.exe
# 步进程序
-t 
# 跳过循环
-p
# 运行到某一位置
-g 0016
# 查看某一内存，并显示汇编指令
-u ffff:0006
# 查看内存，并显示ascii码
-d ffff:0006
```