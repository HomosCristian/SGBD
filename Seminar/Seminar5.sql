--1. Crea?i un bloc PL/SQL pentru a selecta codul ?i data de încheiere a comenzilor încheiate într-un an introdus de la tastatur? (prin comand? SELECT simpl?, f?r? s? utiliza?i un cursor explicit).
--
--dac? interogarea returneaz? mai mult de o valoare pentru codul comenzii, trata?i excep?ia cu o rutin? de tratare corespunz?toare ?i afi?a?i mesajul “Aten?ie! In anul yyyy s-au încheiat mai multe comenzi!”;
--dac? interogarea nu returneaz? nicio valoare pentru codul comenzii, trata?i excep?ia cu o rutin? de tratare corespunz?toare ?i afi?a?i mesajul “Aten?ie! In anul yyyy nu s-au încheiat comenzi!”;
--dac? se returneaz? o singur? linie, afi?a?i codul ?i data comenzii;
--trata?i orice alt? excep?ie cu o rutin? de tratare corespunz?toare ?i afi?a?i mesajul “A ap?rut o alt? excep?ie!”.

SET SERVEROUTPUT ON;

DECLARE
    v_id VARCHAR2(10);
    v_date DATE;
    v_an NUMBER := &an;
BEGIN

    SELECT id_comanda, data
    INTO v_id, v_date
    FROM comenzi
    WHERE EXTRACT(YEAR FROM data) = v_an;
    
    -- Afi?area rezultatului daca s-a gasit o singur? valoare
    DBMS_OUTPUT.PUT_LINE('Codul comenzii: ' || v_id || ', Anul încheierii: ' || v_an);
EXCEPTION
    -- Tratarea cazului în care interogarea returneaza mai mult de o valoare
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Atentie! În anul ' || v_an || ' s-au încheiat mai multe comenzi!');

    
    -- Tratarea cazului în care interogarea nu returneaz? nicio valoare
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Atentie! În anul ' || v_an || ' nu s-au încheiat comenzi!');

    -- Tratarea altor excep?ii
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('A ap?rut o alta exceptie!');
    
END;
/


--2. Crea?i un bloc PL/SQL prin care se dubleaz? pre?ul produsului (pret_lista) al c?rui cod este citit de la tastatur?. În cazul în care acesta nu exist? (comanda UPDATE nu realizeaz? nicio modificare) se va invoca o excep?ie. Trata?i excep?ia prin afi?area unui mesaj.

SET SERVEROUTPUT ON;

DECLARE
    v_id produse.id_produs%TYPE := &a;
    produs_inexistent EXCEPTION;
BEGIN
    -- Dublarea pre?ului produsului
    UPDATE produse
    SET pret_lista = pret_lista * 2
    WHERE id_produs = v_id;

    -- Verificarea dac? s-a realizat actualizarea
    IF SQL%ROWCOUNT = 0 THEN
        -- Tratarea cazului în care nu s-a g?sit niciun produs cu codul specificat
        RAISE produs_inexistent;
    ELSE
        -- Afi?area mesajului de confirmare
        DBMS_OUTPUT.PUT_LINE('OK');
        END IF;
EXCEPTION
    -- Tratarea exceptiei generate atunci când nu se g?se?te niciun produs cu codul specificat
    WHEN produs_inexistent THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista produsul');
    
END;
/


--3. Într-un bloc PL/SQL citi?i de la tastatur? identificatorul unui produs. Afi?a?i denumirea produsului care are acel cod. De asemenea, calcula?i cantitatea total? comandat? din acel produs.

--afi?a?i denumirea produsului;
--dac? produsul nu exist?, trata?i excep?ia cu o rutin? de tratare corespunz?toare;
--dac? produsul nu a fost comandat, invoca?i o excep?ie, care se va trata corespunz?tor;
--dac? produsul exist? ?i a fost comandat, afi?a?i cantitatea total? comandat?;
--trata?i orice alt? excep?ie cu o rutin? de tratare corespunz?toare.

SET SERVEROUTPUT ON;

DECLARE

v_id produse.id_produs%TYPE;
V_denumire produse.denumire_produs%TYPE; 
v_cantitate rand_comenzi.cantitate%TYPE;
v_total NUMBER;
produs_necomandat EXCEPTION;

BEGIN

v_id := &a;

SELECT id_produs, denumire_produs 
INTO v_id, v_denumire
FROM produse WHERE id_produs = v_id;

DBMS_OUTPUT.PUT_LINE(v_denumire);

SELECT SUM(cantitate) INTO v_total
FROM rand_comenzi
WHERE id_produs = v_id;

IF v_total IS NULL THEN
RAISE produs_necomandat;
        ELSE
        DBMS_OUTPUT.PUT_LINE('Cantitate totala: ' || v_total);
        END IF;

EXCEPTION
 WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Produs inexistent!');
 WHEN produs_necomandat THEN DBMS_OUTPUT.PUT_LINE('Produsul exista dar nu a fost comandat!');

END;
/

