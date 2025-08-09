/*
===============================================================
Create Database and Schema
===============================================================
Script Purpose :
       This script creates a new database named 'DataWarehouse' after checking if it arready exists .
       If the database exists , it is droped and recreated . Additionally , the script sats up three schemas .
       within the database : 'broze','silver',and 'gold'

WARNING :
       Running this script will drop the entire 'DataWarehouse' database if it exists.
       All data in the database will be permanently deieted . Proceed with caution 
       and ensure you have proper backups before running this script.
*/
USE master;
GO

-- Drop and recreate the 'DataWarehouse'database 
IF EXISTS (SELECT 1 FROM sys.databases WHERE name ='DataWArehouse')
BEGIN 
     ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
END;
GO 
-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse ;
GO

USE DataWarehouse;
GO

-- Create Schema
CREATE SCHEMA bronze ;
GO
CREATE SCHEMA silver ;
GO
CREATE SCHEMA gold ;
GO
