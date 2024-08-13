--1.Retornar o número de clientes cadastrados no banco de dados. 

select count(*) from clientes; 

-- Count(*) função que conta a quantidade 

 

--2. Qual o total de clientes que possuem empréstimos, sem repetição. 

select count(distinct codigoCli) as total from emprestimos; 

--count (distinct codigoCli) a funcao distinct está contando sem repetir 

 

--3. Qual o maior valor deposito no banco de código 5. 

select max(saldo) from depositos where codigoAg = 5; 

--max  função para achar o maior valor 

 

--4. Qual a média dos valores depositados na agencia 2. 

select avg(saldo) from depositos where codigoAg = 2; 

--avg função para fazer a media com os valores  

 

--5. Liste o total do empréstimo de cada cliente. Liste o nome do cliente e o total de empréstimo. 

select a.nome, sum(d.quantia) as Total_Emprestimos 

from clientes a inner join emprestimos d  

on a.codigoCli = d.codigoCli group by d.codigoCli; 

---as serve para dar um novo nome  

 

--6. Liste o nome dos clientes com depósitos saldo superior a R$ 5000. 

select a.nome, sum(d.saldo) as Total_Depositos 

from clientes a inner join depositos d  

on a.codigoCli = d.codigoCli group by d.codigoCli having sum(d.saldo)> 5000; 

 

 

 

--7. Liste o nome do cliente, sua cidade e o seu total de empréstimo. 

select a.nome as Nome, ci.nomeCid, sum(d.quantia) as Total_Emprestimos 

from clientes a inner join emprestimos d  

on a.codigoCli = d.codigoCli inner join agencias ag on d.codigoAg = ag.codigoAg  

inner join endereco ed on ag.codigoEnd = ed.codigoEnd inner join bairro ba on ed.codigoBairro = ba.codigoBairro  

inner join cidade ci on ba.codigoCid = ci.codigoCid group by d.codigoCli, ci.codigoCid; 

 

--8. Liste o endereço dos clientes que possuem empréstimos maiores que R$ 15000. 

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

 

--10. Qual o total de empréstimos nas agências de Presidente Prudente? 

select  ci.nomeCid, sum(d.quantia) as Total_Emprestimos 

from clientes a inner join emprestimos d  

on a.codigoCli = d.codigoCli inner join agencias ag on d.codigoAg = ag.codigoAg  

inner join endereco ed on ag.codigoEnd = ed.codigoEnd inner join bairro ba on ed.codigoBairro = ba.codigoBairro  

inner join cidade ci on ba.codigoCid = ci.codigoCid group by d.codigoCli, ci.codigoCid having ci.nomeCid = "Presidente Prudente"; 

 

    --
    Apresente os depósitos realizados por agência. Selecione o nome da agência e o total de depósitos realizados naquela agência. Obs: utilize aliases e ordene pelo nome da agência. 

 

select  ag.nomeAg, sum(e.saldo) as "Total depositos" from agencias ag inner join depositos e  

on ag.codigoAg = e.codigoAg group by ag.nomeAg order by ag.nomeAg desc; 

    Apresente o total de empréstimos realizados em cada agência. Obs: utilize aliases e ordene pelo nome da agência. 

 

select  ag.nomeAg, sum(e.quantia) as "Total emprestimos" from agencias ag inner join emprestimos e  

on e.codigoAg = ag.codigoAg group by ag.nomeAg order by ag.nomeAg desc;    

 

   -- Apresente o código das agências em que foram realizados depósitos e empréstimos. 

 

select codigoAg from depositos 

union 

select codigoAg from emprestimos order by codigoAg; 

 

  --  Apresente o nome das agências em que foram realizados depósitos e os nomes dos respectivos clientes. 

 

select ag.nomeAg , c.nome from clientes c  

inner join depositos d on c.codigoCli = d.codigoCli  

inner join  agencias ag on d.codigoAg = ag.codigoAg  

group by c.codigoCli ; # agupei por cliente para nao aparece duas vezes o mesmo nome 

 

    --Selecione o nome dos clientes que possuem empréstimos. (Utilize subconsulta). 

 

select nome from clientes where codigoCli in(select codigoCli from emprestimos); 

 

   -- Qual o cliente que possui o maior empréstimo? (Utilize subconsulta). 

 

select nome from clientes where codigoCli = 

 

(select codigoCli from emprestimos where quantia =  

 

(select max(quantia) from emprestimos)); 

 

  --  Apresente o total de depósitos realizados por cliente, independente do banco. (Utilize subconsulta). 

 

select clientes.nome as "Clientes", 

 

(select sum(saldo) from depositos 

 

  where (clientes.codigoCli = depositos.codigoCli)) 

 

  as "Depositos" from  clientes; 

 

 

 

 --   Apresente o total de empréstimos realizados nas agências da cidade de Adamantina. (Utilize subconsulta). 

 

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

 

  --  Elabore um ranking de cidades que possuem os maiores empréstimos. (Utilize subconsulta). 

 

SELECT cidade.nomeCid AS Cidade,  

       COUNT(emprestimos.numeroEmp) AS Total_de_Emprestimos 

FROM cidade 

JOIN bairro ON cidade.codigoCid = bairro.codigoCid 

JOIN endereco ON bairro.codigoBairro = endereco.codigoBairro 

JOIN agencias ON endereco.codigoEnd = agencias.codigoEnd 

JOIN emprestimos ON agencias.codigoAg = emprestimos.codigoAg 

GROUP BY cidade.nomeCid 

ORDER BY Total_de_Emprestimos DESC; 

 

 

 