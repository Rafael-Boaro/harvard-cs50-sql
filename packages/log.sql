-- 1. Descobrir o ID, o conteúdo e o endereço de destino original do pacote enviado pela Anneke.
SELECT * FROM packages WHERE from_address_id = (SELECT id FROM addresses WHERE address = '900 Somerville Avenue');

-- 2. Descobrir o endereço final e o tipo do local onde o pacote foi efetivamente entregue (Drop).
SELECT address, type FROM addresses WHERE id = (
    SELECT address_id FROM scans
    WHERE package_id = (SELECT id FROM packages WHERE from_address_id = (SELECT id FROM addresses WHERE address = '900 Somerville Avenue'))
    AND action = 'Drop'
);


-- 1. Encontrar o pacote misterioso que não possui endereço de remetente (origem nula).
SELECT * FROM packages WHERE from_address_id IS NULL;

-- 2. Encontrar o local exato e o tipo do local onde este pacote foi deixado.
SELECT address, type FROM addresses WHERE id = (
    SELECT address_id FROM scans
    WHERE package_id = (SELECT id FROM packages WHERE from_address_id IS NULL)
    AND action = 'Drop'
);


-- 1. Encontrar o pacote enviado pelo avô a partir do seu endereço (109 Tileston Street).
SELECT * FROM packages WHERE from_address_id = (SELECT id FROM addresses WHERE address = '109 Tileston Street');

-- 2. Identificar qual foi a última ação tomada com este pacote para entender onde ele está (Drop ou Pick).
SELECT action FROM scans WHERE package_id = (
    SELECT id FROM packages WHERE from_address_id = (SELECT id FROM addresses WHERE address = '109 Tileston Street')
) ORDER BY timestamp DESC LIMIT 1;

-- 3. Sabendo que a última ação foi "Pick", descobrir o nome do motorista que está atualmente com o pacote em sua van.
SELECT name FROM drivers WHERE id = (
    SELECT driver_id FROM scans
    WHERE package_id = (SELECT id FROM packages WHERE from_address_id = (SELECT id FROM addresses WHERE address = '109 Tileston Street'))
    ORDER BY timestamp DESC LIMIT 1
);
