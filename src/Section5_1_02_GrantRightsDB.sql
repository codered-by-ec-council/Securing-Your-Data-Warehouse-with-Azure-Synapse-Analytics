USE BRIServerless
GO
CREATE USER [alicia@feaselklgmail.onmicrosoft.com] FROM LOGIN [alicia@feaselklgmail.onmicrosoft.com]
GO
ALTER ROLE db_datareader ADD MEMBER [alicia@feaselklgmail.onmicrosoft.com]
GO