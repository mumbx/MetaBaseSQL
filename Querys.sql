-- Piloto mais novo
SELECT * FROM pilotos ORDER BY dob DESC;

-- Piloto com mais pontos
SELECT CONCAT(pilotos.forename, ' ', pilotos.surname) as pilot, SUM(resultados.points) as total_points FROM pilotos INNER JOIN resultados ON pilotos.driverId=resultados.driverId 
GROUP BY pilotos.forename ORDER BY total_points DESC;

-- Pista com menos voltas
SELECT DISTINCT corridas.raceId, corridas.year, circuitos.name, circuitos.location, circuitos.country, MAX(resultados.laps) as laps FROM circuitos 
JOIN corridas ON circuitos.circuitId = corridas.circuitId
JOIN resultados ON corridas.raceId = resultados.raceId
GROUP BY corridas.raceId
ORDER BY laps ASC;

-- Pitstop de maior duração:
SELECT max(duration) FROM f1.pitstops;

-- Quantas corridas foram realizadas no Brasil entre 1950 e 2019?
select * from corridas where circuitId = 18;

-- Países com maior número de pilotos disputando a fórmula 1.
SELECT max(nationality) FROM pilotos;