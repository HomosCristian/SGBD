--1. Într-un bloc PL/SQL sa se modifice salariul angajatului citit de la tastatura în functie de numarul de comenzi pe care acesta le-a intermediat. Urmariti pasii:
-- initial, se vor afisa numele si salariul angajatului citit de la tastatura
-- se va calcula si se va afisa numarul de comenzi intermediate de angajatul respectiv
-- în cazul în care acesta este între 3 si 7, salariul angajatului va creste cu 10%
-- în cazul în care acesta este mai mare decât 7, salariul angajatului va cre?te cu 20%
-- altfel, salariul angajatului ramâne nemodificat
-- se va opera modificarea salariului la nivelul tabelei
-- la final, se va afisa salariul nou al angajatului respectiv

SET SERVEROUTPUT ON;

DECLARE
    v_id_angajat angajati.id_angajat%TYPE;
    v_nume angajati.nume%TYPE;
    v_salariu angajati.salariul%TYPE;
    v_nr NUMBER;
BEGIN
    v_id_angajat := &id_angajat;
    SELECT salariul,nume INTO v_salariu, v_nume
    FROM angajati
    WHERE id_angajat = v_id_angajat;
    
    dbms_output.put_line(v_nume || ' are salariul ' || v_salariu);
    SELECT COUNT(id_comanda) INTO v_nr
    FROM comenzi
    WHERE id_angajat = v_id_angajat;
    dbms_output.put_line('Nr comenzi: ' || v_nr);
    
    CASE 
        WHEN v_nr BETWEEN 3 AND 7 THEN
            v_salariu := v_salariu * 1.1;
        WHEN v_nr > 7 THEN
            v_salariu := v_salariu * 1.2;
        ELSE NULL;
    END CASE;
    
    UPDATE angajati
    SET salariul = v_salariu
    WHERE id_angajat = v_id_angajat
    RETURNING salariul INTO v_salariu;
    
    DBMS_OUTPUT.put_line('Salariul angajatului cu id-ul ' || v_id_angajat || ': ' || v_salariu);
    
END;
/

-- 2. Într-un bloc PL/SQL sa se parcurga toti angajatii cu id_angajat de la 100 la 120, afisând numele, salariul si vechimea.
SET SERVEROUTPUT ON;

DECLARE
    v_id_angajat angajati.id_angajat%TYPE;
    v_nume angajati.nume%TYPE;
    v_salariu angajati.salariul%TYPE;
    v_vechime NUMBER(4,2);
BEGIN
    FOR i IN 100..120 LOOP
        SELECT salariul,nume, (SYSDATE-data_angajare)/365 
        INTO v_salariu, v_nume, v_vechime
        FROM angajati
        WHERE id_angajat = i;
            
        DBMS_output.put_line(i || '-' || v_nume || ' are salariul ' || v_salariu || ' si vechimea ' || v_vechime);
    END LOOP;
END;
/


-- 3. Într-un bloc PL/SQL sa se parcurga toti angajatii, folosind pe rând structurile: FOR-LOOP, WHILE-LOOP, LOOP-EXIT WHEN

-- FOR-LOOP

SET SERVEROUTPUT ON;

DECLARE
    v_id_angajat angajati.id_angajat%TYPE;
    v_nume angajati.nume%TYPE;
    v_salariu angajati.salariul%TYPE;
    v_vechime NUMBER(4,2);
BEGIN
    FOR i IN 100..120 LOOP
        SELECT salariul,nume, (SYSDATE-data_angajare)/365 
        INTO v_salariu, v_nume, v_vechime
        FROM angajati
        WHERE id_angajat = i;
            
        DBMS_output.put_line(i || '-' || v_nume || ' are salariul ' || v_salariu || ' si vechimea ' || v_vechime);
    END LOOP;
END;
/

-- LOOP-EXIT WHEN

SET SERVEROUTPUT ON;

DECLARE
    v_id_angajat angajati.id_angajat%TYPE;
    v_nume angajati.nume%TYPE;
    v_salariu angajati.salariul%TYPE;
    v_vechime NUMBER(4,2);
    i NUMBER;
BEGIN
    i:= 100;
    LOOP
        SELECT salariul,nume, (SYSDATE-data_angajare)/365 
        INTO v_salariu, v_nume, v_vechime
        FROM angajati
        WHERE id_angajat = i;
        i := i +1;
        EXIT WHEN i = 121;
        DBMS_output.put_line(i || '-' || v_nume || ' are salariul ' || v_salariu || ' si vechimea ' || v_vechime);
    END LOOP;
            
END;
/


-- WHILE-LOOP

SET SERVEROUTPUT ON;

DECLARE
    v_id_angajat angajati.id_angajat%TYPE;
    v_nume angajati.nume%TYPE;
    v_salariu angajati.salariul%TYPE;
    v_vechime NUMBER(4,2);
    i NUMBER;
BEGIN
    i:= 100;
    WHILE i < 120
    LOOP
        SELECT salariul,nume, (SYSDATE-data_angajare)/365 
        INTO v_salariu, v_nume, v_vechime
        FROM angajati
        WHERE id_angajat = i;
        i := i +1;
        DBMS_output.put_line(i || '-' || v_nume || ' are salariul ' || v_salariu || ' si vechimea ' || v_vechime);
    END LOOP;
            
END;
/

--Sa se selecteze toti angajatii

SET SERVEROUTPUT ON;

DECLARE
    v_id_angajat angajati.id_angajat%TYPE;
    v_nume angajati.nume%TYPE;
    v_salariu angajati.salariul%TYPE;
    v_vechime NUMBER(4,2);
    v_min NUMBER;
    v_max NUMBER;
BEGIN
    SELECT MIN(id_angajat), MAX(id_angajat) INTO v_min, v_max
    FROM angajati;
    FOR i IN v_min..v_max LOOP
        SELECT salariul,nume, (SYSDATE-data_angajare)/365 
        INTO v_salariu, v_nume, v_vechime
        FROM angajati
        WHERE id_angajat = i;
            
        DBMS_output.put_line(i || '-' || v_nume || ' are salariul ' || v_salariu || ' si vechimea ' || v_vechime);
    END LOOP;
END;
/

-- 4. Printr-o comanda SQL simpla, sa se stearga angajatul cu id_angajat 150
DELETE FROM angajati WHERE id_angajat = 150;


-- 5. Într-un bloc PL/SQL s? se parcurg? to?i angaja?ii, folosind pe rând structurile: FOR-LOOP, WHILE-LOOP, LOOP-EXIT WHEN

-- FOR-LOOP

SET SERVEROUTPUT ON;

DECLARE
    v_id_angajat angajati.id_angajat%TYPE;
    v_nume angajati.nume%TYPE;
    v_salariu angajati.salariul%TYPE;
    v_vechime NUMBER(4,2);
    v_min NUMBER;
    v_max NUMBER;
    v_nr NUMBER;
BEGIN
    SELECT MIN(id_angajat), MAX(id_angajat) INTO v_min, v_max
    FROM angajati;
    FOR i IN v_min..v_max LOOP
        SELECT COUNT(id_angajat) INTO v_nr
        FROM angajati
        WHERE id_angajat = i;
        
        IF v_nr=1 THEN 
            SELECT salariul,nume, (SYSDATE-data_angajare)/365 
            INTO v_salariu, v_nume, v_vechime
            FROM angajati
            WHERE id_angajat = i;
                
            DBMS_output.put_line(i || '-' || v_nume || ' are salariul ' || v_salariu || ' si vechimea ' || v_vechime);
        ELSE 
            DBMS_output.put_line(i || ' nu exista');
        END IF;
    END LOOP;
END;
/

-- WHILE-LOOP
    
SET SERVEROUTPUT ON;

DECLARE
    v_id_angajat angajati.id_angajat%TYPE;
    v_nume angajati.nume%TYPE;
    v_salariu angajati.salariul%TYPE;
    v_vechime NUMBER(4,2);
    v_min NUMBER;
    v_max NUMBER;
    v_counter NUMBER := 1; 
BEGIN
    SELECT MIN(id_angajat), MAX(id_angajat) INTO v_min, v_max
    FROM angajati;
    
    WHILE v_counter <= v_max LOOP
        SELECT COUNT(id_angajat) INTO v_id_angajat
        FROM angajati
        WHERE id_angajat = v_counter;
        
        IF v_id_angajat = 1 THEN 
            SELECT salariul, nume, (SYSDATE - data_angajare) / 365 
            INTO v_salariu, v_nume, v_vechime
            FROM angajati
            WHERE id_angajat = v_counter;
                
            DBMS_output.put_line(v_counter || '-' || v_nume || ' are salariul ' || v_salariu || ' si vechimea ' || v_vechime);
        ELSE 
            DBMS_output.put_line(v_counter || ' nu exista');
        END IF;
        
        v_counter := v_counter + 1;
    END LOOP;
END;
/

-- LOOP-EXIT WHEN
    
SET SERVEROUTPUT ON;

DECLARE
    v_id_angajat angajati.id_angajat%TYPE;
    v_nume angajati.nume%TYPE;
    v_salariu angajati.salariul%TYPE;
    v_vechime NUMBER(4,2);
    v_min NUMBER;
    v_max NUMBER;
    v_counter NUMBER := 1; 
BEGIN
    SELECT MIN(id_angajat), MAX(id_angajat) INTO v_min, v_max
    FROM angajati;
    
    LOOP
        SELECT COUNT(id_angajat) INTO v_id_angajat
        FROM angajati
        WHERE id_angajat = v_counter;
        
        IF v_id_angajat = 1 THEN 
            SELECT salariul, nume, (SYSDATE - data_angajare) / 365 
            INTO v_salariu, v_nume, v_vechime
            FROM angajati
            WHERE id_angajat = v_counter;
                
            DBMS_output.put_line(v_counter || '-' || v_nume || ' are salariul ' || v_salariu || ' si vechimea ' || v_vechime);
        ELSE 
            DBMS_output.put_line(v_counter || ' nu exista');
        END IF;
        
        EXIT WHEN v_counter = v_max; 
        
        v_counter := v_counter + 1;
    END LOOP;
END;
/
