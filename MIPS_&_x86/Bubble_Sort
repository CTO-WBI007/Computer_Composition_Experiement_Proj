.data
prompt: .asciiz "Enter a number: "
.text
.globl main

main:
    # 输出提示信息
    li $v0, 4
    la $a0, prompt
    syscall

    # 读取用户输入的整数n
    li $v0, 5
    syscall
    move $a0, $v0  # 将输入的整数n传递给factorial函数

    # 调用factorial函数计算n的阶乘
    jal factorial

    # 输出n的阶乘
    move $a0, $v0  # 将factorial函数的返回值传递给print_int函数
    jal print_int

    # 退出程序
    li $v0, 10
    syscall

factorial:
    # 将返回地址和参数保存到堆栈中
    subu $sp, $sp, 8
    sw $ra, 4($sp)
    sw $a0, 0($sp)

    # 如果n为0或1，则返回1，否则递归计算n的阶乘
    beqz $a0, base_case
    addiu $a0, $a0, -1
    jal factorial
    lw $t0, 0($sp)  # 加载参数n
    mul $v0, $v0, $t0  # 计算n * factorial(n - 1)

end_factorial:
    # 从堆栈中恢复返回地址和参数，然后返回到调用者
    lw $ra, 4($sp)
    lw $a0, 0($sp)
    addiu $sp, $sp, 8
    jr $ra

base_case:
    li $v0, 1  # 如果n为0或1，则返回1
    j end_factorial

print_int:
    # 输出整数
    li $v0, 1
    syscall

    jr $ra      # 返回到调用者
