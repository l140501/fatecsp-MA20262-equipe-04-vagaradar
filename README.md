# VagaRadar -- Análise e BI de Vagas de Emprego em Tecnologia

O **VagaRadar** é um projeto completo de Business Intelligence desenvolvido para a disciplina de Microinformática Aplicada (FATEC São Paulo). O objetivo do projeto é estruturar, higienizar e analisar dados de vagas de emprego na área de TI, transformando registros brutos em um modelo relacional robusto para análises salariais, distribuição geográfica e tendências de recrutamento.

## 📂 Estrutura do Repositório

O repositório está organizado segundo o padrão acadêmico exigido para as entregas parciais e finais da disciplina:

```
.
├── README.md                                # Documentação principal do repositório
├── MA2026-entrega-final/                     # Diretório para a entrega final
│
└── MA2026-entrega-parcial/                   # Diretório com a entrega parcial do projeto
    ├── dados_brutos/                        # Arquivos brutos originais
    │   ├── vagas/                           # Arquivos fonte de vagas de emprego
    │   └── Cadastro.xlsx                    # Planilha de apoio e cadastros de referência
    │
    ├── 01_excel/                            # Etapa 1: Carga inicial e análises preliminares
    │   └── VagaRadar_01_Excel.xlsx          # Planilha com dados brutos organizados
    │
    ├── 02-powerquery/                       # Etapa 2: ETL e Tratamento no Power Query
    │   ├── README.md                        # Documentação técnica e regras da Etapa 2
    │   ├── Vagaradar_02_PowerQuery.xlsx     # Planilha contendo o processo de ETL em M
    │   ├── dados_limpos/                    # Dados higienizados exportados
    │   ├── evidencias/                      # Evidências de conferência e reconciliação
    │   └── scripts_m/                       # Scripts em Código M (.pq)
    │
    └── 03-powerpivot/                       # Etapa 3: Modelagem Relacional e DAX
        ├── README.md                        # Documentação técnica e instruções da Etapa 3
        ├── VagaRadar_03_PowerPivot.xlsx     # Modelo de Dados relacional e Tabelas Dinâmicas
        ├── dax/                             # Backup das fórmulas DAX
        ├── docs/                            # Documentação formal do modelo relacional
        ├── evidencias/                      # Capturas de tela de evidências
        └── scripts_m/                       # Scripts em Código M da Etapa 3

```

## 🛠️ Tecnologias e Recursos Utilizados

* **Microsoft Excel** (Power Query & Power Pivot)
* **Linguagem M** (Tratamento de dados, funções personalizadas e ETL)
* **Linguagem DAX** (Modelagem multidimensional, cálculos dinâmicos e auditoria)
* **Markdown (.md)** (Documentação técnica de repositório)

## 🚀 Resumo das Etapas do Projeto

### Etapa 1 -- Carga Inicial e Análise Exploratória (`01_excel/`)

* Organização da base inicial de vagas brutas e estrutura do cadastro de referência (`dados_brutos/`).
* Validação inicial das colunas essenciais (`ID_Vaga`, `Titulo_Vaga`, `Cidade`, `Data_Publicacao`, `salario_medio`).

### Etapa 2 -- ETL e Higienização de Dados (`02-powerquery/`)

* **Isolamento de Origem:** Utilização do parâmetro `pArquivoEtapa2` para garantir a execução dinâmica em diferentes máquinas.
* **Padronização:** Aplicação de funções personalizadas M (`fnValorOficial`, `fnData`, `fnPadronizarColunas`) para remoção de acentos, acertos de caixa e datas.
* **Mapeamento de Cargos:** Relacionamento N:1 entre títulos de vagas e 17 cargos de referência (`CargoReferencia` e `CargosVinculados`).
* **Auditoria de Rejeições:** Separação de 161 linhas brutas descartadas com inconsistências na consulta `rejeitados.pq`.
* **Resultado:** Carga limpa com **1.523 vagas válidas**.

### Etapa 3 -- Modelagem Relacional e DAX (`03-powerpivot/`)

* **Modelo Star Schema:** Criação do modelo dimensional conectando `fVagas` com `CargoReferencia`, `Cidades` e `dCalendario` (ano de 2026).
* **Indicadores DAX:** Desenvolvimento de medidas para contagem de vagas (`[Vagas Postadas]`), salário médio (`[Salário Médio de TI]`), e salário base nacional por cálculo reverso (`[Salario Medio Brasil]`).
* **Reconciliação e Integridade:** Implementação de medidas de auditoria de integridade (`Conf Linhas...`, `Conf PK Duplicada...`, `Conf Vagas sem...`) vinculadas à aba **Conferência** através de funções `=VALORCUBO()`, garantindo diferença **zero**.

## 📋 Como Executar o Projeto

1. Clone ou faça o download deste repositório para o seu computador.
2. Abra o arquivo `03-powerpivot/VagaRadar_03_PowerPivot.xlsx` no Microsoft Excel.
3. Para parametrizar o caminho na sua máquina:
   * Vá em **Dados** $\rightarrow$ **Obter Dados** $\rightarrow$ **Iniciar Editor do Power Query**.
   * Na guia **Página Inicial**, clique em **Gerenciar Parâmetros**.
   * Altere o valor do parâmetro `pArquivoEtapa2` apontando para o caminho local do arquivo `Vagaradar_02_PowerQuery.xlsx` na sua pasta `02-powerquery/`.
   * Clique em **Fechar e Carregar** e execute **Dados** $\rightarrow$ **Atualizar Tudo**.