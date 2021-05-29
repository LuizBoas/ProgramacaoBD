-- Conecte-se ao Oracle Apex (https://apex.oracle.com/i/index.html). 
-- Execute um comando SELECT para exibir os valores da coluna department_id da tabela DEPARTMENTS. 
-- Analise os valores retornados a fim de identificar se existe algum padrão. Crie um bloco PL/SQL anônimo 
-- que recupere e imprima na tela o nome de todos os departamentos. Use um laço WHILE ou LOOP. NÃO use cursor. 
-- Execute o bloco. Copie e cole o código gerado bem como os resultados.

DECLARE
    nome OEHR_DEPARTMENTS.DEPARTMENT_NAME%TYPE; 
    idTotal OEHR_DEPARTMENTS.DEPARTMENT_ID%TYPE; 
    idDep OEHR_DEPARTMENTS.DEPARTMENT_ID%TYPE;     
BEGIN 
    idDep:=0;
    SELECT MAX(DEPARTMENT_ID) 
    INTO idTotal 
    FROM OEHR_DEPARTMENTS; 
    LOOP
        idDep:= idDep + 10;
        SELECT DEPARTMENT_NAME 
        INTO nome 
        FROM OEHR_DEPARTMENTS
        WHERE DEPARTMENT_ID = idDep; 
        dbms_output.put_line(nome);
        EXIT WHEN idDep= idTotal;
    END LOOP;
END;

-- Crie uma tabela chamada SINTETICA com as colunas codigo (PRIMARY KEY) INTEGER, nome VARCHAR2(10), nascimento DATE e sexo CHAR(1). Crie um bloco PL/SQL anônimo para inserir 500 linhas na tabela criada. O povoamento das colunas deve obedecer as seguintes regras:

-- - codigo: valor do contador

-- - nome: se contador for par, deve ser Mr. <valor do contador>. Caso contrário, Mrs. <valor do contador>

-- - nascimento: data atual - valor do contador

-- - sexo: se contador for par, deve ser M. Caso contrário, F.

-- Execute o bloco criado. Execute uma consulta para mostrar a quantidade de valores distintos na coluna nome.

-- Copie e cole o código gerado, bem como os resultados.

--Criação da tabela:

CREATE TABLE sintetica (
codigo INTEGER,
nome VARCHAR2(10),
nascimento DATE,
sexo CHAR(1),
CONSTRAINT sintetica_pk PRIMARY KEY (codigo)
);

--Adcionando as 500 linhas:

BEGIN
    FOR i IN 1..500 LOOP
        IF MOD(i,2) = 0 THEN
            INSERT INTO SINTETICA VALUES (i, 'Mr. ' || i, SYSDATE-i, 'M');
        ELSE
            INSERT INTO SINTETICA VALUES (i, 'Mrs. ' || i, SYSDATE-i, 'F');
        END IF;
    END LOOP;
END;

--Executando uma consulta para mostrar a quantidade de valores distintos na coluna nome:

SELECT COUNT(DISTINCT nome) FROM SINTETICA

