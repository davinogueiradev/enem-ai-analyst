# ENEM-AI Analyst

Uma plataforma de análise de dados educacionais brasileiros que utiliza inteligência artificial para permitir consultas em linguagem natural sobre dados do ENEM e do Censo Escolar.

## Sobre o Projeto

O ENEM-AI Analyst utiliza um sistema multi-agente baseado no Google Agent Development Kit (ADK) para processar consultas em linguagem natural, gerar visualizações e fornecer insights sobre dados educacionais brasileiros.

## Características Principais

- **Interface Conversacional**: Faça perguntas em português natural e obtenha respostas claras e concisas.
- **Visualizações Inteligentes**: Receba gráficos e tabelas adequados ao tipo de pergunta e dados.
- **Análise Multi-Ano**: Compare dados ao longo de diferentes anos do ENEM.
- **Correlações entre Fontes**: Descubra relações entre infraestrutura escolar (Censo) e desempenho (ENEM).
- **Transparência**: Veja o SQL gerado para cada consulta.

## Requisitos

- Python 3.8+
- PostgreSQL
- Credenciais da API Google Gemini

## Instalação

1. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/enem-ai-analyst.git
cd enem-ai-analyst
```

2. Instale as dependências:
```bash
pip install -r requirements.txt
```

3. Configure as variáveis de ambiente (copie o arquivo .env.example para .env e edite conforme necessário).

4. Execute o aplicativo:
```bash
python -m enem-ai-analyst.app
```

## Estrutura do Projeto

```
enem-ai-analyst/
├── agents/              # Sistema multi-agente (Google ADK)
│   ├── __init__.py
│   ├── base.py          # Classe base para agentes
│   ├── orchestrator.py  # Agente orquestrador
│   ├── data_agent.py    # Agente de dados (NL → SQL)
│   ├── analysis_agent.py # Agente de análise estatística
│   ├── visualization_agent.py # Agente de visualização
│   ├── factory.py       # Fábrica de agentes
│   ├── main.py          # Ponto de entrada principal
│   └── tools/           # Ferramentas utilizadas pelos agentes
│       ├── __init__.py
│       └── database.py  # Ferramenta de acesso ao banco de dados
├── frontend/           # Interface do usuário
│   ├── __init__.py
│   └── streamlit_app.py # Aplicativo Streamlit
├── app.py              # Arquivo principal
└── requirements.txt    # Dependências do projeto
```

## Contribuindo

Contribuições são bem-vindas! Por favor, sinta-se à vontade para enviar um Pull Request.

## Licença

Este projeto está licenciado sob a licença MIT - veja o arquivo LICENSE para detalhes.