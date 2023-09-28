#purpose
## its basically a function but in assembly

##not working fix later 

.global _start
_start:   
    push $3        #pass variable 1
    push $2        #pass variable 2
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
    sub $8, %rsp

    ####    %rax - base
    ####    %rbx - power
    ##      %rcx - temporary value

    ##   -8(%rbp) - current value


    movq 16(%rbp),  %rax     #get the variables passed
    movq 32(%rbp),  %rbx

    movq $1,-8(%rbp)        #if power is 0 then reuslt is 1 because math
    cmp $0, %rbx            #if power = 0 then break
    jle power_end_loop
    movq %rax, -8(%rbp)     #store the currnet base

    power_loop_start:
        dec %rbx            #subtract power by 1
        cmp $0, %rbx        #end when 0
        jle power_end_loop
        movq -8(%rbp) , %rcx
        imul %rax, %rcx    #multiply the currnet answet by the base
        movq  %rcx, -8(%rbp)
        jmp power_loop_start    ##end_loop      

    power_end_loop:

        mov $5, %rbx
        imul %rbx, %rax


        #movq -8(%rbp), %rax # result goes into eax to be returned
        movq %rbp, %rsp     #delete local varaibles by sliding the stack

        pop %rbp       #restore the base pointer
        ret


