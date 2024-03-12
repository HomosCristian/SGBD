SET SERVEROUTPUT ON SIZE UNLIMITED;


DECLARE
    a NUMBER;
    b NUMBER;
    c NUMBER;
    delta NUMBER;
    x1 NUMBER;
    x2 NUMBER;
BEGIN
    -- Citim coeficientii ecuatiei de la tastatura
    a := &a;
    b := &b;
    c := &c;

    -- Calculam delta ?i solutiile ecuatiei
    delta := b * b - 4 * a * c;

    IF delta > 0 THEN
        x1 := (-b + SQRT(delta)) / (2 * a);
        x2 := (-b - SQRT(delta)) / (2 * a);
        DBMS_OUTPUT.PUT_LINE('Ecuatia are doua solutii reale distincte:');
        DBMS_OUTPUT.PUT_LINE('x1 = ' || x1);
        DBMS_OUTPUT.PUT_LINE('x2 = ' || x2);
    ELSIF delta = 0 THEN
        x1 := -b / (2 * a);
        DBMS_OUTPUT.PUT_LINE('Ecuatia are o solutie reala dubla:');
        DBMS_OUTPUT.PUT_LINE('x = ' || x1);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ecuatia nu are solutii reale.');
    END IF;
END;
/
