# AI Data Analyst (Analista de Dados com IA)

O **AI Data Analyst** (anteriormente ENEM-AI Analyst) é uma plataforma poderosa e flexível que utiliza inteligência artificial para permitir que usuários realizem análises de dados e obtenham insights através de consultas em linguagem natural. Embora inicialmente focado em dados educacionais brasileiros (ENEM, Censo Escolar), a plataforma evoluiu para se tornar uma ferramenta genérica de análise de dados, capaz de trabalhar com uma ampla variedade de conjuntos de dados.

## Sobre o Projeto

O AI Data Analyst emprega um sofisticado sistema multi-agente, construído com o Google Agent Development Kit (ADK), para processar consultas em linguagem natural, conectar-se às suas fontes de dados, gerar visualizações e fornecer narrativas perspicazes. O sistema é projetado para ser intuitivo, permitindo que os usuários façam perguntas complexas sobre seus dados sem a necessidade de escrever código ou SQL.

## Características Principais

-   **Conectividade Versátil com Dados**: Conecte-se aos seus bancos de dados existentes (ex: PostgreSQL) e analise seus próprios dados.
-   **Interface Conversacional**: Faça perguntas em linguagem natural (inicialmente em português, com potencial para outros idiomas) e receba respostas claras e concisas.
-   **Visualizações Inteligentes**: Gera automaticamente gráficos e tabelas apropriados para ilustrar os dados e insights com base em suas consultas.
-   **Configurações Salvas**: Salve de forma segura as configurações de conexão do banco de dados para acesso rápido e fácil em sessões futuras.
-   **Histórico de Conversas**: Acompanhe suas análises salvando conversas inteiras, permitindo revisitar perguntas e insights anteriores.
-   **Análise Multi-Fonte**: Capaz de realizar análises que correlacionam dados de diferentes tabelas ou mesmo diferentes fontes de dados, dependendo da configuração. (Anteriormente focado em ENEM/Censo Escolar, agora generalizado).

## Como Funciona: Uma Arquitetura Multi-Agente

O coração do AI Data Analyst é um sistema de múltiplos agentes de IA, orquestrado para responder a perguntas complexas de forma colaborativa. Cada agente é um especialista com uma função específica, garantindo que cada etapa do processo de análise seja tratada com precisão.

A arquitetura é definida principalmente no arquivo `ai_data_analyst/agent.py` (que pode ser futuramente renomeado para `main_agent.py`) e no diretório `ai_data_analyst/sub_agents/`.

1.  **Agente Orquestrador (`main_agent.py`)**: Este é o "maestro" do sistema. Ele recebe a pergunta do usuário em linguagem natural e interage com o Agente de Planejamento para definir um plano de ação. Em seguida, coordena o trabalho dos outros agentes especialistas para executar esse plano. Ele não responde diretamente, mas segue o plano gerado para garantir que a resposta final seja completa e precisa.

2.  **Agente de Planejamento (`sub_agents/planner_agent.py`)**: Este agente é o estrategista. Ele recebe a pergunta do usuário do Agente Orquestrador e a decompõe em um plano JSON estruturado, passo a passo. Cada passo especifica qual agente especialista deve ser acionado e qual instrução deve seguir. Sua principal responsabilidade é garantir que as agregações e comparações ocorram dentro do banco de dados para otimizar o desempenho e evitar problemas de memória.

3.  **Agentes Especialistas (`sub_agents/`)**: São as ferramentas que o Orquestrador utiliza, seguindo o plano do Agente de Planejamento. Cada um é um LLM com um prompt de sistema especializado:
    *   **`data_agent.py` (Agente de Dados)**: O engenheiro de dados. Sua função é traduzir a instrução do plano (originalmente derivada da pergunta do usuário) em uma consulta SQL segura e eficiente, extrair os dados do banco de dados conectado e entregá-los em um formato limpo (JSON).
    *   **`analysis_agent.py` (Agente de Análise)**: O estatístico. Ele recebe os dados brutos do Agente de Dados e realiza análises descritivas, como médias, contagens e correlações, conforme instruído pelo plano. Ele devolve os resultados de forma estruturada.
    *   **`visualization_agent.py` (Agente de Visualização)**: O designer de visualizações. Se o plano inclui a criação de um gráfico, este agente entra em ação. Ele recebe os dados analisados e gera a especificação para um gráfico relevante (usando Vega-Lite), escolhendo o melhor tipo de visualização para os dados.
    *   **`narrative_agent.py` (Agente de Narrativa)**: O contador de histórias. Este é o agente final no fluxo. Ele reúne a pergunta original, os resultados da análise estatística e os gráficos gerados para escrever um relatório final coeso, claro e no idioma solicitado (ex: português), explicando os insights encontrados, tudo de acordo com as diretrizes do plano.

Esse fluxo de trabalho, agora guiado por um plano explícito, permite que o sistema decomponha problemas complexos de forma mais estruturada, aplique a "ferramenta" de IA correta para cada tarefa e sintetize as informações em uma resposta final de alta qualidade para o usuário.

## Gerenciando Seus Dados e Sessões

O AI Data Analyst é projetado para tornar seu fluxo de trabalho de análise de dados o mais simples possível:

*   **Configuração do Banco de Dados**:
    *   Você pode configurar facilmente conexões com seus bancos de dados através da interface da aplicação.
    *   Essas configurações (ex: host, porta, nome de usuário, nome do banco de dados) podem ser salvas de forma segura, para que você não precise inseri-las novamente a cada sessão. *Detalhes sobre onde são armazenadas (ex: arquivo local, variáveis de ambiente) devem ser claros para o usuário para segurança e gerenciamento.*
*   **Histórico de Conversas e Análises**:
    *   Todas as interações, incluindo suas perguntas, os dados recuperados e os insights gerados, podem ser salvos.
    *   Isso permite que você construa uma base de conhecimento de suas análises, revisite descobertas e compartilhe resultados. *Especifique como e onde as conversas são salvas (ex: arquivos locais, uma tabela de banco de dados dedicada).*

## Requisitos

-   Python 3.8+
-   Um banco de dados suportado (ex: PostgreSQL)
-   Credenciais da API Google Gemini (ou outras credenciais de provedor LLM, conforme configurado)

## Instalação

1.  **Clone o repositório:**
    ```bash
    git clone https://github.com/seu-usuario/ai-data-analyst.git # Substitua pela URL real do novo repositório, se alterada
    cd ai-data-analyst
    ```

2.  **Instale o Poetry:**
    Este projeto utiliza [Poetry](https://python-poetry.org/) para gerenciamento de dependências. Se você ainda não o tem instalado, siga as [instruções oficiais de instalação](https://python-poetry.org/docs/#installation).

3.  **Instale as dependências:**
    Com o Poetry instalado, execute o seguinte comando na raiz do projeto para instalar as dependências:
    ```bash
    poetry install
    ```

4.  **Configure as variáveis de ambiente:**
    Copie o arquivo `.env.example` para `.env` e preencha com suas credenciais e configurações (chaves de API, detalhes de conexão de banco de dados padrão, se houver).

5.  **Execute o aplicativo:**
    Para iniciar o aplicativo Streamlit, use o Poetry para executá-lo dentro do ambiente virtual gerenciado:
    ```bash
    poetry run streamlit run streamlit_app.py
    ```

## Estrutura do Projeto

A estrutura de diretórios do projeto foi organizada para separar claramente as responsabilidades, facilitando a manutenção e o desenvolvimento. O diretório principal da aplicação foi renomeado de `enem_ai_analyst` para `ai_data_analyst`.

```
ai-data-analyst  # Ou o nome escolhido para o projeto
├── data                    # Dados de exemplo, dados do usuário (se aplicável e seguro)
├── deployment              # Scripts e configurações de implantação
├── docker-compose.yml
├── Dockerfile
├── docs
│   └── ai-data-analyst-prd-v1.md # PRD atualizado
├── ai_data_analyst         # Pacote Python principal da aplicação
│   ├── __init__.py
│   ├── main_agent.py       # Anteriormente agent.py - Orquestrador
│   ├── sub_agents          # Agentes especialistas
│   │   ├── __init__.py
│   │   ├── analysis_agent.py
│   │   ├── data_agent.py
│   │   ├── narrative_agent.py
│   │   ├── planner_agent.py
│   │   └── visualization_agent.py
│   └── tools               # Utilitários auxiliares para os agentes
│       ├── __init__.py
│       ├── chart_helpers.py
│       ├── chart_validation.py
│       ├── chart.py
│       └── db_connector.py   # Conector de banco de dados generalizado
├── .env.example
├── saved_configs           # Diretório para configurações de banco de dados salvas (exemplo)
├── saved_chats             # Diretório para históricos de conversas salvos (exemplo)
├── eval                    # Scripts e conjuntos de dados para avaliação
│   ├── data
│   └── test_eval.py
├── poetry.lock
├── pyproject.toml
├── README.md
├── streamlit_app.py
└── tests                   # Testes automatizados
```

**Principais Diretórios e Arquivos (Pós-Refatoração):**

*   `ai_data_analyst/`: O código-fonte Python principal.
    *   `main_agent.py`: O Agente Orquestrador.
    *   `sub_agents/`: Agentes especialistas e o Agente de Planejamento.
    *   `tools/`: Utilitários, incluindo um `db_connector.py` generalizado.
*   `streamlit_app.py`: O ponto de entrada da interface web Streamlit.
*   `saved_configs/`: (Proposto) Diretório para armazenar configurações de conexão de banco de dados salvas, possivelmente criptografadas ou gerenciadas pelo usuário.
*   `saved_chats/`: (Proposto) Diretório para armazenar históricos de conversas salvos, talvez como arquivos JSON ou texto.
*   `Dockerfile`, `docker-compose.yml`: Para conteinerização.
*   `docs/`: Documentação do projeto. (O conteúdo existente como PRD/FRD pode precisar de atualização para refletir o escopo genérico).
*   `data/`: Para conjuntos de dados de exemplo ou dados específicos do usuário (manusear com cuidado em relação à privacidade).
*   `eval/`: Para avaliação de desempenho dos agentes de IA.
*   `tests/`: Testes automatizados.
*   `pyproject.toml` e `poetry.lock`: Arquivos de gerenciamento de dependências do Poetry.
*   `.env.example`: Um modelo para o arquivo `.env`, que deve ser criado para armazenar variáveis de ambiente sensíveis.

## Contribuindo

Contribuições são bem-vindas! Por favor, sinta-se à vontade para enviar um Pull Request.

## Licença

Este projeto está licenciado sob a licença MIT - veja o arquivo LICENSE para detalhes.