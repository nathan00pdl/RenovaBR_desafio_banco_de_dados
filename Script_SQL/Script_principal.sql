--COMANDOS SQL UTILIZANDO O POSTGRESQL PARA PROCESSAMENTO E CONSULTA DOS DADOS: 

--Utilizei o powershell do Visual Studio Code apenas por questão de costume, porém todas consultas também foram testadas no pgAdmin.

--Acessando o servidor do PostgreSQL pelo terminal do VScode 
psql -U postgres -d postgres  

--OBSERVAÇÕES: 
--Banco de dados "postgres"  (-d postgres) é um banco de dados padrão criado pelo PostgreSQL
--Usuário "postgres" (-U postgres) é um Superusuário padrão do PostgreSQL (papel/role ao qual possui maior autonomia sobre um banco de dados)

--Comando SQL para criação do banco de dados
CREATE DATABASE desafio_tecnico_renovabr;

--Comando SQL para acessar o banco de dados
\c desafio_tecnico_renovabr

--Comando SQL para criação do Schema "dados_eleitorais"
CREATE SCHEMA dados_eleitorais;

--Comando SQL para criação da tabela "perfil_eleitorado_2020"
CREATE TABLE dados_eleitorais.perfil_eleitorado_2020 (
    dt_geracao DATE,
    hh_geracao VARCHAR,
    ano_eleicao INTEGER,
    sg_uf VARCHAR,
    cd_municipio INTEGER,
    nm_municipio VARCHAR,
    cd_mun_sit_biometria INTEGER,
    ds_mun_sit_biometria VARCHAR,
    nr_zona INTEGER,
    cd_genero INTEGER,
    ds_genero VARCHAR,
    cd_estado_civil INTEGER,
    ds_estado_civil VARCHAR,
    cd_faixa_etaria INTEGER,
    ds_faixa_etaria VARCHAR,
    cd_grau_escolaridade INTEGER,
    ds_grau_escolaridade VARCHAR,
    qt_eleitores_perfil INTEGER,
    qt_eleitores_biometria INTEGER,
    qt_eleitores_deficiencia INTEGER,
    qt_eleitores_inc_nm_social INTEGER
);

--Comando SQL para criação da tabela "sp_turno_1"
CREATE TABLE dados_eleitorais.sp_turno_1 (
    dt_geracao DATE,
    hh_geracao VARCHAR, 
    ano_eleicao INTEGER,
    cd_tipo_eleicao INTEGER,
    nm_tipo_eleicao VARCHAR,
    cd_pleito INTEGER,
    dt_pleito DATE,
    nr_turno INTEGER,
    cd_eleicao INTEGER, 
    ds_eleicao VARCHAR, 
    sg_uf VARCHAR, 
    cd_municipio INTEGER, 
    nm_municipio VARCHAR, 
    nr_zona INTEGER,  
    nr_secao INTEGER, 
    nr_local_votacao INTEGER,
    cd_cargo_pergunta INTEGER, 
    ds_cargo_pergunta VARCHAR,
    nr_partido INTEGER,
    sg_partido VARCHAR,
    nm_partido VARCHAR,
    dt_bu_recebido VARCHAR,
    qt_aptos INTEGER, 
    qt_comparecimento INTEGER, 
    qt_abstencoes INTEGER, 
    cd_tipo_urna INTEGER, 
    ds_tipo_urna VARCHAR, 
    cd_tipo_votavel INTEGER, 
    ds_tipo_votavel VARCHAR, 
    nr_votavel INTEGER, 
    nm_votavel VARCHAR, 
    qt_votos INTEGER, 
    nr_urna_efetivada INTEGER, 
    cd_carga_1_urna_efetivada VARCHAR, 
    cd_carga_2_urna_efetivada VARCHAR, 
    cd_flashcard_urna_efetivada VARCHAR, 
    dt_carga_urna_efetivada VARCHAR, 
    ds_cargo_pergunta_secao VARCHAR, 
    ds_agregadas VARCHAR, 
    dt_abertura VARCHAR, 
    dt_encerramento VARCHAR, 
    qt_eleitores_biometria_nh INTEGER, 
    dt_emissao_bu VARCHAR, 
    nr_junta_apuradora INTEGER, 
    nr_turma_apuradora INTEGER
); 

--Criação de índices
CREATE INDEX  uf_idx_btree ON dados_eleitorais.perfil_eleitorado_2020 USING BTREE(sg_uf);
CREATE INDEX  escolaridade_idx_btree ON dados_eleitorais.perfil_eleitorado_2020 USING BTREE(ds_grau_escolaridade);
CREATE INDEX  candidato_idx_btree ON dados_eleitorais.sp_turno_1 USING BTREE(nm_votavel);

--OBSERVAÇÃO:
--O primeiro índice foi criado com o intuito de aumentar o desempenho das consultas as quais restringirão ao estado de São Paulo (sg_uf = sp)
--O segundo índice foi criado com o intuito de aumentar o desempenho da consulta a qual envolverá a questão da escolaridade
--O terceiro índice foi criado com o intuito de aumentar o desempenho das consultas as quais serão referentes aos candidatos (nm_votavel = 'nome_do_candidato')


--Comando SQL para inserir todos os dados na tabela "perfil_eleitorado_2020"
COPY dados_eleitorais.perfil_eleitorado_2020(
    dt_geracao, 
    hh_geracao, 
    ano_eleicao,
    sg_uf, 
    cd_municipio, 
    nm_municipio,
    cd_mun_sit_biometria, 
    ds_mun_sit_biometria, 
    nr_zona, 
    cd_genero, 
    ds_genero, 
    cd_estado_civil, 
    ds_estado_civil, 
    cd_faixa_etaria, 
    ds_faixa_etaria, 
    cd_grau_escolaridade, 
    ds_grau_escolaridade, 
    qt_eleitores_perfil, 
    qt_eleitores_biometria, 
    qt_eleitores_deficiencia, 
    qt_eleitores_inc_nm_social
    )
FROM 'C:/Users/Nathan/Downloads/perfil_eleitorado_2020_FORMATADO.csv' 
WITH (FORMAT CSV, HEADER, ENCODING 'UTF-8');

--Comando SQL para inserir todos os dados na tabela "sp_turno_1"
COPY dados_eleitorais.sp_turno_1(
    dt_geracao,
    hh_geracao,
    ano_eleicao,
    cd_tipo_eleicao,
    nm_tipo_eleicao,
    cd_pleito,
    dt_pleito,
    nr_turno,
    cd_eleicao,
    ds_eleicao,
    sg_uf,
    cd_municipio,
    nm_municipio,
    nr_zona,
    nr_secao,
    nr_local_votacao,
    cd_cargo_pergunta,
    ds_cargo_pergunta,
    nr_partido,
    sg_partido,
    nm_partido,
    dt_bu_recebido,
    qt_aptos,
    qt_comparecimento,
    qt_abstencoes,
    cd_tipo_urna,
    ds_tipo_urna,
    cd_tipo_votavel,
    ds_tipo_votavel,
    nr_votavel,
    nm_votavel,
    qt_votos,
    nr_urna_efetivada,
    cd_carga_1_urna_efetivada,
    cd_carga_2_urna_efetivada,
    cd_flashcard_urna_efetivada,
    dt_carga_urna_efetivada,
    ds_cargo_pergunta_secao,
    ds_agregadas,
    dt_abertura,
    dt_encerramento,
    qt_eleitores_biometria_nh,
    dt_emissao_bu,
    nr_junta_apuradora,
    nr_turma_apuradora
)
FROM 'C:/Users/Nathan/Downloads/SP_turno_1_FORMATADO.csv' 
WITH (FORMAT CSV, HEADER, ENCODING 'UTF-8');



--OBSERVAÇÕES: 
--"COPY" é um comando nativo do PostgreSQL utilizado para inserção de dados a partir de um arquivo no formato .csv
--Uma alternativa para inserção dos dados seria o comando básico SQL: INSERT INTO nome_da_tabela (nomes_das_colunas) VALLUES (valores_a_serem _inseridos);
--Para utilizar o comando "INSERT INTO..", ele deveria ser inserido em cada linha do arquivo .csv, logo não sendo muito viável devido o tamanho do arquivo.
--Para que o PostgreSQL pudesse fazer essa "cópia" dos dados e atribuir às tabelas criadas, foi necessário alterar as propriedades do arquivo .csv no que diz respeito a liberação da função de leitura/gravar para PostgreSQL.


--Consultas (queries):

--1)Liste a quantidade de pessoas aptas a votarem apenas no estado de São Paulo.
SELECT SUM(qt_eleitores_perfil) AS qtde_pessoas_aptas_para_votar
FROM dados_eleitorais.perfil_eleitorado_2020;

--2)Liste todos os candidatos da cidade de São Paulo.
SELECT nm_votavel AS nome_candidato
FROM dados_eleitorais.sp_turno_1 
WHERE nm_municipio = 'sao_paulo';

--3)Qual a quantidade de pessoas que se candidataram na cidade de São Paulo?
SELECT COUNT(nm_votavel) AS quantidade_candidatos
FROM dados_eleitorais.sp_turno_1 
WHERE nm_municipio = 'sao_paulo'
GROUP BY nm_votavel;  --Esse agrupamento é necessário devido o uso da função COUNT.

--4)Liste os graus de escolaridade dos indivíduos que votaram no estado de São Paulo.
SELECT DISTINCT ds_grau_escolaridade AS grau_de_escolaridade
FROM  dados_eleitorais.perfil_eleitorado_2020 tab_1
INNER JOIN dados_eleitorais.sp_turno_1 tab_2 
ON tab_1.sg_uf = tab_2.sg_uf;  --Essa condição garantirá que a consulta seja efetuada apenas para o estado de São Paulo.

--5)Em qual município o candidato Bruno Covas foi mais votado?
SELECT nm_municipio AS nome_municipio
FROM dados_eleitorais.sp_turno_1
WHERE qt_votos = (
    SELECT MAX(qt_votos) 
    FROM dados_eleitorais.sp_turno_1
    WHERE nm_votavel = 'bruno_covas'
);

--6)Qual candidato foi mais votado em São Paulo?
SELECT nm_municipio AS nome_municipio, nm_votavel AS nome_candidato
FROM dados_eleitorais.perfil_eleitorado_2020 tab_1
INNER JOIN dados_eleitorais.sp_turno_1 tab_2
ON tab_1.sg_uf = tab_2.sg_uf
WHERE qt_votos = (
    SELECT MAX(qt_votos)
    FROM dados_eleitorais.sp_turno_1
);
