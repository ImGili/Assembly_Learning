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