-- Crie um bloco PL/SQL anônimo que recupera o e-mail de um empregado cujo valor do código (employee_id) deve ser fornecido por 
-- intermédio de uma variável local numérica. Imprima o e-mail recuperado. Caso nenhuma email seja recuperado, 
-- o bloco deve tratar o erro imprimindo a mensagem "Empregado inexistente". 
-- Caso seja atribuído um valor não numérico à variável local, o bloco também deve tratar o erro imprimindo a mensagem "Código inválido". 
-- NÃO use o handler OTHERS. Execute o bloco PL/SQL três vezes atribuindo os seguintes valores à variável local em cada execução: 
-- 101, 999 e '101a'. Copie e cole o código produzido, bem como o resultado das três execuções. Faça apenas o que está sendo pedido.

DECLARE
    id_Dinamico OEHR_EMPLOYEES.EMPLOYEE_ID%TYPE;
    email OEHR_EMPLOYEES.EMAIL%TYPE; 
BEGIN
    id_Dinamico := 101;
    Select EMAIL
    INTO email
    FROM OEHR_EMPLOYEES
    WHERE EMPLOYEE_ID = id_Dinamico;
    dbms_output.put_line('Email: '||email);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Empregado inexistente');
    WHEN value_error THEN
        dbms_output.put_line('Código inválido');
END

-- Crie um bloco PL/SQL que recupere o maior salário e a média salarial. Se a diferença entre o maior salário e a média dos salários 
-- for menor que a constante 5000, imprima 'Dentro da lei'; caso contrário, dispare uma exceção definida pelo usuário e imprima 
-- 'Lei violada'. NÃO use o handler OTHERS. Execute o bloco PL/SQL duas vezes atribuindo os seguintes valores à constante em cada execução: 
-- 15000 e 25000. Copie e cole o código produzido, bem como o resultado das duas execuções. Faça apenas o que está sendo pedido.

DECLARE
   salaryMax OEHR_EMPLOYEES.SALARY%TYPE;
   salaryMedia OEHR_EMPLOYEES.SALARY%TYPE;
   constante CONSTANT NUMBER := 25000;
   x EXCEPTION;
BEGIN
   SELECT MAX(SALARY)
   INTO salaryMax
   FROM OEHR_EMPLOYEES;
   SELECT AVG(SALARY)
   INTO salaryMedia
   FROM OEHR_EMPLOYEES;
   IF salaryMax - salaryMedia < constante THEN
       dbms_output.put_line('Dentro da lei');
   ELSE
       RAISE x;
   END IF;
EXCEPTION
   WHEN x THEN
       dbms_output.put_line('Lei violada');
END;