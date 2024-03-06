************** checkers.asm **************

  Dorim sa simulam jocul de checkers (dame). Avem o matrice de 8×8 ce reprezinta suprafata de joc.
Dandu-se pozitie unei dame pe suprafata de joc, dorim sa calculam noi pozitii pe care 
poate ajunge aceasta.
  Pentru simularea jocului presupunem ca nu vor exista coliziuni intre piesele de joc,
pe tabla de joc se afla o singura piesa, piesele nu pot sa iasa din suprafata de joc.

************** checkers.asm **************






************** checkers_bitboard.asm **************

  Dorim sa optimizam reprezentarea suprafetei de joc de la checkers.asm astfel incat sa ocupam mai
putina memorie si calculele pozitiilor sa se faca mai rapid.
  O posibila optimizare este reprezentata de notiunea de Bitboard. Bitboard reprezinta o structura
de date binara in care fiecare bit reprezinta prezenta sau absenta unei piese pe o anumita pozitie
a tablei de joc. De obicei, in C, pentru a reprezenta un bitboard, se foloseste o
variabila de tip unsigned long long.
  "unsigned long long" este un tip de date ce contine 64 biti (8 octeti). O table de joc de dimensiunea
8×8 poate fi reprezentata intuitiv cu o singura variabila de acest tip, grupand, la nivel logic, cate 8
biti pentru fiecare linie din suprafata. Din pacate insa, noi nu avem acces la registri pe 64 biti,
astfel incat trebuie folositi 2 registri pentru reprezentarea suprafetei de joc.

************** checkers_bitboard.asm **************
