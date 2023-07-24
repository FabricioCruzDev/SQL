-- AVG MIN MAX SUM ROUND

SELECT MAX(valor_receita) AS max_valor_receita,
MIN(valor_receita) AS min_valor_receita,
AVG(valor_receita) AS avr_valor_receita,
SUM(valor_receita) AS sun_valor_receita
FROM `basedosdados.br_tse_eleicoes.receitas_candidato`
WHERE ano = 2018 AND sigla_uf = 'BA';

-- Pesquisa auxiliar para encontrar um atributo chave para a pesquisa principal 
SELECT DISTINCT cpf_candidato, nome_candidato FROM `basedosdados.br_tse_eleicoes.receitas_candidato` WHERE sigla_uf = "BA" AND ano = 2018 AND cargo = "governador";

SELECT COUNT(DISTINCT cpf_cnpj_doador) AS qtd_doadores
FROM `basedosdados.br_tse_eleicoes.receitas_candidato`
WHERE cpf_candidato = '23790997587' AND ano = 2018 AND sigla_uf = 'BA';

-- Encontrando o valor médio arredondado em 3 casas decimais.
SELECT ROUND(AVG(valor_receita), 3) AS valor_receita_media
FROM `basedosdados.br_tse_eleicoes.receitas_candidato`
WHERE ano = 2018 AND sigla_uf = 'AC' AND cargo= 'governador';


-- DESAFIO
--Tabelas de depesas.
--Quantos fornecedores do governador Rui Costa em 2018.
--Qual o valor total de despesas, valor máximo e mínimo.
--renomear os campos.

--encontrando cpf candidado 
SELECT DISTINCT nome_candidato, cpf_candidato 
FROM `basedosdados.br_tse_eleicoes.despesas_candidato` 
WHERE sigla_uf = 'BA' AND ano = 2018 AND cargo = 'governador'
ORDER BY nome_candidato;
--resposta (23790997587)

-- resolvendo o desafio
SELECT COUNT(DISTINCT cpf_cnpj_fornecedor) AS CONTAGEM_FORNECEDORES,
       ROUND(SUM(valor_despesa), 2) AS TOTAL_DESPESAS,
       MAX(valor_despesa) AS MAIOR_DESPESA,
       MIN(valor_despesa) AS MENOR_DESPESA
FROM `basedosdados.br_tse_eleicoes.despesas_candidato`
WHERE cpf_candidato = '23790997587' AND ano = 2018 AND sigla_uf = 'BA'

  -- GROUP BY HAVING CASE
SELECT nome_candidato, COUNT(DISTINCT cpf_cnpj_doador) AS qtd_doadores,
ROUND(SUM(valor_receita), 2) AS Receita_Total
FROM `basedosdados.br_tse_eleicoes.receitas_candidato`
WHERE ano = 2018 AND cargo = 'governador' AND sigla_uf = 'BA'
GROUP BY nome_candidato
HAVING Receita_Total < 50000
ORDER BY Receita_Total DESC;

SELECT nome_candidato, sigla_partido, COUNT(DISTINCT cpf_cnpj_doador) AS qtd_doadores,
ROUND(SUM(valor_receita), 2) AS Receita_Total,
CASE WHEN SUM(valor_receita) > 1000000 THEN 'alta'
    ELSE 'baixa' END AS Categoria_Receita,
CASE WHEN sigla_partido IN ('PT', 'PSOL', 'PCD') THEN 
'ESQUERDA' ELSE 'DIREITA' END AS espectro_partidario
FROM `basedosdados.br_tse_eleicoes.receitas_candidato`
WHERE ano = 2018 AND cargo = 'governador' AND sigla_uf = 'BA'
GROUP BY nome_candidato, sigla_partido
ORDER BY Receita_Total DESC;

-- DESAFIO
--Quantidade de fornecedores
--Soma valor total de despesas dos candidatos, por candidato a governador-BA

-- resolvendo o desafio
SELECT DISTINCT nome_candidato, COUNT(DISTINCT cpf_cnpj_fornecedor),
        ROUND(SUM(valor_despesa), 2) AS total_despesas,
        CASE WHEN SUM(valor_despesa) > 100000 THEN 'alto' ELSE 'baixo' END AS Consumo
        FROM `basedosdados.br_tse_eleicoes.despesas_candidato`
        WHERE ano = 2018 AND cargo = 'governador' AND sigla_uf = 'BA'
        GROUP BY nome_candidato
        ORDER BY total_despesas;
