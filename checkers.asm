%include "../include/io.mac"

section .data

section .text
	global checkers
    extern printf

checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; table

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE
    cmp eax, 0
    mov dl, 8 ; retinem in dl nr de coloane
    jz x_equal_0 ; daca x egal cu 0
    cmp ebx, 0
    jz y_egual_0 ; daca y egal cu 0
    cmp eax, 7
    je x_equal_7 ; daca x egal cu 7
    cmp ebx, 7 ; daca y egal cu 7
    je y_equal_7

    ; pentru cele 4 miscari posibile ale damei
    dec al ; ne ducem cu o linie mai in jos fata de poitia damei
    mul dl
    add al, bl ; ajungem sub pozitia damei
    inc al ; adunam cu 1 si ajungem la miscarea posibila a damei
    mov byte [ecx + eax], 1
    ; adunam cu 16 pentru a trece cu doua linii mai sus, la urmatoarea miscare
    add al, 16
    mov byte [ecx + eax], 1
    sub al, 2
    mov byte [ecx + eax], 1
    sub al, 16
    mov byte [ecx + eax], 1
    jmp end_of_program

x_equal_0:
    cmp ebx, 0 ; daca si y e egal cu 0
    jz x_and_y_0
    cmp ebx, 7 ; daca si y e egal cu 7(ultima coloana)
    je x_0_y_equal_7
    ;daca e diferit de 0 si de 7
    add bl, 8 ; adunam cu bl nr de coloane
    add al, bl ; adunam la al bl
    dec al ; obtinem prima miscare posibila a damei pe tabla
    mov byte [ecx + eax], 1
    add al, 2 ; urmatoarea miscare posibila a damei pe tabla
    mov byte [ecx + eax], 1
    jmp end_of_program
x_and_y_0:
    inc bl ; adunam la y 1
    inc al ; adunam la x 1
    mul dl ; inmultim cu dl al
    add al, bl
    mov byte [ecx + eax], 1
    jmp end_of_program
x_0_y_equal_7:
    mov dl, 2 ; punem nr liniei la care se va putea muta dama
    add al,bl ; adaugam la al bl ca apoi sa o inmultim cu dl
    mul dl
    mov byte [ecx + eax], 1
    jmp end_of_program
y_egual_0:
    cmp eax, 7 ; daca x e ultima linie
    je y_0_x_equal_7
    dec al ; pentru a obtine linia primei pozitii posibile a damei
    mul dl
    inc al ; indexul primei miscari posibile a damei
    mov byte [ecx + eax], 1
    ; stim ca distanta este de doua linii deci de 16 pozitii
    add al, 16
    mov byte [ecx + eax], 1
    jmp end_of_program
y_0_x_equal_7:
    dec al ; obtinem indexul liniei pe care va fi miscarea posibila
    mul dl ; inmultim al cu nr de linii
    inc al ; obtinem indexul pozitiei miscarii
    mov byte [ecx + eax], 1
    jmp end_of_program
x_equal_7:
    dec al ; pentru a obtine linia pozitiilor posibile ale damei
    mul dl ; 
    dec bl
    add al, bl ; obtinem pozitia primei miscari posibile
    mov byte [ecx + eax], 1
    ; daca pozitia damei e dreapta sus; comparam cu 6 si nu cu 7 
    ; caci am scazut anterior un index de pozitie
    cmp ebx, 6
    je end_of_program
    add al, 2 ; trecem la urmatoarea pozitie posibila
    mov byte [ecx + eax], 1
    jmp end_of_program
y_equal_7:
    dec al
    mul dl
    add al, bl
    dec al
    mov byte [ecx + eax], 1
    add al, 16
    mov byte [ecx + eax], 1
end_of_program:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popacika
    leave
    ret
    ;; DO NOT MODIFY