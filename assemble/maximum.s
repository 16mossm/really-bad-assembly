#purpose
# it find the big number in the number list


#variablbles:

####    %edi - holds index of data being looked upon
####    %ebx - largest current data
####    %eax - curent data item

.section .data

data_items:
    .long 3,67,34,200,45,75,54,34,44,33,22,210,211,212,1002,1003,11,66,0

.section .text

.globl _start
_start:
    movl $0, %edi                           #move 0 into the index register
    movl data_items(,%edi,4)    , %eax      #4 is size of long ##edi is currently 0 , so load from index to data
    movl %eax,%ebx                          #first item always the largest so far :)

        

start_loop:
    cmpl $0, %eax                  #compare the 2 values and store it in magic land ##
    je end_loop                     ##jump if the previous comparison was equal
    incl %edi                       ##increment the index by 1 but long
    movl data_items(,%edi,4), %eax      ##load
    cmpl %ebx, %eax
    jle start_loop                  #if smaller dont do extra stuff

    movl %eax , %ebx
    jmp start_loop

end_loop:
    ###loop be ended here
    

    movl $1, %eax           #1 is the exit() syscall
    int $0x80               ##ask the magic man to do things for me 





