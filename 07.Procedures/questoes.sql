-- Crie uma stored procedure chamada TabelasUsuario para selecionar e imprimir na tela o nome das tabelas (e a quantidade de linhas) 
-- do usuário no qual você está conectado ao Apex. Só devem ser mostradas as tabelas que tiverem mais de n linhas, onde n deve ser 
-- fornecido como parâmetro de entrada para a procedure. A partir de um bloco anônimo, execute a procedure para os seguintes valores 
-- de n: 10 e 100. Apresente o código-fonte e o resultado das execuções.

-- Dicas: usar a visão do dicionário de dados USER_TABLES e o comando EXECUTE IMMEDIATE.

CREATE OR REPLACE PROCEDURE TabelasUsuario(linhas number) IS
    CURSOR cursozinho IS SELECT TABLE_NAME, NUM_ROWS FROM USER_TABLES WHERE linhas < NUM_ROWS;
BEGIN
    FOR userTables IN cursozinho LOOP
        dbms_output.put_line('Tabelas=> '||userTables.TABLE_NAME||'.');
        dbms_output.put_line('Linhas=> '||userTables.NUM_ROWS||'.');
    END LOOP;
    COMMIT;
END

-- Crie uma stored procedure chamada QueryEmp que aceita como parâmetro de entrada um employee_id e como parâmetro de saída um registro 
-- cuja estrutura é igual à estrutura da tabela EMPLOYEES. A procedure deve realizar uma consulta à tabela EMPLOYEES para carregar o 
-- parâmetro de saída de acordo o employee_id fornecido. Em seguida, crie uma stored procedure GetEmp que chama a procedure QueryEmp 
-- fornecendo como employee_id o valor 101. A procedure GetEmp deve imprimir na tela o sobrenome (last_name) do empregado selecionado 
-- por QueryEmp. Execute GetEmp a partir de um bloco anônimo. Mostre o código-fonte e o resultado da execução.

-- Obs.: Não use procedures internas.

QueryEmp=>
CREATE OR REPLACE PROCEDURE QueryEmp(funcionario OUT OEHR_EMPLOYEES%ROWTYPE, idFuncionario NUMBER) IS
BEGIN
      SELECT * INTO funcionario FROM OEHR_EMPLOYEES WHERE OEHR_EMPLOYEES.employee_id = idFuncionario;
END;

GetEmp=>
CREATE OR REPLACE PROCEDURE GetEmp(funcionario OUT OEHR_EMPLOYEES%rowtype) IS
BEGIN
     QueryEmp(funcionario, 101);
     dbms_output.put_line(funcionario.LAST_NAME);
END;

