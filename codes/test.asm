        global  main
        extern  puts
        section .text
main:
        sub     rsp, 28h                        
        mov     rcx, message
        mov     ax, bx
        call    puts                           
        add     rsp, 28h                        
        ret
message:
        db      'Hello', 0                     