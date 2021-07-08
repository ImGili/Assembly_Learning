# 汇编笔记

## 编译latex
```bash
xelatex Assembly.tex
```

## 编译示例
### 需求
* nasm汇编器
* mingw
```bash
nasm -f win64 test.asm

gcc test.obj -o test

./test
```