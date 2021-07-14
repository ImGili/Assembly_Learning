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