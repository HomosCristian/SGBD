/* 
1. Construi?i un bloc PL/SQL prin care s? se m?reasc? salariul angajatului citit de la tastatur?, urmând pa?ii:

se preiau informa?ii despre angajatul respectiv
se incrementeaz? cu 100 valoarea variabilei în care a fost memorat salariul
se modifica salariul angajatului
se preia salariul final, dup? modificare ?i se afi?eaz?
*/

SET SERVEROUTPUT ON

DECLARE

v_id_angajat NUMBER(6,0);

v_salariul NUMBER(8,2);

v_salariul_nou NUMBER(8,2);

BEGIN


DBMS_OUTPUT.PUT_LINE('Introduceti ID-ul angajatului:');


v_id_angajat := TO_NUMBER(&id_angajat);


SELECT salariul INTO v_salariul FROM angajati WHERE id_angajat=v_id_angajat;


v_salariul_nou :=v_salariul+100;


UPDATE angajati SET salariul = v_salariul_nou WHERE id_angajat=v_id_angajat;


SELECT salariul INTO v_salariul_nou FROM angajati WHERE id_angajat=v_id_angajat;


 DBMS_OUTPUT.PUT_LINE('Salariul final al angajatului ' || v_id_angajat || ' este: ' || v_salariul_nou);

END;


/*
2. Construi?i un bloc PL/SQL prin care s? se adauge un produs nou în tabela Produse, astfel:

valoarea coloanei id_produs va fi calculat? ca fiind maximul valorilor existente, incrementat cu 1
valorile coloanelor denumire_produs ?i descriere vor fi citite de la tastatur? prin variabile de substitu?ie
restul valorilor pot r?mâne NULL
*/


SET SERVEROUTPUT ON;

DECLARE

    v_id_produs NUMBER(6,0);

    v_denumire_produs VARCHAR2(50);

    v_descriere VARCHAR2(2000);

    BEGIN

    
    SELECT MAX(id_produs)+1 INTO v_id_produs FROM produse;
    

    IF v_id_produs IS NULL THEN v_id_produs := 1; 

  END IF;

  
  DBMS_OUTPUT.PUT_LINE('Introduceti denumirea produsului:');
  

  v_denumire_produs := '&denumire_produs';


  DBMS_OUTPUT.PUT_LINE('Introduceti descrierea produsului:');
  

  v_descriere := '&descriere';

  
  INSERT INTO produse (id_produs, denumire_produs, descriere)
  

  VALUES (v_id_produs, v_denumire_produs, v_descriere);
  

 DBMS_OUTPUT.PUT_LINE('Produs adaugat cu id-ul: ' || v_id_produs);
 

END;