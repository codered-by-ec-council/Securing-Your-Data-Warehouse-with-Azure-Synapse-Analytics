-- NOTE:  you will need to create users in Azure Active Directory
-- for this demo to work.  They can be regular users in the free tier.
-- Change the domain to match yours.
CREATE USER [alicia@feaselklgmail.onmicrosoft.com] FROM EXTERNAL PROVIDER;
GRANT SELECT ON dbo.People TO [alicia@feaselklgmail.onmicrosoft.com]

-- Now open the Dynamic Data Masking menu and add a mask on dbo.People for birthYear and birthCity.
-- Log in as Alicia and run the following query:
SELECT TOP(100) * FROM dbo.People;