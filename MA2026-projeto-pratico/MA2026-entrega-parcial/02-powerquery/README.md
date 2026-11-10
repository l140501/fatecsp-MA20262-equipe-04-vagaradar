# Etapa 2 -- Power Query e Tratamento de Dados (VagaRadar)

## 1. Lista Completa das Consultas e Respetivas Funções

### Parâmetros e Dados Brutos
* **`ArquivoCadastro.pq`**: Parâmetro com o caminho de origem do ficheiro de cadastro/configuração.
* **`Vagas_Bruto.pq`**: Leitura inicial da base bruta de vagas sem tratamentos aplicados.

### Tabelas Fato, Dimensões e Auditoria
* **`fVagas.pq`**: Tabela fato com as vagas higienizadas e validadas para o modelo.
* **`CargosReferencia.pq`**: Dimensão com a lista padronizada de cargos de referência.
* **`CargosVinculados.pq`**: Mapeamento dos títulos de vagas associados aos respetivos cargos de referência.
* **`DeParaCidades.pq`**: Tabela dimensão e mapeamento padronizado de cidades e UFs.
* **`DeParaColunas.pq`**: Mapeamento de equivalência e renomeação de colunas da base.
* **`rejeitados.pq`**: Tabela de auditoria contendo as linhas brutas descartadas no tratamento.

### Funções Personalizadas (M)
* **`fnData.pq`**: Função para validação, conversão e conversão de formatos de data.
* **`fnLerPlanilha.pq`**: Função auxiliar para abertura e extração dinâmica de abas de planilhas Excel.
* **`fnLerVagas.pq`**: Função de parsing e leitura estruturada do ficheiro de vagas.
* **`fnPadronizarColunas.pq`**: Função para limpeza de cabeçalhos e padronização de nomes de colunas.
* **`fnValorOficial.pq`**: Função de tratamento de texto para remoção de acentos e caracteres especiais.

### Tabelas de Suporte e Conferência
* **`ColunasAlvo.pq`**: Lista de estrutura das colunas oficiais esperadas no modelo final.
* **`Conf_Colunas.pq`**: Consulta de validação e verificação de integridade das colunas carregadas.
* **`Conf_Motivos.pq`**: Tabela de conferência com o agrupamento dos motivos de rejeição de linhas.
* **`Conf_Reconciliacao.pq`**: Reconciliação quantitativa total (linhas lidas = aceitas + rejeitadas).
* **`ListaAreas.pq`**: Tabela de suporte com a lista de áreas profissionais mapeadas.
* **`ListaModeloDeTrabalho.pq`**: Lista de domínios válidos para modelo de trabalho (Remote, Híbrido, Presencial).

---

## 2. Valores dos Parâmetros
* **`ArquivoCadastro`**: Armazena o caminho local do ficheiro base de dados/cadastros para dinamizar a execução entre diferentes utilizadores.

---

## 3. Regras de Rejeição de Dados
As linhas registadas em `rejeitados.pq` foram descartadas com base nos critérios auditados em `Conf_Motivos.pq`:
1. Identificador da vaga (`ID_Vaga`) nulo ou em formato inválido.
2. Inconsistência de datas de publicação fora do período limite do projeto (ano de 2026).
3. Falta de atributos mínimos para mapeamento de cargo e localização.

---

## 4. Decisões Pendentes e Observações Herdadas
* Manutenção da reconciliação zero entre a base bruta lida e o somatório de `fVagas` + `rejeitados`.
* Padronização dos textos via `fnValorOficial` para evitar falhas de relacionamento na Etapa 3.