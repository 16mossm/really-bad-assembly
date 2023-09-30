#purpose
## its basically a function but in assembly

.global _start
_start:  
    push $2        #pass variable 2
    push $5        #pass variable 1

    ## so this will be 5 to the power of 2
    call power


    add $16, %rsp   #delete the two variables from the stack (16 =  * 2)
    mov %rax , %rbx ## move the returned value


    movq $1, %rax #exit (%rbx is returned)
    int $0x80           ##magic man do his things




#purpose:
# does A to the power of B
# preamiters:
##int a
##int b
#output:
#returns the A to the power of B


power:      #########logic is broken
    push %rbp           ##save the old base pointer
    movq %rsp, %rbp     ##make the stack pointer the base pointer   ##ebp is variables ##esp is top
    sub $8, %rsp        ##add 1 local variable to the stack

    ####    %rax - base
    ####    %rbx - power
    ##      %rcx - temporary total

    movq 16(%rbp),  %rax     #get the variables passed
    movq 24(%rbp),  %rbx

    movq $1, %rcx       #if power is 0 then end value will be 1
    power_loop_start:
        cmp $0, %rbx        #if power hits 0 end
        je power_end_loop  
        imul %rax, %rcx         #multiply total by the base
        dec %rbx                #decrease power by 1
        jmp power_loop_start

    power_end_loop:

        #mov $5, %rbx
        #imul %rbx, %rax


        movq %rcx, %rax # result goes into rax to be returned

        movq %rbp, %rsp     #delete all local varaibles by sliding the stack

        pop %rbp            #restore the base pointer
        ret
