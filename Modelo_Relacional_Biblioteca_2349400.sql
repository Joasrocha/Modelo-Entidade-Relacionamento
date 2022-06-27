
-- Link do repositório no Github: https://github.com/Joasrocha/Modelo-Entidade-Relacionamento/blob/16021d51fe5c9fef8df0462559f42371b855d35c/Modelo_Relacional_Biblioteca_2349400.sql

CREATE TABLE LIVRO(
Id INTEGER,
Titulo CHAR (50),
Autor CHAR (50),
Genero CHAR (50),
PRIMARY KEY (Id),
FOREIGN KEY (Genero) REFERENCES GENERO (Nome)
);

CREATE TABLE GENERO (
Nome CHAR (50),
Descricao CHAR (500),
Area CHAR (50),
PRIMARY KEY (Nome)
);

CREATE TABLE AUTOR(
Id INTEGER,
Nome CHAR (50),
Genero CHAR (50),
PRIMARY KEY (Id),
FOREIGN KEY (Genero) REFERENCES GENERO (Nome)
);

CREATE TABLE EMPRÉSTIMO(
Codigo INTEGER,
Id_cliente INTEGER,
Id_livro INTEGER,
Data_emprestimo DATE,
Data_devolucao DATE,
PRIMARY KEY (Codigo),
FOREIGN KEY (Id_cliente) REFERENCES Cliente (Registro),
FOREIGN KEY (Id_livro) REFERENCES Livro (Id)
);

CREATE TABLE CLIENTE(
Registro INTEGER,
Nome CHAR (50),
Telefone INTEGER,
PRIMARY KEY (Registro)
);

CREATE TABLE FUNCIONARIO(
Id INTEGER,
Nome CHAR (50),
Endereco INTEGER,
PRIMARY KEY (Id)
);

CREATE TABLE FUNC_ATENDENTE(
Id INTEGER,
Nome CHAR (50),
Endereco INTEGER,
PRIMARY KEY (Id),
FOREIGN KEY (Id) REFERENCES FUNCIONARIO (Id) ON DELETE CASCADE
);

CREATE TABLE FUNC_AJUDANTE(
Id INTEGER,
Nome CHAR (50),
Endereco INTEGER,
Id_setor INTEGER,
Id_prateleira INTEGER,
PRIMARY KEY (Id),
FOREIGN KEY (Id) REFERENCES FUNCIONARIO (Id) ON DELETE CASCADE,
FOREIGN KEY (Setor) REFERENCES COMPOE (Id_setor),
FOREIGN KEY (Prateleira) REFERENCES PRATELEIRA (Id_prateleira)
);

CREATE TABLE FUNC_ADMINISTRADOR(
Id INTEGER,
Nome CHAR (50),
Endereco INTEGER,
PRIMARY KEY (Id),
FOREIGN KEY (Id) REFERENCES FUNCIONARIO (Id) ON DELETE CASCADE
);

CREATE TABLE FORNECEDOR(
Id INTEGER,
Nome CHAR (50),
CEP INTEGER,
PRIMARY KEY (Id)
);

CREATE TABLE FORNECEDOR_ENDERECO(
CEP INTEGER,
Id INTEGER,
UF CHAR (2),
Cidade CHAR (20),
Rua CHAR (50),
Numero INTEGER,
PRIMARY KEY (CEP, Id),
FOREIGN KEY (Id) REFERENCES FORNECEDOR (Id) ON DELETE CASCADE
);

CREATE TABLE PRATELEIRA(
Id INTEGER,
Genero CHAR (50),
Qtd_livros INTEGER,
PRIMARY KEY (Id),
FOREIGN KEY (Genero) REFERENCES GENERO (Nome)
);

CREATE TABLE SETORES(
Id INTEGER,
Prateleira INTEGER,
Func_responsavel INTEGER,
PRIMARY KEY (Id),
FOREIGN KEY (Prateleira) REFERENCES PRATELEIRA (Id),
FOREIGN KEY (Func_responsavel) REFERENCES FUNCIONARIO (Id)
);


CREATE TABLE COMPOE(
Id_prateleira INTEGER,
Id_setor INTEGER,
PRIMARY KEY (Id_prateleira),
FOREIGN KEY (Id_prateleira) REFERENCES PRATELEIRA (Id),
FOREIGN KEY (Id_setor) REFERENCES SETOR (Id)
);


CREATE TABLE SETOR_DE(
Nome_genero CHAR (50),
Id_setor INTEGER,
PRIMARY KEY (Id_setor),
FOREIGN KEY (Nome_genero) REFERENCES GENERO (Nome),
FOREIGN KEY (Id_setor) REFERENCES SETOR (Id)
);

CREATE TABLE ESCREVE_LIVROS_DE(
Nome_genero CHAR (50),
Id_autor INTEGER,
PRIMARY KEY (Nome_genero, Id_autor),
FOREIGN KEY (Nome_genero) REFERENCES GENERO (Nome),
FOREIGN KEY (Id_autor) REFERENCES AUTOR (Id)
);

CREATE TABLE ESCRITO_POR(
Id_livro INTEGER,
Id_autor INTEGER,
PRIMARY KEY (Id_livro, Id_autor),
FOREIGN KEY (Id_livro) REFERENCES LIVRO (Id),
FOREIGN KEY (Id_autor) REFERENCES AUTOR (Id)
);

CREATE TABLE LIVRO_DE(
Id_livro INTEGER,
Nome_genero INTEGER,
PRIMARY KEY (Id_livro, Id_genero),
FOREIGN KEY (Id_livro) REFERENCES LIVRO (Id),
FOREIGN KEY (Nome_genero) REFERENCES GENERO (Nome)
);

INSERT INTO LIVRO_DE (Id_livro, Nome_genero) VALUES 
(1001, 'Romance'),
(1002, 'Romance'),
(1003, 'Fantasia'),
(1004, 'Fábula'),
(1005, 'Fantasia'),
(1006, 'Suspense'),
(1007, 'Romance'),
(1008, 'Aventura'),
(1009, 'Fantasia'),
(1010, 'Romance');

CREATE TABLE ENCOMENDA_DE(
Id_livro INTEGER,
Id_fornecedor INTEGER,
Id_func_adm INTEGER,
PRIMARY KEY (Id_livro, Id_fornecedor),
FOREIGN KEY (Id_livro) REFERENCES LIVRO (Id),
FOREIGN KEY (Id_fornecedor) REFERENCES FORNECEDOR (Id),
FOREIGN KEY (Id_func_adm) REFERENCES FUNC_ADMINISTRADOR (Id)
);

INSERT INTO ENCOMENDA_DE (Id_livro, Id_fornecedor, Id_func_adm) VALUES 
(1001, 00101, 202221),
(1002, 00101, 202221),
(1003, 00101, 202221),
(1004, 00105, 202222),
(1005, 00105, 202222),
(1006, 00106, 202223),
(1007, 00107, 202224),
(1008, 00108, 202225),
(1009, 00109, 202226),
(1010, 00110, 202228);

CREATE TABLE REGISTRA(
Reg_cliente INTEGER,
Id_func_atd INTEGER,
PRIMARY KEY (Id_func_atd),
FOREIGN KEY (Reg_cliente) REFERENCES CLIENTE (Registro),
FOREIGN KEY (Id_func_atd) REFERENCES FUNC_ATENDENTE (Id)
);

INSERT INTO REGISTRA (Reg_cliente, Id_func_ajd) VALUES
(0001, 202201),
(0002, 202202),
(0003, 202203),
(0004, 202204),
(0005, 202205),
(0006, 202206),
(0007, 202207),
(0008, 202208),
(0009, 202209),
(0010, 202210);

CREATE TABLE REQUER_AJUDA(
Reg_cliente INTEGER,
Id_func_ajd INTEGER,
PRIMARY KEY (Reg_cliente),
FOREIGN KEY (Reg_cliente) REFERENCES CLIENTE (Registro),
FOREIGN KEY (Id_func_ajd) REFERENCES FUNC_AJUDANTE (Id)
);

INSERT INTO REQUER_AJUDA(Reg_cliente, Id_func_ajd) VALUES
(0001, 202211),
(0002, 202212),
(0003, 202213),
(0004, 202214),
(0005, 202215),
(0006, 202216),
(0007, 202217),
(0008, 202218),
(0009, 202219),
(0010, 202220);

INSERT INTO LIVRO (Id, Titulo, Autor, Genero) VALUES 
(1001, 'Dom Quixote', 'Miguel de Cervantes', 'Romance'),
(1002, 'Um Conto de Duas Cidades', 'Charles Dickens', 'Romance'),
(1003, 'O Senhor dos Anéis', 'J. R. R. Tolkien', 'Fantasia'),
(1004, 'O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 'Fábula'),
(1005, 'Harry Potter e a Pedra Filosofal', 'J. K. Rowling', 'Fantasia'),
(1006, 'E Não Sobrou Nenhum', 'Agatha Christie', 'Suspense'),
(1007, 'O Sonho da Câmara Vermelha', 'Cao Xueqin', 'Romance'),
(1008, 'Ela, a Feiticeira', 'H. Rider Haggard', 'Aventura'),
(1009, 'O Leão, a Feiticeira e o Guarda-Roupa', 'C.S. Lewis', 'Fantasia'),
(1010, 'O Código Da Vinci', 'Dan Brown', 'Romance');

INSERT INTO GENERO (Nome, Descricao, Area) VALUES 
('Romance', 'Romance é a forma literária pertencente ao gênero narrativo e que apresenta uma história completa composta por enredo, temporalidade, ambientação e personagens definidos de maneira clara.', 'Ficção'),
('Fantasia', 'Fantasia é um gênero da ficção em que se usa geralmente fenômenos sobrenaturais, mágicos e outros como um elemento primário do enredo, tema ou configuração.', 'Ficção'),
('Fábula', 'As fábulas são composições literárias curtas, escritas em prosa ou versos em que os personagens são animais que apresentam características humanas, muito presente na literatura infantil.', 'Ficção'),
('Suspense', 'As obras de suspense são aquelas que provocam a hesitação da respiração do leitor/público uma vez que seu enredo é estruturado a partir de cortes repentinos, provocadores do susto.', 'Ficção'),
('Conto', 'Um conto é uma narrativa que cria um universo de seres, de fantasia ou acontecimentos.', 'Ficção'),
('Autobiografia', 'Autobiografia é um gênero literário em que uma pessoa narra a história da sua vida, trata-se de uma biografia escrita ou narrada pela pessoa biografada', 'Não Ficção'),
('Ciências da Terra', 'As Ciências da Terra, também conhecidas como Geociências, são aquelas, cujo foco principal de estudo são os diversos aspectos físicos do nosso planeta.', ' Matemática e Ciências'),
('Ciência Política', 'Ciência política ou Análise política é o estudo da política — dos sistemas políticos, das organizações e dos processos políticos. ', ' Humanidades e Ciências Sociais'),
('Engenharia', 'Engenharia é a aplicação do conhecimento científico, econômico, social e prático, com o intuito de inventar, desenhar, construir, manter e melhorar estruturas, máquinas, aparelhos, sistemas, materiais e processos.', ' Matemática e Ciências'),
('Medicina', 'A medicina é uma das muitas áreas do conhecimento ligada à manutenção e restauração da saúde. Ela trabalha, num sentido amplo, com a prevenção e cura das doenças humanas e animais num contexto médico.', ' Matemática e Ciências');

INSERT INTO AUTOR (Id, Nome, Genero) VALUES 
(1201,'Miguel de Cervantes','Romance'),
(1202,'Charles Dickens','Romance'),
(1203,'J. R. R. Tolkien','Fantasia'),
(1204,'Antoine de Saint-Exupéry','Fábula'),
(1205,'J. K. Rowling','Fantasia'),
(1206,'Agatha Christie','Romance'),
(1207,'Cao Xueqin','Romance'),
(1208,'H. Rider Haggard','Aventura'),
(1209,'C.S. Lewis','Fantasia'),
(1210,'Dan Brown','Romance');

INSERT INTO EMPRESTIMO (Codigo, Id_cliente, Id_livro, Data_emprestimo, Data_devolucao) VALUES 
(1011,0001,1001,2022-05-02,2022-05-09),
(1012,0001,1002,2022-05-03,2022-05-10),
(1013,0001,1005,2022-06-20,2022-06-27),
(1014,0005,1002,2022-06-11,2022-06-18),
(1015,0005,1009,2022-07-20,2022-07-27),
(1016,0007,1003,2022-07-21,2022-07-28),
(1017,0007,1006,2022-08-02,2022-08-09),
(1018,0009,1008,2022-08-12,2022-08-19),
(1019,0009,1002,2022-08-20,2022-08-27),
(1020,0009,1001,2022-08-21,2022-08-28);

INSERT INTO CLIENTE (Registro, Nome, Telefone) VALUES
(0001,'Helton Salvado Paula',990348292),
(0002,'Clarisse Rocha Maia',993488503),
(0003,'Tabita Cerveira Mont Alverne',994039485),
(0004,'Micael Bingre Malafaia',994938409),
(0005,'Ânia Jardim Rodovalho',994394850),
(0006,'Ludmila Paulos Chagas',994930573),
(0007,'Erika Varanda Alencar',992938462),
(0008,'Henzo Belmonte Fogaça',998492038),
(0009,'Patrícia Alcaide Torres',992039472),
(0010,'Alberto Silveira Cabral',992930482);

INSERT INTO FUNCIONARIO (Id, Nome, Endereco) VALUES 
(202201,'Laysla Taveira Freitas',29102855),
(202202, 'Milena Mota Bensaúde',69908694),
(202203, 'Alicia Negrão Matoso',68550295),
(202204, 'Íris Parracho Valido',45027236),
(202205, 'Alexandr Maior Costa',60741490),
(202206, 'Zé Holanda Tedim',76907604),
(202207, 'Rúdi Frazão Bentes',64088680),
(202208, 'Apolo Barreira Quinta',26193280),
(202209, 'Nelsa Dâmaso Baptista',78135593),
(202210, 'Agatha Igrejas Urias',81110140),
(202211, 'Lyah Gouveia Medina',80020903),
(202212, 'Gusttavo Pestana Franca',77001674),
(202213, 'Zaqueu Canadas Carvalhoso',72906115),
(202214, 'Cadija Arouca Carvalhosa',40393870),
(202215, 'Jénifer Lustosa Durão',74573388),
(202216, 'Sebastian Pinheiro Taveiros',58069595),
(202217, 'Nataniel Catela Aguiar',49043502),
(202218, 'Eurico Alcaide Vilhena',24415520),
(202219, 'Alexandr Montenegro Vilhena',77016338),
(202220, 'Emanuel Ávila Olaio',69074643),
(202221, 'Noémi Cedraz Chainho',69086562),
(202222, 'Keyla Júdice Vilhena',79905416),
(202223, 'Brahim Canário Paredes',78057016),
(202224, 'Zélia Garcez Viegas',27971224),
(202225, 'Marwa Gadelha Branco',76901256),
(202226, 'Nídia Cabeça Póvoas',60843260),
(202227, 'Lícia Madeira Mourinho',68909810),
(202228, 'Thiago Hernandes Noronha',69902124),
(202229, 'Lya Banha Lucas',37900064),
(202230, 'Jefferson Abreu Coelho',03801070);

INSERT INTO FUNC_ATENDENTE (Id, Nome, Endereco) VALUES 
(202201,'Laysla Taveira Freitas',29102855),
(202202, 'Milena Mota Bensaúde',69908694),
(202203, 'Alicia Negrão Matoso',68550295),
(202204, 'Íris Parracho Valido',45027236),
(202205, 'Alexandr Maior Costa',60741490),
(202206, 'Zé Holanda Tedim',76907604),
(202207, 'Rúdi Frazão Bentes',64088680),
(202208, 'Apolo Barreira Quinta',26193280),
(202209, 'Nelsa Dâmaso Baptista',78135593),
(202210, 'Agatha Igrejas Urias',81110140);

INSERT INTO FUNC_AJUDANTE (Id, Nome, Endereco, Id_setor, Id_prateleira) VALUES 
(202211, 'Lyah Gouveia Medina',80020903, 00101, 00001),
(202212, 'Gusttavo Pestana Franca',77001674, 00102, 00002),
(202213, 'Zaqueu Canadas Carvalhoso',72906115, 00103, 00003),
(202214, 'Cadija Arouca Carvalhosa',40393870, 00104, 00004),
(202215, 'Jénifer Lustosa Durão',74573388, 00105,00005),
(202216, 'Sebastian Pinheiro Taveiros',58069595, 00106, 00006),
(202217, 'Nataniel Catela Aguiar',49043502, 00107, 00007),
(202218, 'Eurico Alcaide Vilhena',24415520, 00108, 00008),
(202219, 'Alexandr Montenegro Vilhena',77016338, 00109, 00009),
(202220, 'Emanuel Ávila Olaio',69074643, 00110, 00010);

INSERT INTO FUNC_ADMINISTRADOR (Id, Nome, Endereco) VALUES
(202221, 'Noémi Cedraz Chainho',69086562),
(202222, 'Keyla Júdice Vilhena',79905416),
(202223, 'Brahim Canário Paredes',78057016),
(202224, 'Zélia Garcez Viegas',27971224),
(202225, 'Marwa Gadelha Branco',76901256),
(202226, 'Nídia Cabeça Póvoas',60843260),
(202227, 'Lícia Madeira Mourinho',68909810),
(202228, 'Thiago Hernandes Noronha',69902124),
(202229, 'Lya Banha Lucas',37900064),
(202230, 'Jefferson Abreu Coelho',03801070);

INSERT INTO FORNECEDOR (Id, Nome, CEP) VALUES
(00101,'Companhia das Letras',91140240),
(00102,'Editora Rocco',54789315),
(00103,'Editora Arqueiro',91160157),
(00104,'Editora Intrínseca',71996395),
(00105,'Editora Sextante',29162000),
(00106,'Ediouro',61905240),
(00107,'Panda Books',85860440),
(00108,'FTD',77022332),
(00109,'Ubu',74230250),
(00110,'Alta Books',69305640);

INSERT INTO FORNECEDOR_ENDERECO (CEP, Id, UF, Cidade, Rua, Numero) VALUES
(91140240, 00101, 'AC', 'Rio Branco', 'Rua das Violetas', 20),
(54789315, 00102, 'PR', 'Fazenda Rio Grande', 'Rua Santo Inácio', 837),
(91160157, 00103, 'MA', 'São Luís', 'Rua Bom Jesus', 37),
(71996395, 00104, 'PA', 'Ananindeua', 'Rua Verinha Bastos', 429),
(71996395, 00105, 'AL', 'Arapiraca', 'Avenida Elvira Barbosa Lopes', 920),
(61905240, 00106, 'SC', 'Rio do Sul', 'Rodovia SC-350', 370),
(85860440, 00107, 'AL', 'Maceió', 'Rua José Alberto Correia', 920),
(77022332, 00108, 'BA', 'Salvador', 'Rua Ituaçu', 109),
(74230250, 00109, 'AP', 'Macapá', '3ª Avenida da Universidade', 409),
(69305640, 00110, 'PE', 'Olinda', 'Rua Primeiro de Janeiro', 490);

INSERT INTO PRATELEIRA (Id, Genero, Qtd_livros) VALUES
(00001,'Romance', 250),
(00002,'Fantasia', 179),
(00003,'Fábula', 290),
(00004,'Suspense', 310),
(00005,'Conto', 430),
(00006,'Autobiografia', 189),
(00007,'Ciências da Terra', 370),
(00008,'Ciência Política', 410),
(00009,'Engenharia', 290),
(00010,'Medicina', 100);

INSERT INTO SETORES (Id, Prateleira, Func_responsavel) VALUES
(00101,00001, 202211),
(00102,00002, 202212),
(00103,00003, 202213),
(00104,00004, 202214),
(00105,00005, 202215),
(00106,00006, 202216),
(00107,00007, 202217),
(00108,00008, 202218),
(00109,00009, 202219),
(00110,00010, 202220);

INSERT INTO COMPOE (Id_prateleira, Id_setor) VALUES 
(00001,00101),
(00002,00102),
(00003, 00103),
(00004, 00104),
(00005, 00105),
(00006, 00106),
(00007, 00107),
(00008, 00108),
(00009, 00109),
(00010, 00110);

INSERT INTO SETOR_DE (Nome_genero, Id_setor) VALUES
('Romance', 00101),
('Fantasia', 00102),
('Fábula', 00103),
('Suspense', 00104),
('Conto', 00105),
('Autobiografia', 00106),
('Ciências da Terra', 00107),
('Ciência Política', 00108),
('Engenharia', 00109),
('Medicina', 00110);

INSERT INTO ESCREVE_LIVROS_DE (Nome_genero, Id_autor) VALUES
('Romance', 1201),
('Fantasia', 1202),
('Fábula', 1203),
('Suspense', 1204),
('Conto', 1205),
('Autobiografia', 1206),
('Ciências da Terra', 1207),
('Ciência Política', 1208),
('Engenharia', 1209),
('Medicina', 1210);

INSERT INTO ESCRITO_POR (Id_livro, Id_autor) VALUES
(1001, 1201),
(1002, 1202),
(1003, 1203),
(1004, 1204),
(1005, 1205),
(1006, 1206),
(1007, 1207),
(1008, 1208),
(1009, 1209),
(1010, 1210);

INSERT INTO LIVRO_DE (Id_livro, Nome_genero) VALUES 
(1001, 'Romance'),
(1002, 'Romance'),
(1003, 'Fantasia'),
(1004, 'Fábula'),
(1005, 'Fantasia'),
(1006, 'Suspense'),
(1007, 'Romance'),
(1008, 'Aventura'),
(1009, 'Fantasia'),
(1010, 'Romance');

INSERT INTO ENCOMENDA_DE (Id_livro, Id_fornecedor, Id_func_adm) VALUES 
(1001, 00101, 202221),
(1002, 00101, 202221),
(1003, 00101, 202221),
(1004, 00105, 202222),
(1005, 00105, 202222),
(1006, 00106, 202223),
(1007, 00107, 202224),
(1008, 00108, 202225),
(1009, 00109, 202226),
(1010, 00110, 202228);

INSERT INTO REGISTRA (Reg_cliente, Id_func_ajd) VALUES
(0001, 202201),
(0002, 202202),
(0003, 202203),
(0004, 202204),
(0005, 202205),
(0006, 202206),
(0007, 202207),
(0008, 202208),
(0009, 202209),
(0010, 202210);

INSERT INTO REQUER_AJUDA(Reg_cliente, Id_func_ajd) VALUES
(0001, 202211),
(0002, 202212),
(0003, 202213),
(0004, 202214),
(0005, 202215),
(0006, 202216),
(0007, 202217),
(0008, 202218),
(0009, 202219),
(0010, 202220);

-- Nomes dos clientes que pediram ajuda ao funcionário Gusttavo Pestana Franca ou ao funcionario Zaqueu Canadas Carvalhoso.

SELECT C.nome
FROM CLIENTE C, REQUER_AJUDA R, FUNC_AJUDANTE F
WHERE C.Registro = R.Reg_cliente
AND R.Id_func_ajd = F.Id
AND F.Nome = 'Gusttavo Pestana Franca'
UNION
SELECT C2.nome
FROM CLIENTE C2, REQUER_AJUDA R2, FUNC_AJUDANTE F2
WHERE C2.Registro = R2.Reg_cliente
AND R2.Id_func_ajd = F2.Id
AND F2.Nome = 'Gusttavo Pestana Franca';

-- Nome dos clientes que fazem empréstimo do livro "Dom Quixote" mas não de "O Senhor dos Anéis"

SELECT C.nome
FROM CLIENTE C, LIVRO L, EMPRESTIMO E
WHERE C.Registro = E.Id_cliente
AND L.Id = E.Id_livro
AND L.Titulo = 'Dom Quixote'
AND C.Registro NOT IN (	SELECT C2.Registro
						FROM CLIENTE C2, LIVRO L2, EMPRESTIMO E2
						WHERE C2.Registro = E2.Id_cliente
						AND L2.Id = E2.Id_livro
						AND L2.Titulo = 'O Senhor dos Anéis');
                        
-- Nome dos livros que são de Romance ou são escritos por Miguel de Cervantes

SELECT L.Titulo 
FROM LIVRO L
WHERE L.Genero = 'Romance' 
UNION 
SELECT L.Titulo 
FROM LIVRO L, AUTOR A
WHERE L.Autor = A.Nome AND 
     A.nome = 'Miguel de Cervantes';
     
-- Número de livros do genero 'Romance', mas que não foram escritos por Agatha Christie 

SELECT L.Titulo 
FROM LIVRO L
WHERE L.Genero = 'Romance' 
AND L.Id NOT IN ( SELECT L2.Id
				  FROM LIVRO L2, AUTOR A
				  WHERE L2.Autor = A.Nome AND 
				  A.nome = 'Agatha Christie');

-- Nome dos clientes que fizeram empréstimo do livro "O Pequeno Príncipe"

SELECT C.Nome
FROM CLIENTE C
WHERE C.Registro IN( SELECT E.Id_cliente
					 FROM EMPRESTIMO E, LIVRO L
                     WHERE E.Id_livro = L.Id 
	                 AND L.Titulo = 'O Pequeno Príncipe');
                     
-- Nome dos autores que escrevem livros de Fantasia 

SELECT A.Nome
FROM AUTOR A
WHERE A.Id IN (SELECT A2.Id
				FROM AUTOR A2, GENERO G
                WHERE A2.Genero = G.Nome
                AND G.Nome = 'Fantasia');

-- Nome dos clientes que não fizeram reservas de livros de aventura

SELECT C.Nome
FROM CLIENTE C
WHERE C.Registro NOT IN( SELECT E.Id_cliente
					 FROM EMPRESTIMO E, LIVRO L, GENERO G
                     WHERE E.Id_livro = L.Id
                     AND L.Genero = G.Nome
	                 AND L.Genero = 'Aventura');

-- Nome dos clientes que não fizeram empréstimo do livro "O Pequeno Príncipe"
SELECT C.Nome
FROM CLIENTE C
WHERE NOT EXISTS ( SELECT E.Id_cliente
					 FROM EMPRESTIMO E, LIVRO L
                     WHERE E.Id_livro = L.Id
	                 AND L.Titulo = 'O Pequeno Principe');
                     

-- Nome dos setores que estão sob responsbilidade do funcionário ajudante Sebastian Pinheiro Taveiros

SELECT S.Id
FROM SETORES S
WHERE S.Id IN (SELECT FA.Id_Setor
				FROM FUNC_AJUDANTE FA
                WHERE FA.Nome = 'Sebastian Pinheiro Taveiros');

-- Nome dos clientes que fazem empréstimo de um livro Fantasia, mas que não foi escrito por J. K. Rowling

SELECT C.nome
FROM CLIENTE C, LIVRO L, EMPRESTIMO E
WHERE C.Registro = E.Id_cliente
AND L.Id = E.Id_livro
AND L.Genero = 'Fantasia'
AND C.Registro NOT IN (	SELECT C2.Registro
						FROM CLIENTE C2, LIVRO L2, EMPRESTIMO E2
						WHERE C2.Registro = E2.Id_cliente
						AND L2.Id = E2.Id_livro
						AND L2.Autor = 'J. K. Rowling');
