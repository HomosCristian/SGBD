--CURSORI

--1. Printr-un bloc PL/SQL, sa se atribuie comision angajatilor din departamentul al carui id este citit de la tastatura. 
--Sa se afiseze numarul de modificari totale efectuate. (cursor implicit)

SET SERVEROUTPUT ON;

DECLARE
   v_id angajati.id_departament%TYPE := &v;
BEGIN
    
   UPDATE angajati  --curosrul implicit se deschhide automat cand folosim uodate
   SET comision = 0.1
   WHERE id_departament = v_id;
   
   IF SQL%ROWCOUNT = 0 THEN
      DBMS_OUTPUT.PUT_LINE(' Fara modificari ');
      ELSE
      DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT||' modificari ');
      END IF;
END;
/


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
   CURSOR c IS SELECT nume, salariul, oras
               FROM angajati a, departamente d, locatii l
               WHERE a.id.departament=d.id_departament AND d.id_locatie=l.id_locatie AND UPPER(l.oras)='TORONTO';
    v c%ROWTYPE;
BEGIN

OPEN c;
LOOP  --parcurgere cursor
   FETCH c INTO V;
   EXIT WHEN c%NOTFOUND;
   DBMS_OUTPUT.PUT_LINE('Nume: ' || v.nume);
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
BEGIN
CURSOR c IS SELECT id_comanda, data, COUNT(id_produs)
FROM comenzi JOIN rand_comenzi USING (id_comanda)
GROUP BY id_comanda, data
ORDER BY COUNT(id_produs) DESC
FETCH FIRST 3 ROWS ONLY;
FOR v IN c
LOOP
DBMS_OUTPU.PUT_LINE(v.nume);
END;
/

--4. Construiti un bloc PL/SQL prin care sa se afiseze, pentru fiecare departament, valoarea totala a salariilor platite angajatilor.(curosr explicit)

SELECT id_departament, denumire_departament, SUM(salariul), 
FROM angajati JOIN departamente USING(id_departament)
GROUP BY id_departament, denumire_departament, SUM(salriul);


--5. Construiti un bloc PL/SQL prin care sa se afiseze informatii despre angajati, precum ?i numarul de comenzi intermediate de fiecare.(cursor explicit)

--6. Construiti un bloc PL/SQL prin care sa se afiseze pentru fiecare departament (id ?i nume) informatii despre angajatii aferenti (id, nume, salariu). Sa se afiseze la nivelul fiec?rui departament ?i salariul total platit.
--Informatiile vor fi afisate în urmatoarea maniera: