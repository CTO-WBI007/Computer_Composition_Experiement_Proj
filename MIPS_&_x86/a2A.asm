    .data
    # 定义一个名为 STRING 的字符串，值为 "ADRAdfghtGHgff"
STRING: .asciiz "ADRAdfghtGHgff"
    # 定义一个名为 COUNT 的字，值为 13
COUNT:  .word 14
    # 定义一个名为 DEST 的空间，大小为 13 字节
DEST:   .space 14
    # 定义一个名为 NEWLINE 的字符串，值为 "\n"
NEWLINE: .asciiz "\n"

    .text
    # 定义一个名为 main 的全局标签
    .globl main
main:
    # 将 STRING 的地址加载到 $t0 寄存器
    la $t0, STRING
    # 将 DEST 的地址加载到 $t1 寄存器
    la $t1, DEST
    # 将 13 加载到 $t2 寄存器
    li $t2, 14

    # 定义一个名为 loop 的标签
loop:
    # 从 $t0 指针所指的位置加载一个字节到 $t3 寄存器
    lb $t3, 0($t0)
    # 将 $t3 寄存器的值与 0xdf 进行与运算，结果存回 $t3
    andi $t3, $t3, 0xdf
    # 将 $t3 寄存器的值存储到 $t1 指针所指的位置
    sb $t3, 0($t1)
    # 将 $t0 寄存器的值加 1
    addiu $t0, $t0, 1
    # 将 $t1 寄存器的值加 1
    addiu $t1, $t1, 1
    # 将 $t2 寄存器的值减 1
    addiu $t2, $t2, -1
    # 如果 $t2 寄存器的值不为零，跳转到 loop 标签
    bnez $t2, loop

    # 将 DEST 中的字符串打印到控制台
    la $a0, DEST
    li $v0, 4
    syscall

    # 打印一个换行符
    la $a0, NEWLINE
    syscall

    # 结束程序
    li $v0, 10
    syscall
