section .data

section .text
    global bonus

bonus:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; board

    ;; DO NOT MODIFY
    mov dl, 8 ; retinem in dl nr de coloane
    cmp eax, 0
    jz x_equal_0 ; daca x egal cu 0
    cmp ebx, 0
    jz y_egual_0 ; daca y egal cu 0
    cmp eax, 7
    je x_equal_7 ; daca x egal cu 7
    cmp ebx, 7 ; daca y egal cu 7
    je y_equal_7

    ; pentru cele 4 miscari posibile ale damei
    ;

x_equal_0:
    cmp ebx, 0 ; daca si y e egal cu 0
    jz x_and_y_0
    cmp ebx, 7 ; daca y e egal cu 7(ultima coloana)
    je x_0_y_equal_7

    ;daca y e diferit de 0 si de 7
    add bl, 8 ; adunam cu bl nr de coloane
    add al, bl ; adunam la al bl
    dec al ; obtinem prima miscare posibila a damei pe tabla
    mov esi, eax ; ca sa nu pierdem valoarea lui eax si...
    call prepare_for_set_bit
    call set_bit
    mov eax, esi
    mov esi, edi ; acum folosim esi pentru a pastra edi
    add al, 2 ; urmatoarea miscare posibila a damei pe tabla
    call prepare_for_set_bit
    call set_bit
    add edi, esi ; adunam la edi esi - adica valoarea precedenta lui edi
    jmp set_in_board_1
x_and_y_0:
    inc bl ; adunam la y 1
    inc al ; adunam la x 1
    mul dl ; inmultim cu dl al
    add al, bl
    call prepare_for_set_bit
    call set_bit
    jmp set_in_board_1
x_0_y_equal_7:
    mov dl, 2 ; punem nr liniei la care se va putea muta dama
    add al,bl ; adaugam la al bl ca apoi sa o inmultim cu dl
    mul dl
    call prepare_for_set_bit
    call set_bit
    jmp set_in_board_1
y_egual_0:
    cmp eax, 7 ; daca x e ultima linie
    je y_0_x_equal_7
    dec al ; pentru a obtine linia primei pozitii posibile a damei
    mul dl
    inc al ; indexul primei miscari posibile a damei
    mov esi, eax
    cmp eax, 32
    jg poz_board_0
    call prepare_for_set_bit
    call set_bit
    mov eax, esi
    mov esi, edi 
    ; stim ca distanta este de doua linii deci de 16 pozitii
    add al, 16
    call prepare_for_set_bit
    call set_bit
    add edi, esi
    jmp set_in_board_1
y_0_x_equal_7:
    dec al ; obtinem indexul liniei pe care va fi miscarea posibila
    mul dl ; inmultim al cu nr de linii
    inc al ; obtinem indexul pozitiei miscarii
    ; deoarece al se afla in aria board_0, scadem din eax 32
    sub al, 32
    call prepare_for_set_bit
    call set_bit
    jmp set_in_board_0
x_equal_7:
    dec al ; pentru a obtine linia pozitiilor posibile ale damei
    mul dl ; 
    dec bl
    add al, bl ; obtinem pozitia primei miscari posibile
    sub al, 32 ; scadem 32 caci suntem in tabel_0
    mov esi, eax ; salvam variabila eax in esi
    call prepare_for_set_bit
    call set_bit
    mov eax, esi
    mov esi, edi ; acum folosim esi pentru a pastra edi
    ;mov byte [ecx + eax], 1
    ; daca pozitia damei e dreapta sus; comparam cu 6 si nu cu 7 
    ; caci am scazut anterior un index de pozitie
    cmp ebx, 6
    je set_in_board_0
    add al, 2 ; trecem la urmatoarea pozitie posibila
    ;mov byte [ecx + eax], 1
    call prepare_for_set_bit
    call set_bit
    add edi, esi
    jmp set_in_board_0
y_equal_7:
    dec al
    mul dl
    add al, bl
    dec al
    mov esi, eax
    cmp eax, 32
    ; daca dama are indexul pozitiei mai mare de 32
    jg poz_board_0
    call prepare_for_set_bit
    call set_bit
    mov eax, esi
    mov esi, edi
    ; trecem la urmatoarea pozitie, cu doua linii mai sus
    add al, 16
    call prepare_for_set_bit
    call set_bit
    add edi, esi
    jmp set_in_board_1

poz_board_0:
    sub eax, 32
    mov esi, eax
    call prepare_for_set_bit
    call set_bit
    mov eax, esi
    mov esi, edi
    ; trecem la urmatoarea pozitie, cu doua linii mai sus, pentru cazul
    ; in care y = 7
    add al, 16
    call prepare_for_set_bit
    call set_bit
    add edi, esi
    jmp set_in_board_0

prepare_for_set_bit:
    xor edi, edi
    inc edi
    ret

set_bit:
    shl edi, 1
    dec eax
    cmp eax, 0
    jnz set_bit
    ret

set_in_board_1:
    mov [ecx + 4], edi
    jmp end_of_program

set_in_board_0:
    mov [ecx], edi
    jmp end_of_program

    end_of_program:
    ;; FREESTYLE STARTS HERE

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY