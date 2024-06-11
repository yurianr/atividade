-- Cliente que mais fez pedidos por ano?
select * 
from (
(select year(tb_mesa.data_hora_entrada) as ano, c.id_cliente , c.nome_cliente , sum(tb_pedido.quantidade_pedido) as qtd_pedidos 
from tb_cliente c
join tb_mesa on c.id_cliente = tb_mesa.id_cliente
join tb_pedido on tb_mesa.codigo_mesa  = tb_pedido.codigo_mesa
where year(tb_mesa.data_hora_entrada) = 2022
group by c.id_cliente,ano,c.nome_cliente
order by qtd_pedidos desc
limit 1)
union
(select year(tb_mesa.data_hora_entrada) as ano, c.id_cliente , c.nome_cliente , sum(tb_pedido.quantidade_pedido) as qtd_pedidos 
from tb_cliente c
join tb_mesa on c.id_cliente = tb_mesa.id_cliente
join tb_pedido on tb_mesa.codigo_mesa  = tb_pedido.codigo_mesa
where year(tb_mesa.data_hora_entrada) = 2023
group by c.id_cliente,ano,c.nome_cliente
order by qtd_pedidos desc
limit 1)
union(
select year(tb_mesa.data_hora_entrada) as ano, c.id_cliente , c.nome_cliente , sum(tb_pedido.quantidade_pedido) as qtd_pedidos 
from tb_cliente c
join tb_mesa on c.id_cliente = tb_mesa.id_cliente
join tb_pedido on tb_mesa.codigo_mesa  = tb_pedido.codigo_mesa
where year(tb_mesa.data_hora_entrada) = 2024
group by c.id_cliente,ano,c.nome_cliente
order by qtd_pedidos desc
limit 1
)) as
tb_top_clients_consumer_per_year;


-- Qual o cliente que mais gastou em todos os anos?
SELECT
	cliente.nome_cliente AS cliente,
	SUM(prato.preco_unitario_prato * CAST(pedido.quantidade_pedido AS DECIMAL)) AS total_gasto
FROM tb_pedido pedido
JOIN tb_mesa mesa ON pedido.codigo_mesa = mesa.codigo_mesa
JOIN tb_cliente cliente ON mesa.id_cliente = cliente.id_cliente
JOIN tb_prato prato ON pedido.codigo_prato = prato.codigo_prato
GROUP BY cliente.nome_cliente
ORDER BY total_gasto DESC
LIMIT 1;


-- Qual o período do ano em que o restaurante tem maior movimento?
SELECT
    year(data_hora_entrada) as ano, month(data_hora_entrada) as mês, count(num_pessoa_mesa) as pessoas
FROM
    tb_mesa
GROUP BY
    ano,mês
ORDER BY
    pessoas DESC
limit 1;


-- Qual a empresa que tem mais funcionarios como clientes do restaurante?
SELECT empresa.nome_empresa AS empresa, COUNT(funcionario.codigo_funcionario) AS numero_de_funcionarios
FROM tb_beneficio funcionario
JOIN tb_cliente cliente ON cliente.id_cliente = funcionario.codigo_funcionario
JOIN tb_empresa empresa ON empresa.codigo_empresa = funcionario.codigo_empresa
GROUP BY empresa.nome_empresa
ORDER BY numero_de_funcionarios DESC
LIMIT 1;

-- Qual empresa que tem mais funcionarios que consomem sobremesas no restaurante por ano?
WITH gastos_por_ano AS (
	SELECT YEAR(mesa.data_hora_entrada) AS ano, cliente.id_cliente AS id_cliente, 
	SUM(prato.preco_unitario_prato * CAST(pedido.quantidade_pedido AS DECIMAL)) 
	AS total_gasto, ROW_NUMBER() OVER (PARTITION BY YEAR(mesa.data_hora_entrada) ORDER BY SUM(prato.preco_unitario_prato * CAST(pedido.quantidade_pedido AS DECIMAL)) DESC) AS order FROM tb_pedido pedido JOIN tb_mesa mesa ON pedido.codigo_mesa = mesa.codigo_mesa
	JOIN tb_cliente cliente ON mesa.id_cliente = cliente.id_cliente
	JOIN tb_prato prato ON pedido.codigo_prato = prato.codigo_prato
	JOIN tb_tipo_prato tipo_prato ON prato.codigo_tipo_prato = tipo_prato.codigo_tipo_prato
	WHERE tipo_prato.nome_tipo_prato = 'Sobremesa'
	GROUP BY YEAR(mesa.data_hora_entrada), cliente.id_cliente
) 
SELECT ano, empresa.nome_empresa AS empresa FROM gastos_por_ano cliente JOIN tb_beneficio funcionario ON funcionario.codigo_funcionario = cliente.id_cliente JOIN tb_empresa empresa ON empresa.codigo_empresa = funcionario.codigo_empresa WHERE order = 1 ORDER BY ano;