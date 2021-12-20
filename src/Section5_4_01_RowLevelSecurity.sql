USE BRIserverless
GO
DROP VIEW IF EXISTS dbo.Pitching;
GO
CREATE VIEW dbo.Pitching AS
SELECT
    p.*
FROM
    OPENROWSET(
        BULK 'https://bridadlskf20211129.dfs.core.windows.net/synapse/import/dbo.Pitching.parquet',
        FORMAT = 'PARQUET'
    ) AS p
GO
CREATE ROLE ATLanalysts;
CREATE ROLE KCAanalysts;
ALTER ROLE KCAanalysts ADD MEMBER [alicia@feaselklgmail.onmicrosoft.com]
GO
ALTER VIEW dbo.Pitching AS
SELECT *
FROM OPENROWSET(
	BULK 'https://bridadlskf20211129.dfs.core.windows.net/synapse/import/dbo.Pitching.parquet',
	FORMAT = 'Parquet') AS p
WHERE
	SUSER_SNAME() = 'justine@feaselklgmail.onmicrosoft.com'
	OR ( IS_ROLEMEMBER('ATLanalysts', SUSER_SNAME()) = 1
		AND teamID = 'ATL')
	OR ( IS_ROLEMEMBER('KCAanalysts', SUSER_SNAME()) = 1
		AND teamID = 'KCA')
	OR ( IS_ROLEMEMBER('NYYanalysts', SUSER_SNAME()) = 1
		AND teamID = 'NYY')
GO
CREATE OR ALTER FUNCTION dbo.TeamAnalyst(@teamID VARCHAR(3))
RETURNS TABLE
RETURN (
    SELECT condition = 1
    WHERE
        SUSER_SNAME() = 'justine@feaselklgmail.onmicrosoft.com'
        OR ( IS_ROLEMEMBER('ATLanalysts', SUSER_SNAME()) = 1
            AND @teamID = 'ATL')
        OR ( IS_ROLEMEMBER('KCAanalysts', SUSER_SNAME()) = 1
            AND @teamID = 'KCA')
        OR ( IS_ROLEMEMBER('NYYanalysts', SUSER_SNAME()) = 1
            AND @teamID = 'NYY')
);
GO
ALTER VIEW dbo.Pitching AS
SELECT p.*
FROM OPENROWSET(
	BULK 'https://bridadlskf20211129.dfs.core.windows.net/synapse/import/dbo.Pitching.parquet',
	FORMAT = 'Parquet') AS p
    CROSS APPLY dbo.TeamAnalyst(p.teamID)
GO

-- Queries to try as Alicia and Justine
SELECT DISTINCT teamID FROM dbo.Pitching;
SELECT * FROM dbo.Pitching WHERE teamid = 'SEA' and yearid = 1999