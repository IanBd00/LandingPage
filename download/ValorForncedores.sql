create table produtos (
	id_produto serial primary key,
	ean13_produto int not null,
	dun14_produto int not null,
	qntd_dun14 int not null,
	referencia_produto int not null,
	nome_produto varchar(100) not null,
	categoria varchar(100) not null,
	descricao text
);

create table fornecedores (
	id_fornecedor serial primary key,
	nome_fornecedor varchar(100) not null,
	contato_fornecedor varchar(150) not null
);

create table precos (
	id_precos serial primary key,
	id_produto serial not null references produtos(id_produto),
	id_fornecedor serial not null references fornecedores(id_fornecedor),
	preco numeric(7,2) not null,
	data_atualizacao timestamp default current_timestamp
);

-------------------------------------------------------------------------

INSERT INTO produtos 
(ean13_produto, dun14_produto, qntd_dun14, referencia_produto, nome_produto, categoria, descricao) 
VALUES
(7891000055123, 17891000055120, 12, 001, 'Sabonete Neutro 90g', 'Higiene Pessoal', 'Sabonete neutro para todos os tipos de pele'),
(7891910002345, 17891910002342, 24, 002, 'Arroz Tipo 1 5kg', 'Alimentos', 'Arroz branco tipo 1, ideal para o dia a dia'),
(7896004009876, 17896004009873, 6, 003, 'Detergente Líquido 500ml', 'Limpeza Doméstica', 'Detergente para louças com alto poder de ação'),
(7891910054321, 17891910054328, 20, 004, 'Biscoito Recheado 140g', 'Alimentos', 'Biscoito sabor chocolate com recheio cremoso'),
(7894900012346, 17894900012343, 8, 005, 'Shampoo Anticaspa 350ml', 'Higiene Pessoal', 'Shampoo com ação anticaspa para uso diário'),
(7898304011222, 17898304011229, 10, 006, 'Café Torrado e Moído 500g', 'Alimentos', 'Café tradicional, sabor encorpado e aroma rico');


INSERT INTO fornecedores (nome_fornecedor, contato_fornecedor) 
VALUES
('Distribuidora São Jorge', 'contato@saojorge.com.br'),
('Alimentos Bom Sabor LTDA', 'vendas@bomsabor.com.br'),
('Limpa Tudo Distribuições', 'atendimento@limpatudo.com'),
('Higiene Brasil Fornecimentos', 'contato@higienebrasil.com.br'),
('Café Premium Representações', 'comercial@cafepremium.com.br'),
('Recheio & Cia Comércio', 'suporte@recheioecia.com');

INSERT INTO precos (id_produto, id_fornecedor, preco, data_atualizacao)
VALUES
-- Produto 1: Sabonete Neutro 90g
(1, 1, 2.99, CURRENT_TIMESTAMP),
(1, 4, 3.10, CURRENT_TIMESTAMP),
(1, 2, 3.05, CURRENT_TIMESTAMP),
(1, 3, 2.95, CURRENT_TIMESTAMP),

-- Produto 2: Arroz Tipo 1 5kg
(2, 2, 18.50, CURRENT_TIMESTAMP),
(2, 6, 19.00, CURRENT_TIMESTAMP),
(2, 1, 18.30, CURRENT_TIMESTAMP),
(2, 5, 19.20, CURRENT_TIMESTAMP),

-- Produto 3: Detergente Líquido 500ml
(3, 3, 3.25, CURRENT_TIMESTAMP),
(3, 1, 3.40, CURRENT_TIMESTAMP),
(3, 4, 3.15, CURRENT_TIMESTAMP),
(3, 6, 3.35, CURRENT_TIMESTAMP),

-- Produto 4: Biscoito Recheado 140g
(4, 6, 4.70, CURRENT_TIMESTAMP),
(4, 2, 4.55, CURRENT_TIMESTAMP),
(4, 5, 4.65, CURRENT_TIMESTAMP),
(4, 1, 4.80, CURRENT_TIMESTAMP),

-- Produto 5: Shampoo Anticaspa 350ml
(5, 4, 12.90, CURRENT_TIMESTAMP),
(5, 5, 13.10, CURRENT_TIMESTAMP),
(5, 2, 13.20, CURRENT_TIMESTAMP),
(5, 3, 12.75, CURRENT_TIMESTAMP),

-- Produto 6: Café Torrado e Moído 500g
(6, 5, 15.60, CURRENT_TIMESTAMP),
(6, 3, 15.80, CURRENT_TIMESTAMP),
(6, 6, 15.55, CURRENT_TIMESTAMP),
(6, 4, 15.90, CURRENT_TIMESTAMP);

-------------------------------------------------------------------------

select * from produtos
select * from fornecedores
select * from precos
select * from precos_detalhado
select * from tabela_final

-------------------------------------------------------------------------

TRUNCATE TABLE fornecedores RESTART IDENTITY;
delete from fornecedores
where id_fornecedor=3;

-------------------------------------------------------------------------
Alterar a Tabela 

drop table produtos cascade
drop table fornecedores
drop table precos cascade

ALTER TABLE produtos
ALTER COLUMN ean13_produto TYPE bigint;

ALTER TABLE produtos
ALTER COLUMN dun14_produto TYPE bigint;

ALTER TABLE produtos
ALTER COLUMN referencia_produto TYPE varchar(50);

-------------------------------------------------------------------------
Automação

drop view tabela_final;

CREATE VIEW precos_detalhado AS
SELECT 
    p.nome_produto,
    f.nome_fornecedor,
    pr.preco,
    pr.data_atualizacao
FROM precos pr
JOIN produtos p ON pr.id_produto = p.id_produto
JOIN fornecedores f ON pr.id_fornecedor = f.id_fornecedor;

create view tabela_final as
select
	p.ean13_produto,
	p.nome_produto,
	f.nome_fornecedor,
    pr.preco,
	pr.preco*p.qntd_dun14 as total,
    pr.data_atualizacao
from precos pr
join produtos p on pr.id_produto = p.id_produto
JOIN fornecedores f ON pr.id_fornecedor = f.id_fornecedor;

-------------------------------------------------------------------------

