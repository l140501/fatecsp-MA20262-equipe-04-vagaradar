# Etapa 3 -- Power Pivot e Medidas DAX (VagaRadar)

## 1. Objetivo da Etapa
Estruturar o Modelo de Dados relacional (Star Schema) no Power Pivot a partir da base tratada na Etapa 2, criar a Tabela de Calendário (`dCalendario`) e desenvolver medidas DAX para análise quantitativa, distribuição temporal e reconciliação da base de vagas de emprego.

---

## 2. Instruções para Execução e Atualização
Para abrir e atualizar o projeto em qualquer ambiente:

1. Abra o arquivo `03-powerpivot/VagaRadar_03_PowerPivot.xlsx` no Microsoft Excel.
2. Acesse a guia **Dados** -> **Obter Dados** -> **Iniciar Editor do Power Query**.
3. Na guia **Página Inicial**, clique em **Gerenciar Parâmetros**.
4. Altere o valor do parâmetro `pArquivoEtapa2` para o caminho completo do ficheiro da Etapa 2 no seu computador (ex: `C:\SeuCaminho\02-powerquery\VagasRadar_02_PowerQuery.xlsx`).
5. Clique em **OK**, feche o Power Query e clique em **Dados -> Atualizar Tudo**.

---

## 3. Estrutura do Modelo Relacional
O modelo contém a tabela fato `fVagas` conectada a 3 dimensões ativas e 1 tabela de auditoria oculta. 

Para mais detalhes sobre chaves primárias, chaves estrangeiras, granularidade e o diagrama completo do modelo, acesse:
-> [Documentação do Modelo Relacional (docs/modelo_relacional.md)](docs/modelo_relacional.md)

---

## 4. Lista de Medidas DAX e Perguntas Respondidas

| Medida | Pergunta de Negócio Respondida |
|---|---|
| `[Vagas Postadas]` | Quantas vagas válidas foram publicadas no total ou no recorte selecionado? |
| `[Salário Médio de TI]` | Qual é o salário médio publicado para as vagas de TI? |
| `[Salario Medio Brasil]` | Qual é o valor absoluto do salário base estimado do Brasil (cálculo reverso via índice)? |
| `[Qtd Vagas Remotas]` | Quantas vagas aceitam o formato de trabalho 100% Remoto? |
| `[Conf Linhas fVagas]` | Quantas linhas foram carregadas na tabela fato? |
| `[Conf Linhas Rejeitados]` | Quantas linhas brutas foram descartadas no tratamento? |
| `[Conf Linhas Lidas]` | Qual o total de linhas lidas (aceitas + rejeitadas)? |
| `[Conf PK Duplicada Cargo]` | Existem chaves primárias duplicadas na dimensão de cargos? (Espera-se: 0) |
| `[Conf Vagas sem Cargo]` | Quantas vagas não possuem cargo de referência associado? (Espera-se: 0) |
| `[Conf Vagas sem Cidade]` | Quantas vagas não possuem cidade associada na dimensão? (Espera-se: 0) |
| `[Conf Vagas sem Data]` | Quantas vagas possuem data de publicação fora do calendário? (Espera-se: 0) |

---

## 5. Resultados da Conferência e Reconciliação
Os testes de auditoria na aba **Conferência** validam o modelo de dados em relação à Etapa 2:

* **Linhas aceitas (`fVagas`):** 1.362
* **Linhas rejeitadas (`Rejeitados`):** 161
* **Total de linhas lidas:** 1.523
* **Diferença de conciliação:** 0 em todas as linhas e medidas de integridade.

 As evidências visuais encontram-se salvas nas pastas `evidencias/conferencia.png` e `evidencias/diagrama_modelo.png`.

---

## 6. Pendências Herdadas da Etapa 2
* **Regras de Rejeição:** 161 linhas brutas foram descartadas por motivo de inconsistência de formato, ausência de ID_Vaga ou datas fora do padrão.
* **Mapeamento de Cargos:** Aplicação das regras de DE-PARA em `CargosVinculados` garantindo cardinalidade N:1 sem duplicações cartesianas.
* **Tratamento de Cidades e Índices:** Padronização oficial aplicada via função `fnValorOficial` para normalização de acentos e caracteres especiais.