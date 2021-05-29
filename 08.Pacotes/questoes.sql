-- Crie um pacote chamado DDPACK contendo uma procedure chamada GETINVALIDOBJ. A procedure deve receber como parâmetro um tipo de objeto 
-- (e.g. PROCEDURE, FUNCTION, etc.) e imprimir na tela o nome dos objetos do tipo fornecido como entrada que estão inválidos no 
-- banco de dados. Crie tanto a especificação quanto o corpo do pacote. Execute a procedure empacotada para listar as funções inválidas, 
-- a partir de um bloco anônimo. Mostre código e resultado da execução.

CREATE OR REPLACE PACKAGE DDPACK IS
    PROCEDURE GETINVALIDOBJ
    (tipoObjeto ALL_OBJECTS.OBJECT_TYPE%TYPE);
END DDPACK;
 
CREATE OR REPLACE PACKAGE BODY DDPACK IS
    PROCEDURE GETINVALIDOBJ(tipoObjeto ALL_OBJECTS.OBJECT_TYPE%TYPE) IS
        counter NUMBER := 0;
        CURSOR cursozinho(vTipoObjeto ALL_OBJECTS.OBJECT_TYPE%TYPE) IS 
            SELECT DISTINCT OBJECT_NAME 
            FROM ALL_OBJECTS 
            WHERE OBJECT_TYPE = vTipoObjeto AND STATUS = 'INVALID';
        BEGIN
            FOR i IN cursozinho(tipoObjeto) LOOP
                dbms_output.put_line(i.OBJECT_NAME);
                counter := counter + 1;
            END LOOP;
        COMMIT;
        IF counter = 0 THEN
            dbms_output.put_line('Não existe objetos inválidos desse tipo.');
        END IF;
    END GETINVALIDOBJ;
END DDPACK;

-- Adicione ao pacote DDPACK uma função GENERATESTAT para gerar estatísticas sobre todas as tabelas do usuário. 
-- Essas estatísticas incluem informações sobre o número de linhas de uma tabela, a distribuição dos dados, etc. e são úteis 
-- para o Otimizador de Consultas do Oracle. A função não recebe parâmetros e deve retornar um inteiro que corresponde ao número de 
-- tabelas que tiveram estatísticas geradas. Para tal, use os comandos ANALYZE TABLE .. GENERATE STATISTICS e EXECUTE IMMEDIATE. 
-- Recrie tanto a especificação quanto o corpo do pacote DDPACK. Execute a função empacotada GENERATESTAT a partir de um bloco anônimo. 
-- Mostre código e resultado da execução.

CREATE OR REPLACE PACKAGE DDPACK IS
    PROCEDURE GETINVALIDOBJ(tipoObjeto ALL_OBJECTS.OBJECT_TYPE%TYPE);
    FUNCTION GENERATESTAT RETURN NUMBER;
END;

CREATE OR REPLACE PACKAGE BODY DDPACK IS
    PROCEDURE GETINVALIDOBJ(tipoObjeto ALL_OBJECTS.OBJECT_TYPE%TYPE) IS
        counter NUMBER := 0;
        CURSOR cursozinho(vTipoObjeto ALL_OBJECTS.OBJECT_TYPE%TYPE) IS 
            SELECT DISTINCT OBJECT_NAME 
            FROM ALL_OBJECTS 
            WHERE OBJECT_TYPE = vTipoObjeto AND STATUS = 'INVALID';
        BEGIN
            FOR i IN cursozinho(tipoObjeto) LOOP
                dbms_output.put_line(i.OBJECT_NAME);
                counter := counter + 1;
            END LOOP;
        COMMIT;
        IF counter = 0 THEN
            dbms_output.put_line('Não existe objetos invalidos desse tipo.');
        END IF;
    END GETINVALIDOBJ;

    FUNCTION GENERATESTAT RETURN NUMBER IS
        counter2 NUMBER := 0;
        CURSOR cursozinho2 IS 
            SELECT OBJECT_NAME 
            FROM USER_OBJECTS 
            WHERE OBJECT_TYPE = 'TABLE';
        BEGIN
            FOR j IN cursozinho2 LOOP
                 counter2 := counter2 + 1;
                EXECUTE IMMEDIATE 'ANALYZE TABLE ' || j.OBJECT_NAME || ' COMPUTE STATISTICS';
            END LOOP;
        RETURN counter2;
    END;
END;

DECLARE
    calculoEst NUMBER;
BEGIN
    calculoEst := DDPACK.GENERATESTAT();
    DBMS_OUTPUT.PUT_LINE(calculoEst);
END;
