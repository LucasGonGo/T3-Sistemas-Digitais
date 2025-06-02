# ⏱️ T3 – Sistemas Digitais: Múltiplos Domínios de Relógio

## 🎯 Objetivo

Este projeto tem como objetivo **exercitar a integração de componentes com múltiplos domínios de relógio** em um mesmo sistema digital. A proposta envolve o uso de **clocks derivados** e a **comunicação entre módulos operando em diferentes frequências**.

---

## 🧩 Visão Geral do Projeto

O sistema é composto por três módulos principais:

- 🔄 **Deserializador**  
  Opera a **100 kHz**, agrupando 8 bits recebidos serialmente e enviando o pacote para a fila.

- 📥 **Fila FIFO**  
  Funciona a **10 kHz**, armazenando até **8 pacotes de 8 bits** enviados pelo deserializador.

- 🔧 **Módulo Top**  
  Recebe um clock base de **1 MHz**, gera os clocks derivados (**100 kHz e 10 kHz**) e interliga os módulos, gerenciando o controle do sistema.

---

## 🛠️ Implementação

A implementação é composta por **4 módulos**, organizados da seguinte forma:

- **3 módulos principais**: Deserializador, Fila FIFO e Módulo Top.
- **1 testbench**: utilizado para validar o funcionamento do sistema.

Todos os arquivos estão localizados na pasta `src/`.

---

## ▶️ Execução do Projeto

Para simular o projeto, recomenda-se o uso das ferramentas **QuestaSim** ou **ModelSim**.

### Passos:

1. Abra o terminal e navegue até a pasta do projeto.
2. Execute o script `sim.do` com o comando da ferramenta:

   ```tcl
   do sim.do
   
3. O script irá compilar os arquivos e abrir a visualização das formas de onda automaticamente.
