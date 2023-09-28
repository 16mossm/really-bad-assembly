#purpose
## its basically a function but in assembly

.global _start
_start:
    subl $8, %esp
    movl $3, 4(%esp)### repacement for pushl 
    movl $2, 8(%esp)###    
    #push $3        #pass variable 1
    #push $2        #pass variable 2
    call power
    addl $8, %esp   #delete the two variables from the stack (8 = 4 * 2)
    
    movl %eax , %ebx ## move the returned value

    movl $1, %eax #exit (%ebx is returned)
    int $0x80           ##magic man do his things




#purpose:
# does A to the power of B 
# preamiters: 
##int a 
##int b
#output:
#returns the A to the power of B


power:
    subl $4, %ebp
    movl %ebp , 4(%esp)##  repacement for pushl 
    ####push %ebp           ##save the old base pointer
    mov %esp, %ebp     ##make the stack pointer the base pointer   ##ebp is variables ##esp is top
    subl $8, %esp

    ####    %eax - base
    ####    %ebx - power
    ##      %ecx - temporary value

    ##   -4(%ebp) - current value


    movl 8(%ebp),  %eax     #get the variables passed
    movl 12(%ebp),  %ebx

    movl $1,-4(%ebp)        #if power is 0 then reuslt is 1 because math
    cmpl $0, %ebx          #if power = 0 then break
    jle power_end_loop
    movl %eax, -4(%ebp)     #store the currnet base

    power_loop_start:
        decl %ebx       #subtract power by 1
        cmpl $0, %ebx       #end when 0
        jle power_end_loop
        movl -4(%ebp) , %ecx
        imull %eax, %ecx    #multiply the currnet answet by the base
        movl  %ecx, -4(%ebp)
        jmp power_loop_start    ##end_loop      

    power_end_loop:

        movl -4(%ebp), %eax # result goes into eax to be returned
        movl %ebp, %esp     #delete local varaibles by sliding the stack
        addl $4 , %ebp  #replace for popl
        #popl %ebp       #restore the base pointer
        ret


