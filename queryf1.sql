-- Pitstop de maior duração:
SELECT max(duration) FROM f1.pitstops;

-- Quantas corridas foram realizadas no Brasil entre 1950 e 2019?
select * from corridas where circuitId = 18;

-- Países com maior número de pilotos disputando a fórmula 1.
SELECT max(nationality) FROM pilotos;

-- Quantos circuitos existem em cada país?

SELECT country AS 'country',
count(*) AS 'location'
FROM circuitos
GROUP BY country
ORDER BY count(*) DESC;