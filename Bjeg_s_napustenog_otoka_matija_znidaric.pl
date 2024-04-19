%Matija Znidaric
:- dynamic polozaj/1, ima/1, prolaz/2, jeU/2, lokacija/2, predmet/2, upali/1, stanje/2, tezinaNaVagi/1, pogledaj/1, otkljucaj/1.

retractall(polozaj(_)).
retractall(lokacija(_,_)).
retractall(ima(_)).
retractall(prolaz(_,_)).
retractall(jeU(_,_)).
retractall(predmet(_,_)).
retractall(stanje(_,_)).
retractall(tezinaNaVagi(_)).
retractall(pogledaj(_)).
retractall(otkljucaj(_)).


:-op(30,fx,lokacija).
:-op(30,fx,pogledaj).
:-op(30,fx,idiU).
:-op(30,fx,uzmi).
:-op(30,fx,ispusti).
:-op(30,fx,upali).
:-op(30,fx,ugasi).
:-op(30,fx,jeU).
:-op(30,fx,polozaj).
:-op(30,fx,otkljucaj).


radi(idiU X):-idiU(X),!.
radi(uzmi X):-uzmi(X),!.
radi(ispusti X):-ispusti(X),!.
radi(pogledaj X):-pogledaj(X),!.
radi(inventar):-inventar,!.
radi(upali X):-upali(X),!.
radi(ugasi X):-ugasi(X),!.
radi(otkljucaj X):-otkljucaj(X),!.
radi(polozaj X):-polozaj(X),!.
radi(zoviPomoc):-zoviPomoc,!.
radi(odustani).


start:-write(''),nl,write('dobrodošli na napušteni otok! pokušajte pobjeæi s otoka.'), nl, pogledaj(oko_sebe),repeat,write('Igra> '),
       read(X),radi(X),nl,zavrsi(X).

zavrsi(odustani):- write('izgleda da je napušteni otok ovog puta pobijedio.').

zoviPomoc :- polozaj(planina), ima(stari_mobitel), stanje(stari_mobitel, upaljeno), !, write('èestitamo, uspješno ste nazvali pomoæ! preživjeli ste napušteni otok i uspjeli pobjeæi.').
zoviPomoc :- ima(stari_mobitel), stanje(stari_mobitel, upaljeno),not(polozaj(planina)),!, write('nemate signala, pokušajte otiæi na više mjesto.').
zoviPomoc :- ima(stari_mobitel), ima(baterija), stanje(stari_mobitel, ugaseno),!, write('mobitel nije upaljen').
zoviPomoc :- ima(stari_mobitel),not(ima(baterija)), stanje(stari_mobitel, ugaseno),!, write('mobitel nije upaljen').
zoviPomoc :- not(ima(stari_mobitel)),!, write('potreban ti je mobitel da bi zvao pomoæ!').

polozaj(plaza).

lokacija(plaza, otkriveno).
lokacija(suma, otkriveno).
lokacija(tajanstvena_vaga, sakriveno).
lokacija(pecina, dobrosakriveno).
lokacija(planina, otkriveno).
lokacija(plaza2, otkriveno).
lokacija(potonuli_brod, sakriveno).

prolaz(plaza, suma).
prolaz(suma, pecina).
prolaz(suma, planina).
prolaz(planina, plaza2).
prolaz(plaza2, potonuli_brod).
prolaz(tajanstvena_vaga, suma).

prolazi(X, Y):- prolaz(X, Y).
prolazi(X, Y):- prolaz(Y, X).

predmet(kamen).
predmet(drvo).
predmet(sjekira).
predmet(liana).
predmet(karta).
predmet(boca).
predmet(maska_za_roniti).
predmet(svjetiljka).
predmet(baterija).
predmet(ruksak).
predmet(kljuc).
predmet(skrinja).
predmet(stari_mobitel).

opisStvari(kamen, 15).
opisStvari(sjekira, 5).
opisStvari(drvo, 20).
opisStvari(liana, 5).
opisStvari(karta, 2).
opisStvari(boca, 2).
opisStvari(maska_za_roniti, 3).
opisStvari(svjetiljka, 5).
opisStvari(baterija, 2).
opisStvari(ruksak, 5).
opisStvari(kljuc, 1).
opisStvari(skrinja, 20).

stanje(svjetiljka, ugaseno).
stanje(stari_mobitel, ugaseno).
stanje(skrinja, zakljucano).

jeU(kamen, plaza).
jeU(drvo, plaza).
jeU(boca, plaza).
jeU(sjekira, suma).
jeU(ruksak, plaza).
jeU(svjetiljka, ruksak).
jeU(maska_za_roniti, ruksak).
jeU(liana, suma).
jeU(karta, boca).
jeU(kljuc, potonuli_brod).
jeU(skrinja, planina).
jeU(baterija, skrinja).
jeU(stari_mobitel, pecina).

tezinaNaVagi(0).


upali(svjetiljka) :-ima(svjetiljka),ima(baterija),stanje(svjetiljka, ugaseno), !, retract(ima(baterija)),retract(stanje(svjetiljka, _)),assert(stanje(svjetiljka, upaljeno)),
                    write('upalili ste svjetiljku'), nl.
upali(svjetiljka) :-stanje(svjetiljka, upaljeno), !, write('svjetiljka veæ radi.').
upali(svjetiljka) :-write('potrebni su vam svjetiljka i baterija da bi mogli upaliti svjetiljku').

upali(stari_mobitel) :- ima(stari_mobitel),ima(baterija),!,retract(ima(baterija)),retract(stanje(stari_mobitel, _)),assert(stanje(stari_mobitel, upaljeno)),write('upalili ste mobitel'), nl.
upali(stari_mobitel) :- stanje(stari_mobitel, upaljeno), !, write('mobitel veæ radi.').
upali(stari_mobitel) :- write('potrebni su vam mobitel i baterija da bi mogli upaliti mobitel').

ugasi(svjetiljka) :- ima(svjetiljka),stanje(svjetiljka, upaljeno),!,assert(ima(baterija)),retract(stanje(svjetiljka, _)),assert(stanje(svjetiljka, ugaseno)),
                     write('ugasili ste svjetiljku'), nl.
ugasi(svjetiljka) :- stanje(svjetiljka, ugaseno), !, write('svjetiljka je veæ bila ugašena.').
ugasi(svjetiljka) :- write('svjetiljka mora raditi da bi ju mogli ugasiti.').

ugasi(stari_mobitel) :- ima(stari_mobitel),stanje(stari_mobitel, upaljeno),!,assert(ima(baterija)),retract(stanje(stari_mobitel, _)),assert(stanje(stari_mobitel, ugaseno)),
                        write('ugasili ste mobitel'), nl.
ugasi(stari_mobitel) :- stanje(stari_mobitel, ugaseno), !, write('mobitel je veæ bio ugašen.').
ugasi(stari_mobitel) :- write('mobitel mora raditi da bi ju mogli ugasiti.').


idiU(potonuli_brod) :- ima(maska_za_roniti), polozaj(Trenutno), prolazi(Trenutno, potonuli_brod),lokacija(potonuli_brod, otkriveno), !, promijeni_polozaj(potonuli_brod), pogledaj(oko_sebe).
idiU(potonuli_brod) :- polozaj(Trenutno), prolazi(Trenutno, potonuli_brod), lokacija(potonuli_brod, otkriveno), !, write('Potrebna ti je maska za ronjenje.'), nl.
idiU(potonuli_brod) :- write('Ne možete iæi tamo.'), nl.

idiU(pecina) :- ima(svjetiljka),stanje(svjetiljka, upaljeno), polozaj(Trenutno), prolazi(Trenutno, pecina),lokacija(pecina, otkriveno), !, promijeni_polozaj(pecina), pogledaj(oko_sebe).
idiU(pecina) :- polozaj(Trenutno), prolazi(Trenutno, pecina), lokacija(pecina, otkriveno),!, write('potrebno je upaliti svjetiljku.'), nl.
idiU(pecina) :- write('Ne možete iæi tamo.'), nl.

idiU(tajanstvena_vaga) :- polozaj(Trenutno), prolazi(Trenutno, tajanstvena_vaga),lokacija(tajanstvena_vaga, otkriveno), !, promijeni_polozaj(tajanstvena_vaga), pogledaj(oko_sebe).
idiU(tajanstvena_vaga) :- write('Ne možete iæi tamo.'), nl.

idiU(Mjesto) :- polozaj(Trenutno), lokacija(Trenutno, otkriveno), lokacija(Mjesto, otkriveno), prolazi(Trenutno, Mjesto), !, promijeni_polozaj(Mjesto), pogledaj(oko_sebe).
idiU(Mjesto) :- polozaj(Trenutno), lokacija(Trenutno, otkriveno), lokacija(Mjesto, otkriveno), prolazi(Mjesto, Trenutno), !, promijeni_polozaj(Mjesto), pogledaj(oko_sebe).
idiU(_) :- write('Ne možete iæi tamo.'), nl.


promijeni_polozaj(Mjesto) :- retract(polozaj(_)), asserta(polozaj(Mjesto)).

otkljucaj(skrinja) :- ima(kljuc), polozaj(Trenutno), jeU(skrinja, Trenutno), !, write('otkljuèali ste škrinju'), retract(ima(kljuc)), retract(stanje(skrinja, zakljucano)),
                      assert(stanje(skrinja, otkljucano)),nl.
otkljucaj(skrinja) :- not(ima(kljuc)), polozaj(Trenutno), jeU(skrinja, Trenutno), !, write('nemate kljuæ za škrinju'),nl.
otkljucaj(skrinja) :- polozaj(Trenutno), jeU(skrinja, Trenutno), !, write('ovdje nema škrinje!'),nl.


uzmi(karta) :- lokacija(Mjesto,sakriveno), retract(lokacija(Mjesto, sakriveno)), assert(lokacija(Mjesto, otkriveno)), fail.
uzmi(baterija) :- stanje(skrinja, otkljucano), polozaj(Mjesto), jeU(Stvar, Mjesto), jeU(Stvar2, Stvar), !, retract(jeU(Stvar2, Stvar)), asserta(ima(Stvar2)), write('uzeli ste '),
                  write(Stvar2), nl.
uzmi(baterija) :- write('to ne možete uzeti.'), nl.
uzmi(Stvar) :- polozaj(Mjesto), jeU(Stvar, Mjesto),!, retract(jeU(Stvar, Mjesto)), asserta(ima(Stvar)), write('uzeli ste '), write(Stvar), nl.
uzmi(Stvar2) :- polozaj(Mjesto), jeU(Stvar, Mjesto), jeU(Stvar2, Stvar), retract(jeU(Stvar2, Stvar)), asserta(ima(Stvar2)), write('uzeli ste '),write(Stvar2), nl.
uzmi(_) :- write('to ne možete uzeti.'), nl.

ispusti(Stvar) :- ima(Stvar),polozaj(tajanstvena_vaga),!,retract(ima(Stvar)),opisStvari(Stvar, Tezina),dodajTezinuNaVagu(Tezina),asserta(jeU(Stvar, tajanstvena_vaga)),
                  write('ispustili ste '), write(Stvar), write(' na tajanstvenu vagu.'), nl, provjeriOtkrivanjeSpilje.
ispusti(Stvar) :- ima(Stvar), !,polozaj(Mjesto), retract(ima(Stvar)),asserta(jeU(Stvar, Mjesto)), write('ispustili ste '), write(Stvar), nl.
ispusti(_) :- write('nemate to.'), nl.


pogledaj(oko_sebe) :- polozaj(Mjesto), write('nalazite se na: '), write(Mjesto), nl, ispisStvari(Mjesto), nl, ispisMjesta(Mjesto).
pogledaj(skrinja) :- stanje(skrinja, otkljucano), !,nl,ispisStvari(skrinja), nl.
pogledaj(skrinja) :- write('skrinju je potrebno otkljucati'), nl.
pogledaj(Stvar) :- nl,ispisStvari(Stvar), nl.


inventar :- write('kod sebe trenutno imate: '), nl, ima(Stvar), write(Stvar), nl, fail.


ispisStvari(Mjesto) :- write('možete vidjeti: '), nl,jeU(Stvar, Mjesto), write(Stvar), nl, fail.
ispisStvari(_).
ispisMjesta(Mjesto) :- write('možete iæi: '), nl,prolazi(Mjesto, Mjesto2), lokacija(Mjesto2, otkriveno), write(Mjesto2), nl, fail.
ispisMjesta(_).

dodajTezinuNaVagu(Tezina) :- retract(tezinaNaVagi(TrenutnaTezina)),NovaTezina is TrenutnaTezina + Tezina,asserta(tezinaNaVagi(NovaTezina)).

provjeriOtkrivanjeSpilje :- tezinaNaVagi(Tezina),Tezina > 30, !, retract(lokacija(pecina, dobrosakriveno)),asserta(lokacija(pecina, otkriveno)),
                          write('stavljeno je dovoljno težine na vagu. peèina se otvorila pokraj šume!'), nl.
