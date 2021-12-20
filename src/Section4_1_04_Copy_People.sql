COPY INTO dbo.People
(playerID 1, birthYear 2, birthMonth 3, birthDay 4, birthCountry 5, birthState 6, birthCity 7, deathYear 8, deathMonth 9, deathDay 10, deathCountry 11, deathState 12, deathCity 13, nameFirst 14, nameLast 15, nameGiven 16, weight 17, height 18, bats 19, throws 20, debut 21, finalGame 22, retroID 23, bbrefID 24)
FROM 'https://bridadlskf20211129.dfs.core.windows.net/synapse/import/dbo.People.parquet'
WITH
(
	FILE_TYPE = 'PARQUET'
	,MAXERRORS = 0
)
GO
