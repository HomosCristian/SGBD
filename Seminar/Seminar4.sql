--CURSORI

--1. Printr-un bloc PL/SQL, sa se atribuie comision angajatilor din departamentul al carui id este citit de la tastatura. 
--Sa se afiseze numarul de modificari totale efectuate. (cursor implicit)

SET SERVEROUTPUT ON;
DECLARE
 v_id angajati.id_angajat%TYPE := &v;
BEGIN
 UPDATE angajati
 SET comision = 0.1
 WHERE id_departament = v_id;
 IF SQL%ROWCOUNT = 0 THEN
 DBMS_OUTPUT.PUT_LINE('Fara modificari!');
 ELSE
 DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' modificari.');
 END IF;
END;


--2. Construiti un bloc PL/SQL prin care sa se afiseze informatii despre angajatii din orasul Toronto.(cursor explicit)

SET SERVEROUTPUT ON;

SELECT nume, salariul, oras --ca sa ajungem de la nagajti la locatii(oras) trecem prin departamente)
FROM angajati JOIN departamente USING (id_departament)
              JOIN locatii USING (id_locatie)
WHERE UPPER(oras) = 'TORONTO';
--sau
SET SERVEROUTPUT ON;
SELECT nume salariul, oras
FROM angajati a, departamente d, locatii l
WHERE a.id.departament=d.id_departament AND
      d.id_locatie=l.id_locatie AND
      UPPER(l.oras)='TORONTO';
      
--Bloc
SET SERVEROUTPUT ON;

DECLARE
    --declarare cursor explicit
    CURSOR c IS SELECT nume, salariul, oras 
        FROM angajati JOIN departamente USING (id_departament)
            JOIN locatii USING (id_locatie)
        WHERE UPPER(oras) = 'TORONTO';
    v c%ROWTYPE;
BEGIN
    --deschidere cursor
    OPEN c;
    --parcurgere cursor
    LOOP
        FETCH c INTO v;
        EXIT WHEN c%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Angajat toronto: ' || v.nume);
    END LOOP;
    CLOSE c;
END;
/

--3. Construiti un bloc PL/SQL prin care sa se afiseze primele 3 comenzi care au cele mai multe produse comandate.(cursor explicit)

SET SERVEROUTPUT ON;

SELECT id_comanda, data, COUNT(id_produs)
FROM comenzi JOIN rand_comenzi USING (id_comanda)
GROUP BY id_comanda, data
ORDER BY COUNT(id_produs) DESC
FETCH FIRST 3 ROWS ONLY;

--Bloc

SET SERVEROUTPUT ON;
DECLARE
 CURSOR c IS SELECT id_comanda, data, COUNT(id_produs) nr_produse
 FROM comenzi JOIN rand_comenzi USING (id_comanda)
 GROUP BY id_comanda, data
 ORDER BY COUNT(id_produs) DESC
 FETCH FIRST 3 ROWS ONLY;
 v c%ROWTYPE;
BEGIN
 FOR v IN c
 LOOP
 DBMS_OUTPUT.PUT_LINE('ID comanda: ' || v.id_comanda || ' cu nr de produse: ' ||
v.nr_produse);
 END LOOP;

END;

--4. Construiti un bloc PL/SQL prin care sa se afiseze, pentru fiecare departament, valoarea totala a salariilor platite angajatilor.(curosr explicit)

SET SERVEROUTPUT ON;

DECLARE
    --declarare cursor explicit
    CURSOR c IS SELECT SUM(salariul) total, id_departament,denumire_departament
                FROM angajati JOIN departamente USING (id_departament)
                GROUP BY id_departament,denumire_departament;
BEGIN
    FOR v IN c
    LOOP
        DBMS_OUTPUT.PUT_LINE('total salarii: ' || v.total || ' id departament: ' || v.id_departament);
    END LOOP;

END;
/



--5. Construiti un bloc PL/SQL prin care sa se afiseze informatii despre angajati, precum ?i numarul de comenzi intermediate de fiecare.(cursor explicit)

SET SERVEROUTPUT ON;

DECLARE
   
    CURSOR c IS SELECT id_angajat, nume, COUNT(id_angajat) nr_comenzi
                    FROM angajati JOIN comenzi USING (id_angajat)
                    GROUP BY nume,id_angajat;
BEGIN
    FOR v IN c
    LOOP
        DBMS_OUTPUT.PUT_LINE('id_angajat: ' || v.id_angajat || ', nume: ' || v.nume || ', nr. comenzi: ' || v.nr_comenzi);
    END LOOP;

END;
/


--6. Construiti un bloc PL/SQL prin care sa se afiseze pentru fiecare departament (id ?i nume) informatii despre angajatii aferenti (id, nume, salariu). Sa se afiseze la nivelul fiec?rui departament ?i salariul total platit.
--Informatiile vor fi afisate în urmatoarea maniera:

SET SERVEROUTPUT ON;

DECLARE
    CURSOR d IS SELECT id_departament, denumire_departament, id_angajat, nume, salariul
                FROM angajati JOIN departamente USING (id_departament);
    CURSOR c IS SELECT SUM(salariul) total, id_departament,denumire_departament
                FROM angajati JOIN departamente USING (id_departament)
                GROUP BY id_departament,denumire_departament;
BEGIN
    FOR v IN c
    LOOP
        DBMS_OUTPUT.PUT_LINE('*departament ' || v.denumire_departament || ' ' || v.id_departament);
        FOR w in d
        LOOP
            DBMS_OUTPUT.PUT_LINE('****** ' || w.id_angajat || ' ' || w.nume || ', salariul: ' || w.salariul);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('Total salarii ' || v.denumire_departament || ': ' || v.total);
    END LOOP;

END;
/
