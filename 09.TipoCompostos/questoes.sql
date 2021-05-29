-- Crie um bloco PL/SQL anônimo para recuperar o employee_id e o last_name dos empregados. 
-- Carregue o resultado recuperado em uma PL/SQL table (o índice da PL/SQL table deve corresponder ao employee_id recuperado).
-- A partir da PL/SQL table, imprima na tela o last_name dos empregados. Execute o bloco PL/SQL criado. Mostre o código e o resultado 
-- da execução. Crie apenas o que está sendo solicitado.

DECLARE
    TYPE employee_table IS TABLE OF VARCHAR2(20) index BY BINARY_INTEGER;
    lv_employee employee_table;
BEGIN
    FOR i IN (SELECT EMPLOYEE_ID , LAST_NAME FROM OEHR_EMPLOYEES) LOOP
        lv_employee(i.EMPLOYEE_ID) := i.LAST_NAME;
    END LOOP;

    FOR j IN lv_employee.FIRST..lv_employee.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(lv_employee(j));
    END LOOP;
END;

-- Altere o código da questão anterior para recuperar não apenas as colunas employee_id e last_name, mas sim todas as 
-- colunas de employees. Novamente, carregue o resultado recuperado em uma PL/SQL table (o índice da PL/SQL table deve corresponder 
-- ao employee_id recuperado). A partir da PL/SQL table, imprima na tela o last_name, email e job_id dos empregados. 
-- Execute o bloco PL/SQL criado. Mostre o código e o resultado da execução. Crie apenas o que está sendo solicitado.

DECLARE
    TYPE employee_table IS TABLE OF OEHR_EMPLOYEES%ROWTYPE index BY BINARY_INTEGER;
    lv_employee employee_table;
BEGIN
    FOR i IN (SELECT * FROM OEHR_EMPLOYEES) LOOP
        lv_employee(i.EMPLOYEE_ID) := i;
    END LOOP;

    FOR j IN lv_employee.FIRST..lv_employee.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(lv_employee(j).last_name);
        DBMS_OUTPUT.PUT_LINE(lv_employee(j).email);
        DBMS_OUTPUT.PUT_LINE(lv_employee(j).job_id);
        DBMS_OUTPUT.PUT_LINE('                   ');
    END LOOP;
END;