-- Considere as seguintes tabelas de um Sistema de Controle de Estacionamento:

-- Estacionamento

-- Crie uma função chamada CALCULATARIFA para computar e retornar o valor total a ser cobrado para os estacionamentos de um proprietário. 
-- O CPF deve ser fornecido como entrada. Um proprietário pode ter mais de um veículo cadastrado. A taxa a ser cobrada é de R$ 0,10 por 
-- cada minuto excedido em cada estacionamento que tenha durado mais de 30 minutos. Caso o tempo de um estacionamento não tenha excedido 
-- 30 minutos a taxa é zero. Por exemplo, o proprietário de CPF 939387738-98 fez três estacionamentos com duração de 60, 22 e 32 minutos.
-- O valor total a ser retornado é de 30 (minutos excedidos) * 0,10 (reais) + 0 (minuto excedido) * 0,10 (reais) + 2 (minutos excedidos)
--  * 0,10 (reais) = 3,20 reais. Trate o caso em que não existe registro de estacionamento para o proprietário informado, retornando uma 
--  mensagem de erro. Crie um bloco PL/SQL anônimo para executar a função CALCULATARIFA e imprimir na tela o resultado retornado. 
--  Mostre o código-fonte e o resultado da execução do bloco anônimo.

-- (*) Caso ache necessário, crie e popule as tabelas.

CREATE OR REPLACE FUNCTION CALCULATARIFA (valueCpf VARCHAR2) RETURN FLOAT
IS

idProp Proprietario.Id_Proprietario%TYPE;
counter Registro.Permanencia%TYPE;

CURSOR findCarProp IS SELECT Id_veiculo FROM Veiculo WHERE Id_Proprietario = idProp;
CURSOR registroCar (idCar NUMBER) IS SELECT Permanencia FROM Registro WHERE Id_Veiculo = idCar;

total FLOAT;
checkar NUMBER;
erro EXCEPTION;

BEGIN
    total := 0;
    checkar := 0;
    counter := 0;
    SELECT Id_Proprietario
    INTO idProp
    FROM Proprietario
    WHERE CPF = valueCpf;
    FOR car IN findCarProp LOOP
        FOR carTime IN registroCar(car.Id_Veiculo) LOOP
            counter := carTime.Permanencia;
            checkar := checkar + 1;
            IF (counter > 30) THEN
                total := ((counter - 30) * 0.10) + total;
            END IF;
        END LOOP;
        COMMIT;
    END LOOP;
    COMMIT;
    IF (checkar = 0) THEN
        RAISE erro;
    ELSE
        RETURN total;
    END IF;
EXCEPTION
    WHEN erro THEN
        dbms_output.put_line('O Propietário não tem nenhum carro registrado no estacionamento!');
        RETURN NULL;
END;

TESTES:
BEGIN
   dbms_output.put_line(CALCULATARIFA('939387738-98'));
   dbms_output.put_line(CALCULATARIFA('927272882-12'));
END;

-- Considere as seguintes tabelas de um Sistema de Controle de Estacionamento:

-- Estacionamento

-- Crie a função CATEGORIA que receba o CPF de um proprietário e retorne sua categoria: GOLD, se possui 10 ou mais registros de 
-- estacionamento, SILVER (entre 9 e 5) e BRONZE (entre 1 e 4). Só devem ser considerados registros de estacionamento a partir do 
-- ano de 2001 e com duração de pelo menos 10 minutos. Trate o caso de o valor do CPF não estar cadastrado. Crie um bloco PL/SQL 
-- que chame a função CATEGORIA e imprima na tela a categoria do proprietário. Mostre o código-fonte e o resultado da execução.

-- (*) Se achar necessário, crie e popule as tabelas.

CREATE OR REPLACE FUNCTION CATEGORIA (valueCpf VARCHAR2) RETURN VARCHAR2
IS
   idProp PROPRIETARIO.ID_PROPRIETARIO%TYPE;

   CURSOR findCarProp IS SELECT ID_VEICULO FROM VEICULO WHERE ID_PROPRIETARIO = idProp;
   CURSOR registroCar (idCar REGISTRO.ID_VEICULO%TYPE) IS SELECT * FROM REGISTRO WHERE ID_VEICULO = idCar;

   dateMin DATE;
   counter NUMBER;
   erro EXCEPTION;
BEGIN
   SELECT ID_PROPRIETARIO
   INTO idProp
   FROM PROPRIETARIO
   WHERE CPF = valueCpf;
   counter := 0;
   dateMin := '01/01/2001';
   FOR iFindCarProp IN findCarProp LOOP
       FOR iRegistroCar IN registroCar(iFindCarProp.ID_VEICULO) LOOP
           IF (iRegistroCar.DATA >= dateMin) THEN
               IF (iRegistroCar.PERMANENCIA>=10) THEN
                   counter := counter + 1;
               END IF;
           END IF;
       END LOOP;
   END LOOP;
   IF (counter = 0) THEN
     RAISE erro;
   ELSIF (counter >= 1 and counter < 5) THEN
       RETURN 'BRONZE';
   ELSIF (counter >= 5 and counter <= 9) THEN
       RETURN 'SILVER';
   ELSE
       RETURN 'GOLD';
   END IF;
   COMMIT;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
       dbms_output.put_line('O Propietário não tem cpf cadastrado nesse estabelecimento!');
       RETURN null;
   WHEN erro THEN
       dbms_output.put_line('O Propietário não tem nenhum carro registrado no estacionamento!');
       RETURN null;
END;
