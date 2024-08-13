--1.Retornar o n�mero de clientes cadastrados no banco de dados. 

select count(*) from clientes; 

-- Count(*) fun��o que conta a quantidade 

 

--2. Qual o total de clientes que possuem empr�stimos, sem repeti��o. 

select count(distinct codigoCli) as total from emprestimos; 

--count (distinct codigoCli) a funcao distinct est� contando sem repetir 

 

--3. Qual o maior valor deposito no banco de c�digo 5. 

select max(saldo) from depositos where codigoAg = 5; 

--max  fun��o para achar o maior valor 

 

--4. Qual a m�dia dos valores depositados na agencia 2. 

select avg(saldo) from depositos where codigoAg = 2; 

--avg fun��o para fazer a media com os valores  

 

--5. Liste o total do empr�stimo de cada cliente. Liste o nome do cliente e o total de empr�stimo. 

select a.nome, sum(d.quantia) as Total_Emprestimos 

from clientes a inner join emprestimos d  

on a.codigoCli = d.codigoCli group by d.codigoCli; 

---as serve para dar um novo nome  

 

--6. Liste o nome dos clientes com dep�sitos saldo superior a R$ 5000. 

select a.nome, sum(d.saldo) as Total_Depositos 

from clientes a inner join depositos d  

on a.codigoCli = d.codigoCli group by d.codigoCli having sum(d.saldo)> 5000; 

 

 

 

--7. Liste o nome do cliente, sua cidade e o seu total de empr�stimo. 

select a.nome as Nome, ci.nomeCid, sum(d.quantia) as Total_Emprestimos 

from clientes a inner join emprestimos d  

on a.codigoCli = d.codigoCli inner join agencias ag on d.codigoAg = ag.codigoAg  

inner join endereco ed on ag.codigoEnd = ed.codigoEnd inner join bairro ba on ed.codigoBairro = ba.codigoBairro  

inner join cidade ci on ba.codigoCid = ci.codigoCid group by d.codigoCli, ci.codigoCid; 

 

--8. Liste o endere�o dos clientes que possuem empr�stimos maiores que R$ 15000. 

select a.nome as Nome,  sum(d.saldo) as Total_saldo 

from clientes a inner join depositos d  

on a.codigoCli = d.codigoCli inner join agencias ag on d.codigoAg = ag.codigoAg  

inner join emprestimos em on ag.codigoAg = em.codigoAg group by d.codigoCli, ci.codigoCid; 

 

--9. Listar o saldo de cada cliente e o quanto eles emprestaram. 

SELECT  

    c.nome AS NomeCliente, 

    SUM(d.saldo) AS Saldo, 

    SUM(e.quantia) AS TotalEmprestimos 

FROM clientes c 

LEFT JOIN depositos d ON c.codigoCli = d.codigoCli 

LEFT JOIN emprestimos e ON c.codigoCli = e.codigoCli 

GROUP BY c.nome; 

 

--10. Qual o total de empr�stimos nas ag�ncias de Presidente Prudente? 

select  ci.nomeCid, sum(d.quantia) as Total_Emprestimos 

from clientes a inner join emprestimos d  

on a.codigoCli = d.codigoCli inner join agencias ag on d.codigoAg = ag.codigoAg  

inner join endereco ed on ag.codigoEnd = ed.codigoEnd inner join bairro ba on ed.codigoBairro = ba.codigoBairro  

inner join cidade ci on ba.codigoCid = ci.codigoCid group by d.codigoCli, ci.codigoCid having ci.nomeCid = "Presidente Prudente"; 

 

    --
    Apresente os dep�sitos realizados por ag�ncia. Selecione o nome da ag�ncia e o total de dep�sitos realizados naquela ag�ncia. Obs: utilize aliases e ordene pelo nome da ag�ncia. 

 

select  ag.nomeAg, sum(e.saldo) as "Total depositos" from agencias ag inner join depositos e  

on ag.codigoAg = e.codigoAg group by ag.nomeAg order by ag.nomeAg desc; 

    Apresente o total de empr�stimos realizados em cada ag�ncia. Obs: utilize aliases e ordene pelo nome da ag�ncia. 

 

select  ag.nomeAg, sum(e.quantia) as "Total emprestimos" from agencias ag inner join emprestimos e  

on e.codigoAg = ag.codigoAg group by ag.nomeAg order by ag.nomeAg desc;    

 

   -- Apresente o c�digo das ag�ncias em que foram realizados dep�sitos e empr�stimos. 

 

select codigoAg from depositos 

union 

select codigoAg from emprestimos order by codigoAg; 

 

  --  Apresente o nome das ag�ncias em que foram realizados dep�sitos e os nomes dos respectivos clientes. 

 

select ag.nomeAg , c.nome from clientes c  

inner join depositos d on c.codigoCli = d.codigoCli  

inner join  agencias ag on d.codigoAg = ag.codigoAg  

group by c.codigoCli ; # agupei por cliente para nao aparece duas vezes o mesmo nome 

 

    --Selecione o nome dos clientes que possuem empr�stimos. (Utilize subconsulta). 

 

select nome from clientes where codigoCli in(select codigoCli from emprestimos); 

 

   -- Qual o cliente que possui o maior empr�stimo? (Utilize subconsulta). 

 

select nome from clientes where codigoCli = 

 

(select codigoCli from emprestimos where quantia =  

 

(select max(quantia) from emprestimos)); 

 

  --  Apresente o total de dep�sitos realizados por cliente, independente do banco. (Utilize subconsulta). 

 

select clientes.nome as "Clientes", 

 

(select sum(saldo) from depositos 

 

  where (clientes.codigoCli = depositos.codigoCli)) 

 

  as "Depositos" from  clientes; 

 

 

 

 --   Apresente o total de empr�stimos realizados nas ag�ncias da cidade de Adamantina. (Utilize subconsulta). 

 

SELECT COUNT(*) AS Total_de_Emprestimos 

FROM emprestimos 

WHERE codigoAg IN ( 

    SELECT codigoAg 

    FROM agencias 

    JOIN endereco ON agencias.codigoEnd = endereco.codigoEnd 

    JOIN bairro ON endereco.codigoBairro = bairro.codigoBairro 

    JOIN cidade ON bairro.codigoCid = cidade.codigoCid 

    WHERE cidade.nomeCid = 'Adamantina' 

); 

 

  --  Elabore um ranking de cidades que possuem os maiores empr�stimos. (Utilize subconsulta). 

 

SELECT cidade.nomeCid AS Cidade,  

       COUNT(emprestimos.numeroEmp) AS Total_de_Emprestimos 

FROM cidade 

JOIN bairro ON cidade.codigoCid = bairro.codigoCid 

JOIN endereco ON bairro.codigoBairro = endereco.codigoBairro 

JOIN agencias ON endereco.codigoEnd = agencias.codigoEnd 

JOIN emprestimos ON agencias.codigoAg = emprestimos.codigoAg 

GROUP BY cidade.nomeCid 

ORDER BY Total_de_Emprestimos DESC; 

 

 

 