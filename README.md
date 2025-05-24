# T3 Sistemas Digitais - Múltiplos Domínios de Relógio 🕒

## 🎯 Objetivo

Exercitar a **integração de componentes com múltiplos domínios de relógio** em um mesmo sistema digital, utilizando clocks derivados e comunicação entre módulos operando em frequências diferentes.

---

## 🧩 Visão Geral do Projeto

O projeto é composto por três módulos principais:

- 🔄 **Deserializador** – opera a 100 kHz, junta 8 bits para formar um byte que será enviado para a Fila.
- 🧱 **Fila (Stack LIFO)** – opera a 10 kHz, recebe bytes do Deserializador e armazena eles em uma fila de até 8 bytes.
- 🔧 **Módulo Top** – recebe um clock de 1 MHz e gera dois clocks derivados (100 kHz e 10 kHz), além de interligar os módulos.
