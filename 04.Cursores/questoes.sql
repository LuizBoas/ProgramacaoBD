-- Crie um bloco PL/SQL anônimo para recuperar o salário do empregado 101, 
-- atribuindo o resultado a uma variável. Em seguida, no mesmo bloco, imprima o valor do atributo de cursor implícito %ROWCOUNT. 
-- Ainda, imprima "aberto" caso o valor de %ISOPEN seja TRUE; "fechado", caso contrário. De modo análogo, 
-- imprima "encontrou" caso o valor de %FOUND seja TRUE; "não encontrou", caso contrário. Execute o bloco PL/SQL. 
-- Copie e cole o código produzido, bem como o resultado da execução.

DECLARE
 REC_SALARY OEHR_EMPLOYEES.SALARY%TYPE;
BEGIN
 SELECT SALARY INTO REC_SALARY FROM OEHR_EMPLOYEES WHERE EMPLOYEE_ID = 101;
 dbms_output.put_line('%ROWCOUNT: '|| SQL%ROWCOUNT);
 IF SQL%ISOPEN THEN
 dbms_output.put_line('aberto');
 ELSE
 dbms_output.put_line('fechado');
 END IF;
 IF SQL%FOUND THEN
 dbms_output.put_line('encontrou');
 ELSE
 dbms_output.put_line('não encontrou');
 END IF;
END;

-- Crie um bloco PL/SQL anônimo contendo um cursor que recupere o nome dos departamentos e a quantidade de empregados dos departamentos, 
-- mas apenas dos departamentos com mais de 5 funcionários. A cada iteração do laço, imprima o valor do atributo de cursor explícito 
-- %ROWCOUNT, bem como o nome do departamento e a quantidade de empregados. Use um laço LOOP e a opção %ROWTYPE. 
-- Execute o bloco PL/SQL. Copie e cole o código produzido, bem como o resultado da execução.

DECLARE
 REC_SALARY OEHR_EMPLOYEES.SALARY%TYPE;
BEGIN
 SELECT SALARY INTO REC_SALARY FROM OEHR_EMPLOYEES WHERE EMPLOYEE_ID = 101;
 dbms_output.put_line('%ROWCOUNT: '|| SQL%ROWCOUNT);
 IF SQL%ISOPEN THEN
 dbms_output.put_line('aberto');
 ELSE
 dbms_output.put_line('fechado');
 END IF;
 IF SQL%FOUND THEN
 dbms_output.put_line('encontrou');
 ELSE
 dbms_output.put_line('não encontrou');
 END IF;
END;

-- Reescreva o código da questão anterior usando um laço FOR. Execute o bloco PL/SQL. Copie e cole o código produzido, 
-- bem como o resultado da execução.

DECLARE
    CURSOR DEPARTMENTS_CURSOR IS SELECT DEPARTMENT_ID, DEPARTMENT_NAME FROM OEHR_DEPARTMENTS;
    QUANTITY_OF_EMPLOYEES number;
BEGIN
    FOR REC_DEP IN DEPARTMENTS_CURSOR LOOP
        SELECT COUNT(*) INTO QUANTITY_OF_EMPLOYEES FROM OEHR_EMPLOYEES WHERE DEPARTMENT_ID = REC_DEP.DEPARTMENT_ID;
        IF QUANTITY_OF_EMPLOYEES > 5 THEN
            dbms_output.put_line('%ROWCOUNT: ' || DEPARTMENTS_CURSOR%ROWCOUNT || ', DEPARTMENT_NAME: ' || REC_DEP.DEPARTMENT_NAME || ',  QUANTITY_OF_EMPLOYEES: ' || QUANTITY_OF_EMPLOYEES);
        END IF;
    END LOOP;
END;
