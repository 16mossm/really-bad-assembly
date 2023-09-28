#purpose: legit nothing it just exists
# poop pant



#variabls:
#   %eax holds the system call number
#    %ebx holds the return status


.section .data

.section .text

.globl _start
_start:
    movl $1, %eax   #kernel command for exiting a program

    movl $1, %ebx #this is the status number we will return to the os. change and it will return different things
                    #echo $?

    int $0x80       #wakes up kernel to run exit command
