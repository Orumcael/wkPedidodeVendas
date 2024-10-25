-- wkpdv = WK Pedido de Venda
CREATE DATABASE IF NOT EXISTS wkpdv;
USE wkpdv;

CREATE TABLE IF NOT EXISTS cliente (
	codigo INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(80),
	cidade VARCHAR(50),
	uf VARCHAR(2)
);

CREATE TABLE IF NOT EXISTS produto (
	codigo INT PRIMARY KEY AUTO_INCREMENT,
	descricao VARCHAR(50),
	precoVenda DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS pedido_dados_gerais (
	numeroPedido INT PRIMARY KEY AUTO_INCREMENT,
	dataEmissao DATETIME,
	codigoCliente INT,
	valorTotal DECIMAL(10, 2),
	FOREIGN KEY (codigoCliente) REFERENCES cliente(codigo)
);

CREATE TABLE pedido_produto (
	codigo INT PRIMARY KEY AUTO_INCREMENT,
	numeroPedido INT,
	codigoProduto INT,
	quantidade INT,
	valorUnitario DECIMAL(10, 2),
	valorTotal DECIMAL(10, 2),
	FOREIGN KEY (numeroPedido) REFERENCES pedido_dados_gerais(numeroPedido),
	FOREIGN KEY (codigoProduto) REFERENCES produto(codigo)
);

-- Create Indices
CREATE INDEX idx_codigoCliente ON pedido_dados_gerais(codigoCliente);

CREATE INDEX idx_numeroPedido ON pedido_produto(numeroPedido);
CREATE INDEX idx_codigoProduto ON pedido_produto(codigoProduto);

-- Insert Clientes
START TRANSACTION;
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Ana Silva', 'São Paulo', 'SP');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Bruno Costa', 'Rio de Janeiro', 'RJ');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Carla Santos', 'Belo Horizonte', 'MG');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Daniel Oliveira', 'Curitiba', 'PR');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Eduarda Lima', 'Fortaleza', 'CE');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Felipe Almeida', 'Recife', 'PE');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Gabriela Martins', 'Salvador', 'BA');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Henrique Ferreira', 'Porto Alegre', 'RS');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Isabela Rocha', 'Manaus', 'AM');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('João Pedro', 'Belém', 'PA');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Karen Dias', 'Niterói', 'RJ');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Leonardo Sousa', 'São Luís', 'MA');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Mariana Alves', 'João Pessoa', 'PB');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Natália Pires', 'Campo Grande', 'MS');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Otávio Nascimento', 'Goiânia', 'GO');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Paula Ribeiro', 'Teresina', 'PI');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Rafael Martins', 'Maceió', 'AL');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Sofia Mendes', 'Vitória', 'ES');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Thiago Carvalho', 'Aracaju', 'SE');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Ursula Torres', 'Natal', 'RN');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Vinícius Barbosa', 'Florianópolis', 'SC');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Wesley Teixeira', 'Cuiabá', 'MT');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Yasmin Lima', 'Rio Branco', 'AC');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Zé Carlos', 'Porto Velho', 'RO');
	INSERT INTO cliente (nome, cidade, uf) VALUES ('Cecília Vieira', 'Boa Vista', 'RR');
COMMIT;


-- Insert Produtos
START TRANSACTION;
	INSERT INTO produto (descricao, precoVenda) VALUES ('Camiseta', 29.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Calça Jeans', 89.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Tênis Esportivo', 199.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Jaqueta de Couro', 349.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Relógio de Pulso', 159.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Óculos de Sol', 79.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Bolsa Feminina', 129.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Perfume', 89.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Cinto de Couro', 49.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Boné', 39.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Camisa Social', 69.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Saia', 79.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Bermuda', 59.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Cachecol', 29.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Tênis Casual', 159.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Sapatilha', 89.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Blusa de Frio', 99.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Chinelo', 29.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Camisa de Time', 89.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Camiseta Estampada', 49.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Meia', 9.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Bolsa de Viagem', 199.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Mochila', 139.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Relógio Inteligente', 399.90);
	INSERT INTO produto (descricao, precoVenda) VALUES ('Sunga', 39.90);
COMMIT;