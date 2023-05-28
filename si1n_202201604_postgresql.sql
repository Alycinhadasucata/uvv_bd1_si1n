/* Criação do usuário do PostgreSQL e fornecendo permissões */
CREATE ROLE alyce WITH
    LOGIN
    SUPERUSER
    CREATEDB
    CREATEROLE
    INHERIT
    REPLICATION
    CONNECTION LIMIT -1;

/* Criação do Banco de Dados */
CREATE DATABASE uvv
    WITH 
    OWNER = alyce
    TEMPLATE = template0
    ENCODING = 'UTF8'
    lc_collate: pt_BR.UTF-8
    lc_ctype: pt_BR.UTF-8
    allow_connections: true


COMMENT ON DATABASE uvv
    IS 'Tabela que armazena as tabelas criadas no pset.';

/* Criando o esquema do Banco de Dados e selecionando-o para o uso */ 
CREATE SCHEMA lojas
    AUTHORIZATION alyce;

ALTER USER alyce
SET SEARCH_PATH TO lojas, public;

/* Criação da tabela "produtos" */
CREATE TABLE lojas.produtos (
produto_id NUMERIC(38) NOT NULL,
nome VARCHAR(255),
preco_unitario NUMERIC(10,2),
detalhes BYTEA,
imagem BYTEA,
imagem_mime_type VARCHAR(512),
imagem_arquivo VARCHAR(512),
imagem_charset VARCHAR(512),
imagem_ultima_atualizacao DATE,
CONSTRAINT pk_pprodutos PRIMARY KEY (produto_id)
);

COMMENT ON TABLE lojas.produtos IS 'Tabela que contém informações referentes aos produtos';
COMMENT ON COLUMN lojas.produtos.produto_id IS 'pk da tabela produtos';
COMMENT ON COLUMN lojas.produtos.nome IS 'nome da tabela produtos';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'preço unitário da tabela produtos';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'detalhes da tabela produtos';
COMMENT ON COLUMN lojas.produtos.imagem IS 'imagem da tabela produtos';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'imagem mime type da tabela produtos';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'imagem arquivo da tabela produtos';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'imagem charset da tabela produtos';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'imagem última atualização';

/* Criação da tabela "lojas" */
CREATE TABLE lojas.lojas (
loja_id NUMERIC(38) NOT NULL,
nome VARCHAR(255),
endereco_web VARCHAR(100),
endereco_fisico VARCHAR(512),
latitude NUMERIC,
longitude NUMERIC,
logo BYTEA,
logo_mime_type VARCHAR(512),
logo_arquivo VARCHAR(512),
logo_charset VARCHAR(512),
logo_ultima_atualizacao DATE,
CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);

COMMENT ON TABLE lojas.lojas IS 'Tabela que contém informações referentes às lojas';
COMMENT ON COLUMN lojas.lojas.loja_id IS 'id da loja da tabela lojas';
COMMENT ON COLUMN lojas.lojas.nome IS 'nome da tabela lojas';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'endereco web da tabela lojas';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'endereco físico da tabela lojas';
COMMENT ON COLUMN lojas.lojas.latitude IS 'latitude da tabela lojas';
COMMENT ON COLUMN lojas.lojas.longitude IS 'longitude da tabela lojas';
COMMENT ON COLUMN lojas.lojas.logo IS 'logo da tabela lojas';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'logo mime type da tabela lojas';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'logo arquivo da tabela lojas';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'logo charset da tabela lojas';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'logo última atualização da tabela lojas';

/* Criação da tabela "estoques" */
CREATE TABLE lojas.estoques (
estoque_id NUMERIC(38) NOT NULL,
loja_id NUMERIC(38),
produto_id NUMERIC(38),
quantidade NUMERIC(38),
CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);

COMMENT ON TABLE lojas.estoques IS 'Tabela que contém informações referentes aos estoques';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'estoque id da tabela estoques';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'loja id da tabela estoques';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'produto id da tabela estoques';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'quantidade da tabela estoques';

/* Criação da tabela "clientes" */
CREATE TABLE lojas.clientes (
cliente_id NUMERIC(38) NOT NULL,
email VARCHAR(255),
nome VARCHAR(255),
telefone1 VARCHAR(20),
telefone2 VARCHAR(20),
telefone3 VARCHAR(20),
CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);

COMMENT ON TABLE lojas.clientes IS 'Tabela que contém dados básicos dos clientes';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'id do cliente da tabela clientes';
COMMENT ON COLUMN lojas.clientes.email IS 'email da tabela clientes';
COMMENT ON COLUMN lojas.clientes.nome IS 'nome da tabela clientes';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'telefone1 da tabela clientes';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'telefone2 da tabela clientes';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'telefone3 da tabela clientes';

/* Criação da tabela "envios" */
CREATE TABLE lojas.envios (
envio_id NUMERIC(38) NOT NULL,
loja_id NUMERIC(38),
cliente_id NUMERIC(38),
endereco_entrega VARCHAR(512),
status VARCHAR(15),
CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);

COMMENT ON TABLE lojas.envios IS 'Tabela que contém informações referentes aos envios';
COMMENT ON COLUMN lojas.envios.envio_id IS 'id do envio da tabela envios';
COMMENT ON COLUMN lojas.envios.loja_id IS 'id da loja da tabela envios';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'id do cliente da tabela envios';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'endereco entrega da tabela envios';
COMMENT ON COLUMN lojas.envios.status IS 'status da tabela envios';

/* Criação da tabela "pedidos" */
CREATE TABLE lojas.pedidos (
pedido_id NUMERIC(38) NOT NULL,
data_hora TIMESTAMP,
cliente_id NUMERIC(38),
status VARCHAR(15),
loja_id NUMERIC(38),
CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);

COMMENT ON TABLE lojas.pedidos IS 'Tabela que contém informações dos pedidos';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'id do pedido da tabela pedidos';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'data e hora do pedido da tabela pedidos';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'id do cliente da tabela pedidos';
COMMENT ON COLUMN lojas.pedidos.status IS 'status da tabela pedidos';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'id da loja da tabela pedidos';


/*Criando a FK na tabela estoques com a tabela produtos */
ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/* Criando a FK na tabela pedidos_itens com a tabela produtos */
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/*Criando a FK na tabela pedidos com a tabela lojas */
ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/*Criando a FK na tabela estoques com a tabela lojas */
ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/*Criando a FK na tabela envios com a tabela lojas */
ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/*Criando a FK na tabela pedidos com a tabela clientes */
ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/*Criando a FK na tabela envios com a tabela clientes */
ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/*Criando a FK na tabela pedidos_itens com a tabela pedidos */
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
