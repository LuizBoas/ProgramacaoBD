-- Conecte-se ao Oracle Apex (https://apex.oracle.com/i/index.html). Crie um bloco anônimo que recupere o sobrenome (last_name) e o email do empregado 101, bem como o nome do seu departamento. Os valores recuperados devem ser atribuídos a um registro. Imprima os valores na tela no seguinte formato:

-- Last_name: Kochhar

-- Email: NKOCHHAR@store.com

-- Department_name: Executive

-- Copie e cole o código-fonte e o resultado da execução do bloco.

DECLARE
    LAST_NAME OEHR_EMPLOYEES.LAST_NAME%TYPE;
    EMAIL OEHR_EMPLOYEES.EMAIL%TYPE;
    DEPARTMENT_ID_EMPLOYEES OEHR_EMPLOYEES.DEPARTMENT_ID%TYPE;
    DEPARTMENT_NAME OEHR_DEPARTMENTS.DEPARTMENT_NAME%TYPE;

BEGIN
  SELECT LAST_NAME, EMAIL, DEPARTMENT_ID
  INTO LAST_NAME, EMAIL, DEPARTMENT_ID_EMPLOYEES
  FROM OEHR_EMPLOYEES 
  WHERE OEHR_EMPLOYEES.EMPLOYEE_ID = 101;

  SELECT DEPARTMENT_NAME
  INTO DEPARTMENT_NAME
  FROM OEHR_DEPARTMENTS
  WHERE OEHR_DEPARTMENTS.DEPARTMENT_ID = DEPARTMENT_ID_EMPLOYEES;

  dbms_output.put_line(concat('Last_name: ', INITCAP(LAST_NAME)));
  dbms_output.put_line(concat('Email: ', concat(UPPER(EMAIL), '@store.com')));
  dbms_output.put_line(concat('Department_name: ',INITCAP(DEPARTMENT_NAME)));
END;

-- Crie um bloco PL/SQL anônimo que identifica o empregado que começou a trabalhar há mais tempo na empresa. 
-- Em seguida, imprima na tela a situação do empregado em relação à aposentadoria. Por exemplo, 
-- se ele já trabalhou mais de 25 anos, imprima "Apto"; "Inapto", caso contrário. 
-- Copie e cole o código-fonte e o resultado da execução do bloco.

DECLARE
  DATE_CONTRACT OEHR_EMPLOYEES.HIRE_DATE%TYPE;
  MOUNTHS_TOTAL NUMBER;
  MESES_EMPLOYEE NUMBER;
BEGIN
  MOUNTHS_TOTAL := 12*25;

  SELECT MIN(HIRE_DATE)
  INTO DATE_CONTRACT
  FROM OEHR_EMPLOYEES;

  MESES_EMPLOYEE := MONTHS_BETWEEN(SYSDATE, DATE_CONTRACT);
  IF(MESES_EMPLOYEE>MOUNTHS_TOTAL) THEN
      dbms_output.put_line('Apto');
  ELSE
     dbms_output.put_line('Inapto');
  END IF;
END;
