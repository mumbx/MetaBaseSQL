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

--qual as equipes que mais venceram em interlagos?
SELECT 

	CR.name as Montadora
    ,count(positionOrder) as "Total de vitorias"
	,CASE
    WHEN CI.name = 'Autódromo José Carlos Pace' THEN 'Autódromo de Interlagos'
    END as "Pista"
    
FROM 
	Resultados R 
    JOIN Construtores CR    
    ON CR.constructorId = R.constructorId
    JOIN Corridas C 
    ON C.raceId = R.raceId
    JOIN Circuitos CI 
    ON CI.circuitid = C.circuitID
WHERE
	CI.circuitid = 18
GROUP BY
	CR.name
ORDER BY 2 DESC
LIMIT 5

--algum piloto já largou em último e conseguiu ganhar a corrida?
SELECT 
	concat(forename, ' ', surname) as 'Nome do piloto',
    C.year as Ano,
    C.name as "Nome do Premio"

FROM 
	pilotos P
    JOIN Resultados R
	ON R.driverId = P.driverId	
    JOIN Corridas C 
    ON C.raceId = R.raceId
WHERE 
	grid >= 20 AND positionOrder =1

--quais equipes mais pontuaram no mesmo premio?
SELECT	
	C.year as Ano,
	CR.name as Montadora,
    sum(R.points) as Pontos 
    
FROM 
	Resultados R 
    JOIN Construtores CR    
    ON CR.constructorId = R.constructorId
    JOIN Corridas C 
    ON C.raceId = R.raceId
    JOIN Circuitos CI 
    ON CI.circuitid = C.circuitID
GROUP BY
	CR.name, C.year

ORDER BY 3 DESC
LIMIT 5


SELECT	
	C.Year AS Ano,
	CONCAT(forename, ' ', surname) AS 'Nome do piloto',
    SUM(r.points) AS 'Total de pontos'   
FROM 
	Resultados R 
    JOIN Construtores CR    
    ON CR.constructorId = R.constructorId
    JOIN Corridas C 
    ON C.raceId = R.raceId
    JOIN Circuitos CI 
    ON CI.circuitid = C.circuitID
    JOIN Pilotos P
    ON P.driverId = R.driverId
GROUP BY CONCAT(forename, ' ', surname), C.YEAR

ORDER BY 3 DESC
