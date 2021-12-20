-- NOTE:  you will need to create users in Azure Active Directory
-- for this demo to work.  They can be regular users in the free tier.
-- Change the domain to match yours.

-- Create Justine login and user and make her db_owner
CREATE USER [justine@feaselklgmail.onmicrosoft.com] FROM EXTERNAL PROVIDER;
EXEC sp_addrolemember 'db_owner', 'justine@feaselklgmail.onmicrosoft.com';

-- Have Justine grant rights to Alicia:  grant, revoke, deny on tables
-- After each operation, try a query as Alicia
GRANT SELECT ON dbo.People TO [alicia@feaselklgmail.onmicrosoft.com]
REVOKE SELECT ON dbo.People TO [alicia@feaselklgmail.onmicrosoft.com]
GRANT SELECT ON dbo.TeamsFranchises TO [alicia@feaselklgmail.onmicrosoft.com]
DENY SELECT ON dbo.TeamsFranchises(franchName) TO [alicia@feaselklgmail.onmicrosoft.com]

-- Queries to run as Alicia:
SELECT TOP(100) * FROM dbo.People;
SELECT * FROM dbo.TeamsFranchises;
SELECT franchID, active, NAassoc FROM dbo.TeamsFranchises;
