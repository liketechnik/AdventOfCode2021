# vim: set filetype=asm :
.data
values:
    .include "input_prepared"
    valueslen = . - values

.text
    .globl main

main:
    # divide length (in bytes) of input data by four (each int has 32bit)
    # result in ecx
    movl $0,%edx
    movl $valueslen,%eax
    movl $4,%ebx
    idiv %ebx
    movl %eax, %ecx

    # initialize counter (r11) and prev value (r10)
    movl $0xffff,%r10d
    movl $0,%r11d

    # initialize loop: ecx contains loop counter, r8d counts upwards for array access
    movl $0,%r8d
loop:
    # get value from values into r9
    movl $values, %ebx
    movl 0(%ebx, %r8d, 4),%r9d

    cmp %r10d,%r9d
    # branch if r9d (current) <= r10d (previous)
branch:
    jle no_increase
    addl $1,%r11d

no_increase:
    # save previous value
    movl %r9d,%r10d

    addl $1,%r8d
    loop loop

break:
    

