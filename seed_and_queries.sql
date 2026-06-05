-- ==========================================================================================
-- PROJETO CHRONOS DTN - INSERÇÃO DE DADOS, ANÁLISES E BLOCOS DE EXECUÇÃO PL/SQL
-- DESENVOLVIDO EM CONFORMIDADE COM AS DIRETRIZES DA BANCA EXAMINADORA
-- ==========================================================================================

-- ------------------------------------------------------------------------------------------
-- 1. INSERÇÃO DOS 80 REGISTROS DE TESTE (POPULAÇÃO DO ECOSSISTEMA FINANCEIRO)
-- ------------------------------------------------------------------------------------------

-- Carga inicial para a tabela de Registro de Nós (5 Registros de Nós Geográficos/Espaciais)
INSERT INTO T_CDTN_NODE_REGISTRY (name, location, network_address) 
VALUES ('Terrestrial-Gateway-01', 'EARTH_KSC', '192.168.1.100'); -- Nó terrestre no Kennedy Space Center.
INSERT INTO T_CDTN_NODE_REGISTRY (name, location, network_address) 
VALUES ('Lunar-Gateway-Alpha', 'LUNAR_SOUTH_POLE', '10.0.1.10'); -- Nó lunar no Polo Sul (sujeito a 56us/dia drift).
INSERT INTO T_CDTN_NODE_REGISTRY (name, location, network_address) 
VALUES ('Lunar-Gateway-Beta', 'LUNAR_EQUATOR', '10.0.1.20'); -- Segundo nó lunar operacional na linha do equador.
INSERT INTO T_CDTN_NODE_REGISTRY (name, location, network_address) 
VALUES ('Lunar-Orbiter-Satt-1', 'LUNAR_ORBIT', '10.0.2.1'); -- Satélite de retransmissão orbital para contornar a sombra de rádio.
INSERT INTO T_CDTN_NODE_REGISTRY (name, location, network_address) 
VALUES ('Lunar-Orbiter-Satt-2', 'LUNAR_ORBIT', '10.0.2.2'); -- Satélite reserva para mitigação de falhas físicas de uplink.

-- Carga inicial para a tabela de Saldos de Ativos (10 Registros controlando liquidez)
INSERT INTO T_CDTN_ASSET_BALANCES (id_node, symbol, balance) VALUES (1, 'USDC', 10000000.000000); -- Terra possui grande liquidez de USDC.
INSERT INTO T_CDTN_ASSET_BALANCES (id_node, symbol, balance) VALUES (1, 'USDT', 5000000.000000); -- Liquidez terrestre de USDT.
INSERT INTO T_CDTN_ASSET_BALANCES (id_node, symbol, balance) VALUES (2, 'USDC', 50000.000000); -- Nó Lunar Alpha iniciando com saldo regulatório.
INSERT INTO T_CDTN_ASSET_BALANCES (id_node, symbol, balance) VALUES (2, 'USDT', 25000.000000); -- Liquidez de USDT no Polo Sul Lunar.
INSERT INTO T_CDTN_ASSET_BALANCES (id_node, symbol, balance) VALUES (3, 'USDC', 75000.000000); -- Nó Lunar Beta com saldo USDC ativo.
INSERT INTO T_CDTN_ASSET_BALANCES (id_node, symbol, balance) VALUES (3, 'USDT', 30000.000000); -- Saldo de USDT no equador lunar.
INSERT INTO T_CDTN_ASSET_BALANCES (id_node, symbol, balance) VALUES (4, 'USDC', 10000.000000); -- Satélite Orbiter 1 possui fundos para micro-pedágio de tráfego.
INSERT INTO T_CDTN_ASSET_BALANCES (id_node, symbol, balance) VALUES (4, 'USDT', 5000.000000); -- Liquidez de USDT no Orbiter 1.
INSERT INTO T_CDTN_ASSET_BALANCES (id_node, symbol, balance) VALUES (5, 'USDC', 10000.000000); -- Satélite Orbiter 2 com saldo inicial.
INSERT INTO T_CDTN_ASSET_BALANCES (id_node, symbol, balance) VALUES (5, 'USDT', 5000.000000); -- Saldo de USDT reserva no Orbiter 2.

-- Carga inicial para a tabela de Logs de Atraso de Rede (15 Registros de Telemetria de Delay)
INSERT INTO T_CDTN_DELAY_LOGS (source_node, target_node, latency_ms) VALUES (2, 1, 1280.00); -- Ping direto do Polo Sul à Terra (1.28s).
INSERT INTO T_CDTN_DELAY_LOGS (source_node, target_node, latency_ms) VALUES (3, 1, 1290.00); -- Ping do Equador Lunar à Terra (1.29s).
INSERT INTO T_CDTN_DELAY_LOGS (source_node, target_node, latency_ms) VALUES (4, 1, 1250.00); -- Satélite orbital 1 enviando pacotes à Terra.
INSERT INTO T_CDTN_DELAY_LOGS (source_node, target_node, latency_ms) VALUES (5, 1, 1260.00); -- Satélite orbital 2 enviando pacotes à Terra.
INSERT INTO T_CDTN_DELAY_LOGS (source_node, target_node, latency_ms) VALUES (2, 4, 12.50); -- Latência local na Lua (Polo Sul para Orbiter 1).
INSERT INTO T_CDTN_DELAY_LOGS (source_node, target_node, latency_ms) VALUES (3, 4, 15.20); -- Equador para Orbiter 1.
INSERT INTO T_CDTN_DELAY_LOGS (source_node, target_node, latency_ms) VALUES (2, 5, 14.80); -- Polo Sul para Orbiter 2.
INSERT INTO T_CDTN_DELAY_LOGS (source_node, target_node, latency_ms) VALUES (3, 5, 11.90); -- Equador para Orbiter 2.
INSERT INTO T_CDTN_DELAY_LOGS (source_node, target_node, latency_ms) VALUES (4, 5, 5.00); -- Latência entre satélites na órbita da Lua.
INSERT INTO T_CDTN_DELAY_LOGS (source_node, target_node, latency_ms) VALUES (1, 2, 1282.50); -- Ping Terra para Polo Sul Lunar.
INSERT INTO T_CDTN_DELAY_LOGS (source_node, target_node, latency_ms) VALUES (1, 3, 1289.10); -- Ping Terra para Equador Lunar.
INSERT INTO T_CDTN_DELAY_LOGS (source_node, target_node, latency_ms) VALUES (1, 4, 1248.00); -- Ping Terra para Orbiter 1.
INSERT INTO T_CDTN_DELAY_LOGS (source_node, target_node, latency_ms) VALUES (1, 5, 1255.40); -- Ping Terra para Orbiter 2.
INSERT INTO T_CDTN_DELAY_LOGS (source_node, target_node, latency_ms) VALUES (5, 2, 13.00); -- Orbiter 2 para Polo Sul Lunar.
INSERT INTO T_CDTN_DELAY_LOGS (source_node, target_node, latency_ms) VALUES (5, 3, 14.10); -- Orbiter 2 para Equador Lunar.

-- Carga inicial para a tabela de Rotas Dinâmicas (10 Registros de Topologia ativa)
INSERT INTO T_CDTN_DYNAMIC_ROUTES (source_node, target_node, status, bandwidth_kbps) VALUES (2, 1, 'ACTIVE', 1024.00); -- Rota direta Lunar Alpha -> Terra.
INSERT INTO T_CDTN_DYNAMIC_ROUTES (source_node, target_node, status, bandwidth_kbps) VALUES (3, 1, 'ACTIVE', 1024.00); -- Rota direta Lunar Beta -> Terra.
INSERT INTO T_CDTN_DYNAMIC_ROUTES (source_node, target_node, status, bandwidth_kbps) VALUES (2, 4, 'ACTIVE', 4096.00); -- Polo Sul conectando ao satélite 1.
INSERT INTO T_CDTN_DYNAMIC_ROUTES (source_node, target_node, status, bandwidth_kbps) VALUES (3, 4, 'ACTIVE', 4096.00); -- Equador conectando ao satélite 1.
INSERT INTO T_CDTN_DYNAMIC_ROUTES (source_node, target_node, status, bandwidth_kbps) VALUES (4, 1, 'ACTIVE', 8192.00); -- Link principal satélite 1 -> Terra.
INSERT INTO T_CDTN_DYNAMIC_ROUTES (source_node, target_node, status, bandwidth_kbps) VALUES (2, 5, 'DEGRADED', 512.00); -- Rota degradada por poeira eletrostática para satélite 2.
INSERT INTO T_CDTN_DYNAMIC_ROUTES (source_node, target_node, status, bandwidth_kbps) VALUES (3, 5, 'ACTIVE', 2048.00); -- Equador para satélite 2.
INSERT INTO T_CDTN_DYNAMIC_ROUTES (source_node, target_node, status, bandwidth_kbps) VALUES (5, 1, 'OFFLINE_SHADOW', 0.00); -- Rota satélite 2 -> Terra bloqueada por eclipse lunar.
INSERT INTO T_CDTN_DYNAMIC_ROUTES (source_node, target_node, status, bandwidth_kbps) VALUES (4, 5, 'ACTIVE', 10240.00); -- Canal laser de comunicação inter-satélite.
INSERT INTO T_CDTN_DYNAMIC_ROUTES (source_node, target_node, status, bandwidth_kbps) VALUES (1, 2, 'ACTIVE', 1024.00); -- Uplink Terra -> Lunar Alpha.

-- Carga inicial para a tabela de Buffer de Transações (30 Registros de transações pendentes/processadas)
-- Usaremos datas a partir de 01/Jan/2026 para respeitar a Epoch definida no algoritmo.
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (2, 1, '{"tx_id":101,"asset":"USDC","amount":250.00}', TO_TIMESTAMP('2026-01-05 10:00:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (2, 1, '{"tx_id":102,"asset":"USDC","amount":1500.00}', TO_TIMESTAMP('2026-01-05 10:05:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (3, 1, '{"tx_id":103,"asset":"USDT","amount":500.00}', TO_TIMESTAMP('2026-01-05 10:10:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (3, 1, '{"tx_id":104,"asset":"USDC","amount":75.00}', TO_TIMESTAMP('2026-01-05 10:15:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (2, 1, '{"tx_id":105,"asset":"USDT","amount":2200.00}', TO_TIMESTAMP('2026-01-05 10:20:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (2, 1, '{"tx_id":106,"asset":"USDC","amount":300.00}', TO_TIMESTAMP('2026-01-06 11:00:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (3, 1, '{"tx_id":107,"asset":"USDC","amount":450.00}', TO_TIMESTAMP('2026-01-06 11:05:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (2, 1, '{"tx_id":108,"asset":"USDT","amount":890.00}', TO_TIMESTAMP('2026-01-06 11:10:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (3, 1, '{"tx_id":109,"asset":"USDC","amount":120.00}', TO_TIMESTAMP('2026-01-06 11:15:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (2, 1, '{"tx_id":110,"asset":"USDT","amount":4000.00}', TO_TIMESTAMP('2026-01-06 11:20:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (2, 1, '{"tx_id":111,"asset":"USDC","amount":150.00}', TO_TIMESTAMP('2026-01-07 14:00:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (3, 1, '{"tx_id":112,"asset":"USDC","amount":600.00}', TO_TIMESTAMP('2026-01-07 14:05:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (2, 1, '{"tx_id":113,"asset":"USDT","amount":950.00}', TO_TIMESTAMP('2026-01-07 14:10:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (3, 1, '{"tx_id":114,"asset":"USDC","amount":350.00}', TO_TIMESTAMP('2026-01-07 14:15:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (2, 1, '{"tx_id":115,"asset":"USDT","amount":150.00}', TO_TIMESTAMP('2026-01-07 14:20:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (2, 1, '{"tx_id":116,"asset":"USDC","amount":5000.00}', TO_TIMESTAMP('2026-01-08 16:00:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (3, 1, '{"tx_id":117,"asset":"USDC","amount":2500.00}', TO_TIMESTAMP('2026-01-08 16:05:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (2, 1, '{"tx_id":118,"asset":"USDT","amount":320.00}', TO_TIMESTAMP('2026-01-08 16:10:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (3, 1, '{"tx_id":119,"asset":"USDC","amount":140.00}', TO_TIMESTAMP('2026-01-08 16:15:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (2, 1, '{"tx_id":120,"asset":"USDT","amount":670.00}', TO_TIMESTAMP('2026-01-08 16:20:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (2, 1, '{"tx_id":121,"asset":"USDC","amount":710.00}', TO_TIMESTAMP('2026-01-09 09:00:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (3, 1, '{"tx_id":122,"asset":"USDC","amount":400.00}', TO_TIMESTAMP('2026-01-09 09:05:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (2, 1, '{"tx_id":123,"asset":"USDT","amount":1800.00}', TO_TIMESTAMP('2026-01-09 09:10:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (3, 1, '{"tx_id":124,"asset":"USDC","amount":90.00}', TO_TIMESTAMP('2026-01-09 09:15:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (2, 1, '{"tx_id":125,"asset":"USDT","amount":5000.00}', TO_TIMESTAMP('2026-01-09 09:20:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (2, 1, '{"tx_id":126,"asset":"USDC","amount":330.00}', TO_TIMESTAMP('2026-01-10 12:00:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (3, 1, '{"tx_id":127,"asset":"USDC","amount":850.00}', TO_TIMESTAMP('2026-01-10 12:05:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (2, 1, '{"tx_id":128,"asset":"USDT","amount":210.00}', TO_TIMESTAMP('2026-01-10 12:10:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (3, 1, '{"tx_id":129,"asset":"USDC","amount":75.00}', TO_TIMESTAMP('2026-01-10 12:15:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');
INSERT INTO T_CDTN_TRANSACTION_BUFFER (source_node, target_node, payload, local_timestamp, sync_status) 
VALUES (2, 1, '{"tx_id":130,"asset":"USDT","amount":1100.00}', TO_TIMESTAMP('2026-01-10 12:20:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), 'PENDING');

-- Carga inicial para a tabela de Ledger Sync (10 registros consolidados utilizando o sync do buffer)
-- Para popular esses 10 de teste, faremos inserts manuais diretos que simulam a saída da procedure SP_CORRIGIR_TEMPO_LUNAR.
INSERT INTO T_CDTN_LEDGER_SYNC (id_tx_ref, lunar_timestamp, corrected_timestamp, drift_microseconds)
VALUES (1, TO_TIMESTAMP('2026-01-05 10:00:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), TO_TIMESTAMP('2026-01-05 09:59:59.999776', 'YYYY-MM-DD HH24:MI:SS.FF'), 224); -- 4 dias de drift = 4 * 56 = 224us.
INSERT INTO T_CDTN_LEDGER_SYNC (id_tx_ref, lunar_timestamp, corrected_timestamp, drift_microseconds)
VALUES (2, TO_TIMESTAMP('2026-01-05 10:05:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), TO_TIMESTAMP('2026-01-05 10:04:59.999776', 'YYYY-MM-DD HH24:MI:SS.FF'), 224);
INSERT INTO T_CDTN_LEDGER_SYNC (id_tx_ref, lunar_timestamp, corrected_timestamp, drift_microseconds)
VALUES (3, TO_TIMESTAMP('2026-01-05 10:10:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), TO_TIMESTAMP('2026-01-05 10:09:59.999776', 'YYYY-MM-DD HH24:MI:SS.FF'), 224);
INSERT INTO T_CDTN_LEDGER_SYNC (id_tx_ref, lunar_timestamp, corrected_timestamp, drift_microseconds)
VALUES (4, TO_TIMESTAMP('2026-01-05 10:15:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), TO_TIMESTAMP('2026-01-05 10:14:59.999776', 'YYYY-MM-DD HH24:MI:SS.FF'), 224);
INSERT INTO T_CDTN_LEDGER_SYNC (id_tx_ref, lunar_timestamp, corrected_timestamp, drift_microseconds)
VALUES (5, TO_TIMESTAMP('2026-01-05 10:20:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), TO_TIMESTAMP('2026-01-05 10:19:59.999776', 'YYYY-MM-DD HH24:MI:SS.FF'), 224);
INSERT INTO T_CDTN_LEDGER_SYNC (id_tx_ref, lunar_timestamp, corrected_timestamp, drift_microseconds)
VALUES (6, TO_TIMESTAMP('2026-01-06 11:00:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), TO_TIMESTAMP('2026-01-06 10:59:59.999720', 'YYYY-MM-DD HH24:MI:SS.FF'), 280); -- 5 dias de drift = 5 * 56 = 280us.
INSERT INTO T_CDTN_LEDGER_SYNC (id_tx_ref, lunar_timestamp, corrected_timestamp, drift_microseconds)
VALUES (7, TO_TIMESTAMP('2026-01-06 11:05:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), TO_TIMESTAMP('2026-01-06 11:04:59.999720', 'YYYY-MM-DD HH24:MI:SS.FF'), 280);
INSERT INTO T_CDTN_LEDGER_SYNC (id_tx_ref, lunar_timestamp, corrected_timestamp, drift_microseconds)
VALUES (8, TO_TIMESTAMP('2026-01-06 11:10:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), TO_TIMESTAMP('2026-01-06 11:09:59.999720', 'YYYY-MM-DD HH24:MI:SS.FF'), 280);
INSERT INTO T_CDTN_LEDGER_SYNC (id_tx_ref, lunar_timestamp, corrected_timestamp, drift_microseconds)
VALUES (9, TO_TIMESTAMP('2026-01-06 11:15:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), TO_TIMESTAMP('2026-01-06 11:14:59.999720', 'YYYY-MM-DD HH24:MI:SS.FF'), 280);
INSERT INTO T_CDTN_LEDGER_SYNC (id_tx_ref, lunar_timestamp, corrected_timestamp, drift_microseconds)
VALUES (10, TO_TIMESTAMP('2026-01-06 11:20:00.000000', 'YYYY-MM-DD HH24:MI:SS.FF'), TO_TIMESTAMP('2026-01-06 11:19:59.999720', 'YYYY-MM-DD HH24:MI:SS.FF'), 280);

-- Atualiza o status dessas 10 transações sincronizadas manualmente para evitar processamento duplicado pela API.
UPDATE T_CDTN_TRANSACTION_BUFFER SET sync_status = 'ACKNOWLEDGED' WHERE id_tx IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

-- Confirma fisicamente todas as inserções de dados no banco de dados.
COMMIT;


-- ------------------------------------------------------------------------------------------
-- 2. BLOCOS PL/SQL ANÔNIMOS (6 BLOCOS DEMONSTRANDO CURSORES EXPLICITOS, CONDIÇÕES E REPETIÇÕES)
-- ------------------------------------------------------------------------------------------

-- Bloco 1: Auditoria de Conectividade de Nós (Cursores explícitos, Loops de repetição e Estruturas condicionais).
SET SERVEROUTPUT ON;
DECLARE
    -- Cursor explicito para listar todos os nós cadastrados na topologia.
    CURSOR cur_nodes IS 
        SELECT id_node, name, location FROM T_CDTN_NODE_REGISTRY;
    -- Variável de registro para receber os valores a cada iteração do cursor.
    r_node cur_nodes%ROWTYPE;
    -- Variável contadora para monitorar o andamento.
    v_contador NUMBER := 0;
BEGIN
    -- Exibe cabeçalho informativo no buffer de saída do console.
    DBMS_OUTPUT.PUT_LINE('--- BLOCO PL/SQL 1: AUDITORIA DE NÓS ATIVOS ---');
    -- Abre explicitamente o cursor do sistema de arquivos.
    OPEN cur_nodes;
    -- Loop de repetição padrão para percorrer todos os registros contidos no cursor.
    LOOP
        -- Extrai a linha de dados atual e atribui à variável do tipo rowtype.
        FETCH cur_nodes INTO r_node;
        -- Condicional de parada do loop caso o cursor chegue ao final das linhas de dados.
        EXIT WHEN cur_nodes%NOTFOUND;
        
        -- Incrementa o contador de registros percorridos.
        v_contador := v_contador + 1;
        
        -- Condicional aninhada para emitir mensagens específicas dependendo da localização do gateway.
        IF r_node.location = 'EARTH_KSC' THEN
            DBMS_OUTPUT.PUT_LINE('No: ' || r_node.name || ' [TERRA] - Canal estavel de comunicacao.');
        ELSIF r_node.location LIKE 'LUNAR%' THEN
            DBMS_OUTPUT.PUT_LINE('No: ' || r_node.name || ' [LUA] - Canal sujeito a dilacao de gravidade.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('No: ' || r_node.name || ' [DESCONHECIDO] - Localizacao nao cadastrada.');
        END IF;
    END LOOP;
    -- Fecha explicitamente o cursor liberando os recursos associados do SGA Oracle.
    CLOSE cur_nodes;
    -- Exibe rodapé com a contagem física de nós auditados.
    DBMS_OUTPUT.PUT_LINE('Total de nós mapeados: ' || v_contador);
END;
/

-- Bloco 2: Monitor de Latência Crítica (Cursor explicito com parâmetros, loops WHILE e condicionais).
DECLARE
    -- Cursor explicito parametrizável para monitorar conexões com latência acima do limiar.
    CURSOR cur_latencias (p_limiar NUMBER) IS
        SELECT source_node, target_node, latency_ms FROM T_CDTN_DELAY_LOGS WHERE latency_ms > p_limiar;
    -- Variável local de linha do cursor.
    r_lat cur_latencias%ROWTYPE;
    -- Limiar de latência estipulado para alerta crítico (1000 milissegundos).
    v_limiar_critico NUMBER := 1000.00;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- BLOCO PL/SQL 2: MONITORAÇÃO DE LATÊNCIAS CRÍTICAS ---');
    -- Abre o cursor parametrizado informando o limite crítico de latência.
    OPEN cur_latencias(v_limiar_critico);
    -- Executa o fetch inicial para validar a condição do WHILE subsequente.
    FETCH cur_latencias INTO r_lat;
    -- Loop condicional WHILE simulando varreduras de latência.
    WHILE cur_latencias%FOUND LOOP
        -- Imprime alertas informando os nós envolvidos com alta latência.
        DBMS_OUTPUT.PUT_LINE('ALERTA: Conexao entre No ' || r_lat.source_node || ' e No ' || r_lat.target_node || 
                             ' apresenta latencia de ' || r_lat.latency_ms || ' ms (Critico > 1s).');
        -- Fetcha o próximo registro do cursor para a iteração atual.
        FETCH cur_latencias INTO r_lat;
    END LOOP;
    CLOSE cur_latencias;
END;
/

-- Bloco 3: Processador em Lote de Fila de Transações (Cursor explicito, FOR loop implícito, condicionais).
DECLARE
    -- Variável de controle de status do processador.
    v_proc_status VARCHAR2(100);
    -- Contador de registros atualizados no lote de correção.
    v_atualizados NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- BLOCO PL/SQL 3: EXECUÇÃO AUTOMÁTICA DA PROCEDURE ---');
    -- Utiliza o loop FOR associado diretamente a uma consulta implícita (abre, fecha e descarrega automaticamente).
    FOR r_tx IN (SELECT id_tx, sync_status FROM T_CDTN_TRANSACTION_BUFFER WHERE sync_status = 'PENDING') LOOP
        
        -- Executa a chamada da procedure de correção de tempo relativístico criada no passo anterior.
        SP_CORRIGIR_TEMPO_LUNAR(r_tx.id_tx, v_proc_status);
        
        -- Verifica se o processamento foi executado com sucesso através da variável de status.
        IF v_proc_status = 'SUCCESS' THEN
            v_atualizados := v_atualizados + 1;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Falha no processamento da transacao ID: ' || r_tx.id_tx || ' - Erro: ' || v_proc_status);
        END IF;
        
    END LOOP;
    -- Exibe o total de transações processadas e conciliadas no ledger global.
    DBMS_OUTPUT.PUT_LINE('Total de transacoes liquidadas neste lote: ' || v_atualizados);
END;
/

-- Bloco 4: Auditoria de Saldo de Stablecoins Lunares (Cursor explicito, LOOP simples com EXIT, condicionais).
DECLARE
    -- Cursor explícito para coletar os saldos de stablecoins em nós lunares.
    CURSOR cur_saldos IS 
        SELECT ab.symbol, ab.balance, nr.name 
        FROM T_CDTN_ASSET_BALANCES ab
        JOIN T_CDTN_NODE_REGISTRY nr ON ab.id_node = nr.id_node
        WHERE nr.location LIKE 'LUNAR%';
    -- Variável de linha correspondente ao cursor.
    r_saldo cur_saldos%ROWTYPE;
    -- Limite mínimo recomendado de liquidez local para nós lunares.
    v_limite_minimo CONSTANT NUMBER := 20000.00;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- BLOCO PL/SQL 4: VERIFICAÇÃO DE LIQUIDEZ LUNAR ---');
    OPEN cur_saldos;
    LOOP
        FETCH cur_saldos INTO r_saldo;
        EXIT WHEN cur_saldos%NOTFOUND;
        
        -- Condicional para emitir alertas caso o saldo esteja perigosamente próximo de zero ou abaixo do recomendado.
        IF r_saldo.balance < v_limite_minimo THEN
            DBMS_OUTPUT.PUT_LINE('ALERTA DE LIQUIDEZ: O No ' || r_saldo.name || ' possui apenas ' || 
                                 r_saldo.balance || ' ' || r_saldo.symbol || ' (Abaixo do limite de ' || v_limite_minimo || ').');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Liquidez Saudavel: O No ' || r_saldo.name || ' possui ' || 
                                 r_saldo.balance || ' ' || r_saldo.symbol);
        END IF;
    END LOOP;
    CLOSE cur_saldos;
END;
/

-- Bloco 5: Simulação de Perda de Visada Ótica (Loop de contagem simples FOR, condicionais).
DECLARE
    -- Variável de controle para simular minutos decorridos em sombra orbital.
    v_minutos_sombra NUMBER := 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- BLOCO PL/SQL 5: SIMULAÇÃO DE ORBITA E ENLACE ---');
    -- Loop de repetição FOR para simular a progressão temporal de eclipse.
    FOR i IN 1..v_minutos_sombra LOOP
        -- Condicional que avalia se a rede está degradada de acordo com o minuto simulado.
        IF i <= 3 THEN
            DBMS_OUTPUT.PUT_LINE('Minuto ' || i || ': Enlace degradando. Iniciando contingencia DTN.');
        ELSIF i > 3 AND i <= 8 THEN
            DBMS_OUTPUT.PUT_LINE('Minuto ' || i || ': Sombra orbital completa. Enlace offline. Store-and-Forward ativo.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Minuto ' || i || ': Recuperando visada de sinal. Iniciando handshake.');
        END IF;
    END LOOP;
END;
/

-- Bloco 6: Relatório de Rotas Degradadas (Cursor explicito, LOOP, condicionais).
DECLARE
    -- Cursor explícito para monitorar rotas degradadas ou fora de serviço.
    CURSOR cur_rotas IS
        SELECT source_node, target_node, status, bandwidth_kbps FROM T_CDTN_DYNAMIC_ROUTES;
    r_rota cur_rotas%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- BLOCO PL/SQL 6: RELATÓRIO DE ROTAS DE REDE ---');
    OPEN cur_rotas;
    LOOP
        FETCH cur_rotas INTO r_rota;
        EXIT WHEN cur_rotas%NOTFOUND;
        
        -- Condicional para emitir diagnóstico de rotas.
        IF r_rota.status = 'OFFLINE_SHADOW' THEN
            DBMS_OUTPUT.PUT_LINE('ROTA INATIVA: Conexao entre No ' || r_rota.source_node || ' e No ' || r_rota.target_node || ' indisponivel.');
        ELSIF r_rota.status = 'DEGRADED' THEN
            DBMS_OUTPUT.PUT_LINE('ROTA DEGRADADA: Conexao entre No ' || r_rota.source_node || ' e No ' || r_rota.target_node || 
                                 ' operando a apenas ' || r_rota.bandwidth_kbps || ' kbps.');
        END IF;
    END LOOP;
    CLOSE cur_rotas;
END;
/


-- ------------------------------------------------------------------------------------------
-- 3. RELATÓRIOS ANALÍTICOS COM JOIN (5 RELATÓRIOS COM JOIN PARA EXTRAÇÃO DE MÉTRICAS)
-- ------------------------------------------------------------------------------------------

-- Relatório 1: Detalhamento de Transações Conciliadas com Informações do Nó de Origem e Destino
-- Une dados do ledger sincronizado com o buffer de transações e a tabela de cadastro de nós.
SELECT 
    ls.id_ledger AS "ID Razao",
    tx.id_tx AS "ID Transacao",
    n_src.name AS "Origem",
    n_tgt.name AS "Destino",
    tx.payload AS "Payload Dados",
    ls.lunar_timestamp AS "Hora Local Lua",
    ls.corrected_timestamp AS "Hora Corrigida Terra",
    ls.drift_microseconds AS "Desvio (us)"
FROM T_CDTN_LEDGER_SYNC ls
JOIN T_CDTN_TRANSACTION_BUFFER tx ON ls.id_tx_ref = tx.id_tx
JOIN T_CDTN_NODE_REGISTRY n_src ON tx.source_node = n_src.id_node
JOIN T_CDTN_NODE_REGISTRY n_tgt ON tx.target_node = n_tgt.id_node
ORDER BY ls.corrected_timestamp ASC;

-- Relatório 2: Consolidação Global de Saldos por Localização Física (Terra/Lua/Orbita)
-- Permite que auditores financeiros verifiquem a liquidez das stablecoins dividida por região espacial.
SELECT 
    nr.location AS "Localizacao Espacial",
    ab.symbol AS "Stablecoin",
    SUM(ab.balance) AS "Saldo Consolidado Regional",
    COUNT(nr.id_node) AS "Quantidade de Gateways"
FROM T_CDTN_ASSET_BALANCES ab
JOIN T_CDTN_NODE_REGISTRY nr ON ab.id_node = nr.id_node
GROUP BY nr.location, ab.symbol
ORDER BY nr.location DESC;

-- Relatório 3: Auditoria de Qualidade de Sinal e Latência Espacial de Comunicação
-- Apresenta o log de latência mostrando os nomes textuais dos nós de origem e destino.
SELECT 
    dl.id_delay AS "ID Log",
    n_src.name AS "Gateway Emissor",
    n_tgt.name AS "Gateway Receptor",
    dl.latency_ms AS "Latencia Medida (ms)",
    dl.logged_at AS "Data Coleta"
FROM T_CDTN_DELAY_LOGS dl
JOIN T_CDTN_NODE_REGISTRY n_src ON dl.source_node = n_src.id_node
JOIN T_CDTN_NODE_REGISTRY n_tgt ON dl.target_node = n_tgt.id_node
ORDER BY dl.latency_ms DESC;

-- Relatório 4: Topologia de Rotas Disponíveis e Capacidade de Transmissão de Enlace
-- Cruza a tabela de rotas com a tabela de nós para obter um mapa completo das conexões de rede ativas.
SELECT 
    dr.id_route AS "ID Rota",
    n_src.name AS "No de Origem",
    n_tgt.name AS "No de Destino",
    dr.status AS "Status Enlace",
    dr.bandwidth_kbps AS "Banda Disponivel (kbps)"
FROM T_CDTN_DYNAMIC_ROUTES dr
JOIN T_CDTN_NODE_REGISTRY n_src ON dr.source_node = n_src.id_node
JOIN T_CDTN_NODE_REGISTRY n_tgt ON dr.target_node = n_tgt.id_node
ORDER BY dr.status ASC, dr.bandwidth_kbps DESC;

-- Relatório 5: Diagnóstico de Fila de Transações com Bloqueio de Sincronismo (Buffer Pendente)
-- Identifica quais transações locais estão retidas no buffer esperando janela de upload, com seus nós.
SELECT 
    tx.id_tx AS "ID Bufferizado",
    nr.name AS "No Responsavel",
    nr.location AS "Localizacao Fila",
    tx.local_timestamp AS "Data Geracao Lua",
    tx.sync_status AS "Estado Atual Sinc"
FROM T_CDTN_TRANSACTION_BUFFER tx
JOIN T_CDTN_NODE_REGISTRY nr ON tx.source_node = nr.id_node
WHERE tx.sync_status = 'PENDING'
ORDER BY tx.local_timestamp ASC;
