/*
Variabile: -locale, PL/SQL
            -non PL/SQL (globale, de substitutie)            
*/
SET SERVEROUTPUT ON   
/*pt dbms*/
ACCEPT a PROMPT 'Introdu valoarea'
VAR b NUMBER

DECLARE
  v_nr NUMBER(5,2) := 123.456;   /*precizie 5, sacala 2*/
  v_data DATE := SYSDATE;  --CURRENT_DATE
  v_tmsp TIMESTAMP := SYSTIMESTAMP; --CURRENT_TIMESTAMP
  v_text VARCHAR2(20) := '&a';    

BEGIN
  DBMS_OUTPUT.put_line(v_nr);
  DBMS_OUTPUT.put_line(v_data);  /*afiseaza doar data*/
  DBMS_OUTPUT.put_line(TO_CHAR(v_data,'DD-MM-YYYY, HH:Mi:SS'));   /*afiseaza data si ora*/
  DBMS_OUTPUT.put_line(v_tmsp);   /*afiseaza data si ora+milisecunde*/
  DBMS_OUTPUT.put_line(LENGTH(v_text));
  :b := TRUNC(v_nr);
  DBMS_OUTPUT.put_line(:b);

END;
/

PRINT b

SELECT * FROM angajati WHERE id_angajat = :b;

--EXERCITII
--1. Sa se afiseze nume, venit, vechime

DECLARE
  v_nume angajati.nume%TYPE;
  v_venit NUMBER;
  v_vechime NUMBER;
  v_id angajati.id_angajat%TYPE := &id;
BEGIN
  SELECT nume, salariul+salariul*NVL(comision,0), (SYSDATE-data_angajare)/365   --FUNCTIA NVL RETURNEAZA AL DOILEA ARGUMENT ADICA 0 DACA COMISIONUL ESTE NULL
  INTO v_nume, v_venit, v_vechime
  FROM angajati
  WHERE id_angajat=v_id;
  DBMS_OUTPUT.put_line (v_nume||' are venitul '||v_venit||' si vechimea '||ROUND(v_vechime));
  

END;
