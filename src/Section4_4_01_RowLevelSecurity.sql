-- Run this part in master!
-- Create a team-specific login
CREATE LOGIN ATLUser WITH PASSWORD = 'AtlantaBraves!'
GO

-- Run the rest of this in briwh!
CREATE USER ATLUser FROM LOGIN ATLUser
GO
-- Grant ATLUser and Alicia read-only rights on the Pitching table.
GRANT SELECT ON dbo.Pitching TO ATLUser, [alicia@feaselklgmail.onmicrosoft.com];
GO
CREATE SCHEMA Security;  
GO
-- Create a function to determine if the current user should see the current row
-- based on this input value.
CREATE FUNCTION Security.TeamPredicate(@teamID AS nvarchar(3))
    RETURNS TABLE  
WITH SCHEMABINDING  
AS  
    RETURN SELECT 1 AS Success
    WHERE @teamID = LEFT(USER_NAME(), 3)
        OR (USER_NAME() = 'alicia@feaselklgmail.onmicrosoft.com' AND @teamID IN (N'TOR', N'SEA', N'KCA'));
GO
-- Create a security policy to tie our function to a given table.
CREATE SECURITY POLICY TeamPolicy
ADD FILTER PREDICATE Security.TeamPredicate(teamID)
ON dbo.Pitching
WITH (STATE = ON);
GO
-- Alicia and ATLUser both need to be able to execute the TeamPredicate function.
GRANT SELECT ON Security.TeamPredicate TO ATLUser, [alicia@feaselklgmail.onmicrosoft.com];
GO

EXECUTE AS USER = 'ATLUser'
SELECT * FROM dbo.Pitching WHERE yearID = 1995;
REVERT

EXECUTE AS USER = 'alicia@feaselklgmail.onmicrosoft.com'
SELECT * FROM dbo.Pitching WHERE yearID = 1995;
REVERT