# ENEM-AI Analyst

Uma plataforma de análise de dados educacionais brasileiros que utiliza inteligência artificial para permitir consultas em linguagem natural sobre dados do ENEM e do Censo Escolar.

## Sobre o Projeto

O ENEM-AI Analyst utiliza um sistema multi-agente baseado no Google Agent Development Kit (ADK) para processar consultas em linguagem natural, gerar visualizações e fornecer insights sobre dados educacionais brasileiros.

## Características Principais

- **Interface Conversacional**: Faça perguntas em português natural e obtenha respostas claras e concisas.
- **Visualizações Inteligentes**: Receba gráficos e tabelas adequados ao tipo de pergunta e dados.
- **Correlações entre Fontes**: Descubra relações entre infraestrutura escolar (Censo) e desempenho (ENEM).

## Como Funciona: Uma Arquitetura Multi-Agente

O coração do ENEM-AI Analyst é um sistema de múltiplos agentes de IA, orquestrado para responder a perguntas complexas de forma colaborativa. Cada agente é um especialista com uma função específica, garantindo que cada etapa do processo de análise seja tratada com precisão.

A arquitetura é definida principalmente no arquivo `enem_ai_analyst/agent.py` e no diretório `enem_ai_analyst/sub_agents/` e funciona da seguinte forma:

1.  **Agente Orquestrador (`agent.py`)**: Este é o "maestro" do sistema. Ele recebe a pergunta do usuário em linguagem natural e coordena o trabalho dos outros agentes. Ele não responde diretamente, mas segue um fluxo de trabalho rigoroso para garantir que a resposta final seja completa e precisa.

2.  **Agentes Especialistas (`sub_agents/`)**: São as ferramentas que o Orquestrador utiliza. Cada um é um LLM com um prompt de sistema especializado:
    *   **`data_agent.py` (Agente de Dados)**: O engenheiro de dados. Sua única função é traduzir a pergunta do usuário em uma consulta SQL segura e eficiente, extrair os dados do banco de dados PostgreSQL e entregá-los em um formato limpo (JSON).
    *   **`analysis_agent.py` (Agente de Análise)**: O estatístico. Ele recebe os dados brutos do Agente de Dados e realiza análises descritivas, como médias, contagens e correlações. Ele devolve os resultados de forma estruturada e pode sugerir análises mais profundas ou visualizações.
    *   **`visualization_agent.py` (Agente de Visualização)**: O designer de visualizações. Se a análise sugere a criação de um gráfico, este agente entra em ação. Ele recebe os dados analisados e gera a especificação para um gráfico relevante (usando Vega-Lite), escolhendo o melhor tipo de visualização para os dados.
    *   **`narrative_agent.py` (Agente de Narrativa)**: O contador de histórias. Este é o agente final no fluxo. Ele reúne a pergunta original, os resultados da análise estatística e os gráficos gerados para escrever um relatório final coeso, claro e em português, explicando os insights encontrados.

Esse fluxo de trabalho sequencial e especializado permite que o sistema decomponha problemas complexos, aplique a "ferramenta" de IA correta para cada tarefa e sintetize as informações em uma resposta final de alta qualidade para o usuário.

## Requisitos

- Python 3.8+
- PostgreSQL
- Credenciais da API Google Gemini

## Instalação

1.  **Clone o repositório:**
    ```bash
    git clone https://github.com/seu-usuario/enem-ai-analyst.git
    cd enem-ai-analyst
    ```

2.  **Instale o Poetry:**
    Este projeto utiliza [Poetry](https://python-poetry.org/) para gerenciamento de dependências. Se você ainda não o tem instalado, siga as [instruções oficiais de instalação](https://python-poetry.org/docs/#installation).

3.  **Instale as dependências:**
    Com o Poetry instalado, execute o seguinte comando na raiz do projeto para instalar as dependências:
    ```bash
    poetry install
    ```

4.  **Configure as variáveis de ambiente:**
    Copie o arquivo `.env.example` para `.env` e preencha com suas credenciais e configurações.

5.  **Execute o aplicativo:**
    Para iniciar o aplicativo Streamlit, use o Poetry para executá-lo dentro do ambiente virtual gerenciado:
    ```bash
    poetry run streamlit run streamlit_app.py
    ```

## Estrutura do Projeto

A estrutura de diretórios do projeto foi organizada para separar claramente as responsabilidades, facilitando a manutenção e o desenvolvimento.

```
enem-ai-analyst
├── data
├── deployment
├── docker-compose.yml
├── Dockerfile
├── docs
│   ├── enem-ai-analyst-frd-v1.md
│   └── enem-ai-analyst-prd-v1.md
├── enem_ai_analyst
│   ├── __init__.py
│   ├── agent.py
│   ├── sub_agents
│   │   ├── __init__.py
│   │   ├── analysis_agent.py
│   │   ├── data_agent.py
│   │   ├── narrative_agent.py
│   │   └── visualization_agent.py
│   └── tools
│       ├── __init__.py
│       ├── chart_helpers.py
│       ├── chart_validation.py
│       ├── chart.py
│       └── postgres_mcp.py
├── env.example
├── eval
│   ├── data
│   │   └── data_agent_evalset.json
│   └── test_eval.py
├── poetry.lock
├── pyproject.toml
├── README.md
├── streamlit_app.py
└── tests
```

**Principais Diretórios e Arquivos:**

*   `enem_ai_analyst/`: O coração da aplicação, contendo todo o código-fonte Python.
    *   `agent.py`: Define o **Agente Orquestrador**. Ele é o ponto de entrada para o sistema de IA, recebendo a pergunta do usuário e gerenciando o fluxo de trabalho entre os agentes especialistas.
    *   `sub_agents/`: Contém os **Agentes Especialistas**, cada um com uma função bem definida:
        *   `data_agent.py`: Responsável por interagir com o banco de dados. Ele traduz a linguagem natural em consultas SQL.
        *   `analysis_agent.py`: Realiza análises estatísticas nos dados retornados pelo `data_agent`.
        *   `visualization_agent.py`: Cria as especificações para os gráficos (em formato Vega-Lite) com base na análise.
        *   `narrative_agent.py`: Compila todas as informações (análise, gráficos) em um relatório final coeso e em português.
    *   `tools/`: Ferramentas auxiliares que os agentes utilizam para realizar suas tarefas, como `postgres_mcp.py` para a conexão com o banco de dados e `chart_validation.py` para validar os gráficos.
*   `streamlit_app.py`: O ponto de entrada da interface web. Este script usa a biblioteca Streamlit para criar a página, capturar a pergunta do usuário e chamar o Agente Orquestrador.
*   `Dockerfile` e `docker-compose.yml`: Arquivos de configuração para containerização. Eles permitem que a aplicação e seus serviços (como o banco de dados PostgreSQL) sejam executados de forma isolada e consistente em qualquer ambiente com Docker.
*   `docs/`: Armazena a documentação de planejamento do projeto, como o Documento de Requisitos do Produto (PRD) e Funcionais (FRD).
*   `data/`: Diretório destinado a armazenar dados brutos ou processados, como arquivos CSV do ENEM ou do Censo Escolar que podem ser usados para popular o banco de dados.
*   `eval/`: Contém scripts e conjuntos de dados (`evalset`) para avaliar a performance e a precisão dos agentes de IA.
*   `tests/`: Diretório para testes automatizados, garantindo a qualidade e a estabilidade do código.
*   `pyproject.toml` e `poetry.lock`: Arquivos de gerenciamento de dependências do Poetry. Eles definem as bibliotecas necessárias para o projeto e travam suas versões para garantir a reprodutibilidade do ambiente.
*   `env.example`: Um modelo para o arquivo `.env`, que deve ser criado para armazenar variáveis de ambiente sensíveis, como chaves de API e credenciais do banco de dados.

## Contribuindo

Contribuições são bem-vindas! Por favor, sinta-se à vontade para enviar um Pull Request.

## Licença

Este projeto está licenciado sob a licença MIT - veja o arquivo LICENSE para detalhes.