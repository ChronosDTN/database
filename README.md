# Chronos DTN — Banco de Dados (Oracle SQL + PL/SQL)

> Módulo de banco de dados relacional do gateway financeiro **Chronos DTN**. Contém os scripts de criação do schema Oracle, dados iniciais de seed e as procedures PL/SQL para correção relativística de timestamps cislunar.

---

## 🛰️ Sobre o Módulo

Este repositório centraliza toda a camada de dados do projeto **Chronos DTN**. O modelo relacional foi projetado para suportar as operações financeiras interplanetárias, incluindo:

- Registro e gerenciamento de **gateways/nós** da rede DTN
- **Buffer de transações** em trânsito durante interrupções de sinal
- **Ledger sincronizado** com correção de tempo relativística
- **Telemetria** de atrasos de rede e histórico de roteamento
- **Saldos de ativos digitais** por nó (USDC, USDT)

A procedure `SP_CORRIGIR_TEMPO_LUNAR` é o coração do sistema: aplica a correção de **56 μs/dia** de drift gravitacional acumulado desde a época de sincronização (01-Jan-2026 UTC) sobre os timestamps gerados na superfície lunar.

---

## 🛠️ Tecnologias Utilizadas

| Tecnologia | Versão | Função |
|---|---|---|
| Oracle Database XE | 21c | Sistema gerenciador de banco de dados relacional |
| SQL | ANSI / Oracle dialect | Criação de tabelas, índices e restrições |
| PL/SQL | Oracle 21c | Procedure de correção relativística e lógica transacional |

---

## 📂 Estrutura de Arquivos

```
database/
├── schema.sql              # DDL completo: criação de tabelas, sequences, índices e constraints
└── seed_and_queries.sql    # DML: dados iniciais de seed + queries de exemplo e chamada de procedure
```

### Tabelas do Schema

| Tabela | Descrição |
|---|---|
| `T_CDTN_GATEWAY_NODE` | Cadastro dos nós/gateways da rede DTN (Terra e Lua) |
| `T_CDTN_TRANSACTION_BUFFER` | Buffer de transações retidas durante blecautes de sinal |
| `T_CDTN_LEDGER_SYNC` | Livro-razão com timestamps corrigidos pós-reconciliação |
| `T_CDTN_NETWORK_TELEMETRY` | Telemetria de latência e qualidade de link cislunar |
| `T_CDTN_TOPOLOGY_ROUTE` | Rotas ativas de roteamento de pacotes na topologia DTN |
| `T_CDTN_ASSET_BALANCE` | Saldos de ativos digitais (USDC/USDT) por nó |

---

## ▶️ Como Executar

### Pré-requisitos

- Oracle Database XE 21c em execução localmente ou via Docker (veja o módulo `devops/`)
- Um cliente SQL Oracle: [SQL Developer](https://www.oracle.com/tools/downloads/sqldev-downloads.html), DBeaver ou SQLcl

### 1. Iniciar o Oracle via Docker (recomendado)

```bash
# Na pasta devops/
docker compose up -d
```

Aguarde o container do Oracle subir (~2 minutos na primeira execução).

### 2. Conectar ao banco

Use as credenciais definidas no Docker Compose:

```
Host: localhost
Porta: 1521
SID / Service: CHRONOS_DB
Usuário: system
Senha: ChronosSecurePassword2026
```

### 3. Executar os scripts na ordem correta

```sql
-- 1. Criar as tabelas e estruturas
@schema.sql

-- 2. Inserir dados iniciais e testar a procedure
@seed_and_queries.sql
```

### 4. Testar a correção relativística

```sql
-- Chama a procedure de correção para a transação de ID 1
DECLARE
  v_status VARCHAR2(200);
BEGIN
  SP_CORRIGIR_TEMPO_LUNAR(p_id_tx => 1, p_status => v_status);
  DBMS_OUTPUT.PUT_LINE('Status: ' || v_status);
END;
/

-- Verificar o resultado no ledger
SELECT * FROM T_CDTN_LEDGER_SYNC;
```

**Resultado esperado:** O campo `corrected_timestamp` deve conter o horário ajustado subtraindo os microssegundos de drift acumulados desde 01-Jan-2026.

---

## 🔗 Repositórios do Projeto Chronos DTN

| Módulo | Descrição |
|---|---|
| [backend-java](https://github.com/seu-usuario/chronos-backend-java) | API principal Spring Boot 3 + JWT |
| [backend-dotnet](https://github.com/seu-usuario/chronos-backend-dotnet) | API secundária .NET 8 + EF Core |
| [devops](https://github.com/seu-usuario/chronos-devops) | Docker Compose e Dockerfile |
| [iot-esp32](https://github.com/seu-usuario/chronos-iot-esp32) | Firmware C++ Arduino para ESP32 |
| [mobile-app](https://github.com/seu-usuario/chronos-mobile-app) | App React Native com Expo Router |

---

## 👤 Autores

Projeto desenvolvido para a **Global Solution — FIAP 2026**.
