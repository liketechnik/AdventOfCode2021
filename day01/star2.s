# vim: set filetype=asm :
.data
values:
    .include "input_prepared"
    valueslen = . - values

.text
    .globl main

load_values:
    movl $values, %ebx
    movl -8(%ebx, %edx, 4),%eax 
    addl -4(%ebx, %edx, 4),%eax
    addl 0(%ebx, %edx, 4),%eax
    ret

main:
    # divide length (in bytes) of input data by four (each int has 32bit)
    # result in ecx
    movl $0,%edx
    movl $valueslen,%eax
    movl $4,%ebx
    idiv %ebx
    movl %eax, %ecx
    subl $4, %ecx # skip first three iterations

    # initialize counter (r11)
    movl $0,%r11d

    # initialize loop: ecx contains loop counter, r8d counts upwards for array access
    movl $4,%r8d
loop:
    # get value from values into r9
    movl %r8d,%edx
    call load_values
    movl %eax,%r9d

    subl $1, %edx
    call load_values
    movl %eax,%r10d

    cmp %r10d,%r9d
    # branch if r9d (current) <= r10d (previous)
branch:
    jle no_increase
    addl $1,%r11d

no_increase:

    addl $1,%r8d
    loop loop

break:
    

