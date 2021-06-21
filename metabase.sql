-- Maiores velocidades
SELECT construtores.name as Equipe, (max(resultados.fastestLapSpeed)*1.60934) as Velocidade
FROM construtores
JOIN resultados
ON construtores.constructorId = resultados.constructorId
group by construtores.name
having max(resultados.fastestLapSpeed) > 100
order by max(resultados.fastestLapSpeed) DESC limit 5;

-- Top 3 - Equipes que mais venceram
SELECT tabela1.* FROM
(SELECT construtores.name, count(resultados.positionOrder) as vitorias
FROM construtores
LEFT JOIN resultados
on construtores.constructorId=resultados.constructorId AND resultados.positionOrder = 1
GROUP BY construtores.name order by vitorias desc limit 3
) as tabela1;

-- Países com mais pilotos
SELECT max(nationality) as Nacionalidade, count(nationality) as Total FROM pilotos
GROUP BY nationality
LIMIT 3;

-- Pistas com menos voltas
SELECT DISTINCT circuitos.name, circuitos.location, circuitos.country, corridas.year, MAX(resultados.laps) as laps FROM circuitos 
JOIN corridas ON circuitos.circuitId = corridas.circuitId
JOIN resultados ON corridas.raceId = resultados.raceId
GROUP BY corridas.raceId
ORDER BY laps ASC LIMIT 3;

-- Top 3 - Pole position
SELECT tabela1.* FROM
(SELECT concat(pilotos.forename, ' ', pilotos.surname) as piloto, count(resultados.grid) as pole_position
FROM pilotos
LEFT JOIN resultados
on pilotos.driverId=resultados.driverId AND resultados.grid = 1
GROUP BY concat(pilotos.forename, ' ', pilotos.surname) order by pole_position desc limit 3
) as tabela1;

-- Piloto que largou em último e venceu o GP.
SELECT 
	concat(forename, ' ', surname) as 'Piloto',
    C.year as Ano,
    C.name as "Nome do GP"

FROM 
	pilotos P
    JOIN resultados R
	ON R.driverId = P.driverId	
    JOIN corridas C 
    ON C.raceId = R.raceId
WHERE 
	grid >= 20 AND positionOrder =1;

-- Top 3 - Vitórias
SELECT tabela1.* FROM
(SELECT concat(pilotos.forename, ' ', pilotos.surname) as piloto, count(resultados.positionOrder) as vitorias
FROM pilotos
LEFT JOIN resultados
on pilotos.driverId=resultados.driverId AND resultados.positionOrder = 1
GROUP BY concat(pilotos.forename, ' ', pilotos.surname) order by vitorias desc limit 3
) as tabela1;

-- Pilotos mais novos da atual temporada
SELECT concat(forename, ' ', surname) as Piloto, dob as Nascimento, nationality as Nacionalidade 
FROM pilotos ORDER BY dob DESC LIMIT 3;

-- Maior vencedor - Monaco
SELECT concat(pilotos.forename, ' ', pilotos.surname) as Piloto, count(resultados.positionOrder) as Vitórias FROM pilotos 
JOIN resultados
ON resultados.driverId=pilotos.driverId 
JOIN corridas
ON resultados.raceId=corridas.raceId
WHERE corridas.circuitId=6 AND positionOrder=1
GROUP BY pilotos.driverId
ORDER BY Vitórias DESC
LIMIT 1;