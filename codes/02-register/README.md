# 寄存器
# 通用寄存器
``AX、BX、CX、DX``

# 段地址和偏移地址
由于8086cpu的地址总线是20位的，而cpu一次只能送出16位的地址，所以就引入了段地址和偏移地址的概念。

> 段地址x16 + 偏移地址 = 物理地址

# 段寄存器
`` CS DS SS ES ``
> **段地址不可以直接赋值，需要利用通用寄存器间接赋值**

CS 存放的是当前指令的段地址， IP寄存器存放的则是偏移地址。

DS 是存放[0]数据段段段地址， [0]这个就是数据段偏移地址。

SS 存放的是栈的段地址，     SP存放的就是偏移地址。

# 修改CS和IP的方法
``jump 2AE3:3``这里CS就是2AE3 IP就是3

# Debug指令
* r查看寄存器
* d查看内存内容
* e改写内存内容
* u将内存中的机器指令翻译成汇编指令
* t单步执行一条机器指令
* a以汇编指令的的格式在内存中存入一条机器指令