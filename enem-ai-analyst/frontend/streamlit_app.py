import streamlit as st
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import io
import base64
import time
from typing import Dict, List, Optional, Tuple, Union

# Constantes para estilo
CORES = {
    "azul_primario": "#1E88E5",
    "verde_secundario": "#26A69A",
    "cinza_fundo": "#F5F7F9",
    "branco": "#FFFFFF",
    "azul_claro": "#E3F2FD",
    "cinza_texto": "#424242",
}

# Modelo de dados para mensagens
class Mensagem:
    def __init__(self, texto: str, autor: str, timestamp=None, sql_query=None, visualizacao=None):
        self.texto = texto
        self.autor = autor  # "usuario" ou "agente"
        self.timestamp = timestamp or time.time()
        self.sql_query = sql_query  # Query SQL associada (se for resposta do agente)
        self.visualizacao = visualizacao  # Dados para visualização

# Funções auxiliares para visualizações
def criar_grafico(tipo: str, dados: pd.DataFrame, x: str, y: Union[str, List[str]], 
                  titulo: str = None) -> plt.Figure:
    """Cria uma figura matplotlib baseada no tipo e dados fornecidos."""
    fig, ax = plt.subplots(figsize=(10, 6))

    if tipo == "barra":
        dados.plot(kind="bar", x=x, y=y, ax=ax, color=CORES["azul_primario"])
    elif tipo == "linha":
        dados.plot(kind="line", x=x, y=y, ax=ax, marker='o')
    elif tipo == "dispersao":
        dados.plot(kind="scatter", x=x, y=y, ax=ax, color=CORES["verde_secundario"])
    else:
        # Tipo padrão: barra
        dados.plot(kind="bar", x=x, y=y, ax=ax, color=CORES["azul_primario"])

    if titulo:
        ax.set_title(titulo)

    ax.grid(True, linestyle='--', alpha=0.7)
    plt.tight_layout()

    return fig

def fig_para_base64(fig) -> str:
    """Converte uma figura matplotlib para uma string base64."""
    buf = io.BytesIO()
    fig.savefig(buf, format="png", dpi=100, bbox_inches="tight")
    buf.seek(0)
    img_str = base64.b64encode(buf.read()).decode()
    buf.close()
    return img_str

def formatar_sql(query: str) -> str:
    """Formata uma query SQL para exibição com syntax highlighting."""
    # Na implementação real, isso usaria uma biblioteca para syntax highlighting
    # Para simplicidade, apenas adicionamos alguma formatação básica
    formatted = query.replace("SELECT", "<span style='color: blue; font-weight: bold;'>SELECT</span>")
    formatted = formatted.replace("FROM", "<span style='color: blue; font-weight: bold;'>FROM</span>")
    formatted = formatted.replace("WHERE", "<span style='color: blue; font-weight: bold;'>WHERE</span>")
    formatted = formatted.replace("GROUP BY", "<span style='color: blue; font-weight: bold;'>GROUP BY</span>")
    formatted = formatted.replace("ORDER BY", "<span style='color: blue; font-weight: bold;'>ORDER BY</span>")
    formatted = formatted.replace("JOIN", "<span style='color: blue; font-weight: bold;'>JOIN</span>")
    formatted = formatted.replace("UNION", "<span style='color: blue; font-weight: bold;'>UNION</span>")
    # Adicione mais formatação conforme necessário

    return f"<pre style='background-color: #f0f0f0; padding: 10px; border-radius: 5px;'>{formatted}</pre>"

# Funções de interface
def configurar_pagina():
    """Configura a página inicial do Streamlit com estilo e layout."""
    st.set_page_config(
        page_title="ENEM-AI Analyst",
        page_icon="📊",
        layout="wide"
    )

    # CSS personalizado para melhorar a interface
    st.markdown("""
    <style>
    .main {background-color: #F5F7F9}
    .stTextInput>div>div>input {border-radius: 20px}
    .stButton>button {border-radius: 20px}
    .mensagem-usuario {background-color: #E3F2FD; padding: 10px; border-radius: 15px 15px 0 15px; margin-bottom: 10px}
    .mensagem-agente {background-color: white; padding: 10px; border-radius: 15px 15px 15px 0; margin-bottom: 15px; box-shadow: 0 1px 3px rgba(0,0,0,0.12)}
    .sql-container {margin-top: 10px; margin-bottom: 10px}
    </style>
    """, unsafe_allow_html=True)

    # Cabeçalho
    st.markdown("""
    <h1 style='text-align: center; color: #1E88E5;'>ENEM-AI Analyst</h1>
    <p style='text-align: center; color: #424242; margin-bottom: 30px;'>
        Explore os dados educacionais do Brasil através de perguntas em linguagem natural
    </p>
    """, unsafe_allow_html=True)

def processar_mensagem(mensagem: str) -> Mensagem:
    """Função placeholder para processar mensagem do usuário através dos agentes.

    Em uma implementação real, esta função chamaria os agentes para processar a consulta.
    """
    # Aqui seria o código para chamar o Orchestrator Agent
    # Neste exemplo, simulamos uma resposta
    time.sleep(2)  # Simular processamento

    # Exemplo de resposta simulada
    texto_resposta = f"Aqui está a análise para sua pergunta: '{mensagem}'"

    # Exemplo de consulta SQL que seria gerada pelo Data Agent
    sql_query = """-- Consulta para obter a média de notas de matemática por estado
SELECT 
    SG_UF_PROVA AS estado,
    AVG(NU_NOTA_MT) AS media_matematica
FROM 
    enem_2023
WHERE 
    NU_NOTA_MT IS NOT NULL
GROUP BY 
    SG_UF_PROVA
ORDER BY 
    media_matematica DESC;"""

    # Exemplo de dados para visualização
    dados = pd.DataFrame({
        'estado': ['SP', 'RJ', 'MG', 'RS', 'PR'],
        'media_matematica': [550.2, 530.1, 525.7, 540.3, 535.8]
    })

    # Criar visualização
    fig = criar_grafico("barra", dados, "estado", "media_matematica", 
                      "Média de Notas de Matemática por Estado")

    # Criar objeto de visualização
    visualizacao = {
        "tipo": "barra",
        "figura": fig,
        "figura_base64": fig_para_base64(fig),
        "dados": dados
    }

    return Mensagem(texto_resposta, "agente", sql_query=sql_query, visualizacao=visualizacao)

def exibir_historico(historico: List[Mensagem]):
    """Exibe o histórico de mensagens na interface."""
    for msg in historico:
        if msg.autor == "usuario":
            st.markdown(f"<div class='mensagem-usuario'>{msg.texto}</div>", unsafe_allow_html=True)
        else:  # agente
            with st.container():
                st.markdown(f"<div class='mensagem-agente'>{msg.texto}</div>", unsafe_allow_html=True)

                # Exibir visualização se disponível
                if msg.visualizacao:
                    # Exibir gráfico
                    st.pyplot(msg.visualizacao["figura"])

                    # Botão para download
                    img_str = msg.visualizacao["figura_base64"]
                    href = f"<a href='data:image/png;base64,{img_str}' download='grafico.png'>Baixar Gráfico</a>"
                    st.markdown(href, unsafe_allow_html=True)

                    # Exibir dados em formato tabular
                    with st.expander("Mostrar dados"):
                        st.dataframe(msg.visualizacao["dados"])

                # Botão para mostrar a consulta SQL
                if msg.sql_query:
                    with st.expander("Mostrar Consulta SQL"):
                        st.markdown(formatar_sql(msg.sql_query), unsafe_allow_html=True)

def main():
    """Função principal que executa o aplicativo Streamlit.

    Implementa os requisitos:
    - F01: Interface de Consulta Conversacional
    - F02: Visualização de Dados de Múltiplas Fontes
    - F03: Transparência de Consulta
    """
    configurar_pagina()

    # Inicializar o estado da sessão para o histórico de mensagens
    if 'historico_mensagens' not in st.session_state:
        st.session_state['historico_mensagens'] = []

    # Exibir histórico de mensagens
    exibir_historico(st.session_state['historico_mensagens'])

    # Área para nova consulta
    with st.container():
        col1, col2 = st.columns([6, 1])

        with col1:
            user_input = st.text_input(
                "Digite sua pergunta em português natural:",
                placeholder="Ex: Qual a média de notas de matemática por estado?",
                key="nova_mensagem"
            )

        with col2:
            submitted = st.button("Enviar")

    # Processar nova mensagem
    if (submitted or st.session_state.get('submit_pressed', False)) and user_input:
        # Adicionar mensagem do usuário ao histórico
        mensagem_usuario = Mensagem(user_input, "usuario")
        st.session_state['historico_mensagens'].append(mensagem_usuario)

        # Mostrar indicador de processamento
        with st.spinner("Processando sua consulta..."):
            # Chamar o processador de mensagem (que acionaria os agentes)
            resposta_agente = processar_mensagem(user_input)

        # Adicionar resposta do agente ao histórico
        st.session_state['historico_mensagens'].append(resposta_agente)

        # Limpar campo de entrada
        st.session_state['nova_mensagem'] = ""

        # Recarregar página para exibir nova mensagem
        st.experimental_rerun()

if __name__ == "__main__":
    main()
