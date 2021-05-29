-- Crie um bloco PL/SQL anônimo que declare duas variáveis e imprima os resultados das variáveis na tela. Execute o bloco PL/SQL. Copie e cole o código e o resultado.

-- V_CHAR                             Character (variable length)

-- V_NUM                             Number

-- Atribua valores a essas variáveis do seguinte modo:

-- Variable              Value

-- --------                  -------------------------------------

-- V_CHAR              O literal a seguir: '42 é a resposta'

-- V_NUM              Os primeiros dois caracteres de V_CHAR

DECLARE
	v_name VARCHAR2(30);
	v_age NUMBER(2);
BEGIN
	v_name := 'Luiz Fernando';
	v_age := 20;
	dbms_output.put_line(v_name||', '||v_age);
END

-- Elabore um bloco PL/SQL que compute a remuneração total (salário + salário * bônus). As variáveis salário anual e a porcentagem do bônus anual devem ser inicializadas na seção executável do bloco. Execute o bloco PL/SQL. Copie e cole o código e o resultado.

-- Exemplo:

-- Salário anual: 50000

-- Percentual de bônus: 10

-- PL/SQL procedure successfully completed.

-- V_TOTAL
-- -------
-- 55000

DECLARE
	s_anual NUMBER;
	s_bonus NUMBER;
    s_total NUMBER;
BEGIN
	s_anual := 50000;
	s_bonus := 50 / 100;
    s_total := s_anual + s_anual * s_bonus;
	dbms_output.put_line(s_total);
END

-- Crie um bloco PL/SQL anônimo que seleciona o maior valor de departamento na tabela DEPARTMENTS e o armazena em uma variável. Imprima o resultado na tela. Execute o bloco PL/SQL. Copie e cole o código e o resultado.

-- V_MAX_DEPTNO
-- ------------
-- 40

DECLARE 
    V_MAX_DEPTNO OEHR_DEPARTMENTS.DEPARTMENT_ID%TYPE; 
BEGIN 
    SELECT MAX(DEPARTMENT_ID) 
    INTO V_MAX_DEPTNO 
    FROM OEHR_DEPARTMENTS; 
    dbms_output.put_line(V_MAX_DEPTNO); 
END;

-- Modifique o bloco PL/SQL que você criou na questão anterior para inserir um novo departamento na tabela DEPARTMENTS.

-- ·        Em vez de imprimir o número do departamento recuperado da questão anterior, adicione 10 a ele e use-o como o número do departamento do novo departamento.

-- ·        Deixe um valor nulo na localização e no número do gerente. Informe o nome do departamento: EDUCATION.

-- ·        Execute o bloco PL/SQL.

-- ·        Com um comando SELECT, exiba o novo departamento criado.

--                DEPTNO DNAME      MAN_ID LOC

--                ------ ---------- ----- -------

--              50 EDUCATION

-- Copie e cole o código e os resultados.

DECLARE 
    V_MAX_DEPTNO OEHR_DEPARTMENTS.DEPARTMENT_ID%TYPE; 
    V_DEPT_NAME OEHR_DEPARTMENTS.DEPARTMENT_NAME%TYPE; 
BEGIN 
    SELECT MAX(DEPARTMENT_ID) INTO V_MAX_DEPTNO FROM OEHR_DEPARTMENTS; 
    Insert into OEHR_DEPARTMENTS values (V_MAX_DEPTNO+10, 'EDUCATION', null, null);
    SELECT MAX(DEPARTMENT_ID) INTO V_MAX_DEPTNO FROM OEHR_DEPARTMENTS; 
    Select DEPARTMENT_ID, DEPARTMENT_NAME INTO V_MAX_DEPTNO, V_DEPT_NAME FROM OEHR_DEPARTMENTS Where DEPARTMENT_ID = V_MAX_DEPTNO;
    dbms_output.put_line('DEPARTMENT_ID     DEPARTMENT_NAME');
    dbms_output.put_line('------ ---------- ----- -------');
    dbms_output.put_line(V_MAX_DEPTNO || '               ' ||V_DEPT_NAME);
END;

