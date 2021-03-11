CREATE OR ALTER PROCEDURE ddw1DW.CreateTables
AS
/***************************************************************************************************
File: CreateTables.sql
----------------------------------------------------------------------------------------------------
Procedure:      ddw1DW.CreateTables
Create Date:    2021-03-01 (yyyy-mm-dd)
Author:         Surush Cyrus
Description:    Creates all needed ddw1DW tables  
Call by:        TBD, UI, Add hoc
Steps:          NA
Parameter(s):   None
Usage:          EXEC ddw1DW.CreateTables
****************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)    Author              Comments
------------------- ------------------- ------------------------------------------------------------
****************************************************************************************************/
SET NOCOUNT ON;

DECLARE @ErrorText VARCHAR(MAX),      
        @Message   VARCHAR(255),   
        @StartTime DATETIME,
        @SP        VARCHAR(50)

BEGIN TRY;   
SET @ErrorText = 'Unexpected ERROR in setting the variables!';  

SET @SP = OBJECT_NAME(@@PROCID)
SET @StartTime = GETDATE();    
SET @Message = 'Started SP ' + @SP + ' at ' + FORMAT(@StartTime , 'MM/dd/yyyy HH:mm:ss');  


-------------------------------------------------------------------------------
SET @ErrorText = 'Failed CREATE Table ddw1DW.DimTime.';

IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'ddw1DW.DimTime') AND type in (N'U'))
BEGIN
    SET @Message = 'Table ddw1DW.DimTime already exist, skipping....';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
END
ELSE
BEGIN
    CREATE TABLE ddw1DW.DimTime
    (
        TimeKey int IDENTITY (1, 1) NOT NULL ,
        -- ActualDate datetime NOT NULL ,
        ActualDate DATE NOT NULL ,
        Year int NOT NULL ,
        Quarter int NOT NULL ,
        Month int NOT NULL ,
        Week int NOT NULL ,
        DayofYear int NOT NULL ,
        DayofMonth int NOT NULL ,
        DayofWeek int NOT NULL ,
        IsWeekend bit NOT NULL ,
        Comments varchar(20) NULL ,
        CalendarWeek int NOT NULL ,
        BusinessYearWeek int NOT NULL ,
        LeapYear tinyint NOT NULL,
        CONSTRAINT PK_DimTime_TimeKey PRIMARY KEY CLUSTERED (TimeKey)
    );
    SET @Message = 'Completed CREATE TABLE ddw1DW.DimTime.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
END
-------------------------------------------------------------------------------

 
-------------------------------------------------------------------------------
SET @ErrorText = 'Failed CREATE Table ddw1DW.DimProduct.';

IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'ddw1DW.DimProduct') AND type in (N'U'))
BEGIN
    SET @Message = 'Table ddw1DW.DimProduct already exist, skipping....';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
END
ELSE
BEGIN
    CREATE TABLE ddw1DW.DimProduct
    (
        ProductID TINYINT NOT NULL,
        Name NVARCHAR(50) NOT NULL,
        CONSTRAINT PK_DimProduct_ProductID PRIMARY KEY CLUSTERED (ProductID),
        CONSTRAINT UK_DimProduct_Name UNIQUE (Name)
    );

    SET @Message = 'Completed CREATE TABLE ddw1DW.DimProduct.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
END
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed CREATE Table ddw1DW.DimCustomer.';

IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'ddw1DW.DimCustomer') AND type in (N'U'))
BEGIN
    SET @Message = 'Table ddw1DW.DimCustomer already exist, skipping....';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
END
ELSE
BEGIN
    CREATE TABLE ddw1DW.DimCustomer
    (
        CustomerID TINYINT NOT NULL,
        Name NVARCHAR(50) NOT NULL,
        CONSTRAINT PK_DimCustomer_CustomerID PRIMARY KEY CLUSTERED (CustomerID),
        CONSTRAINT UK_DimCustomer_Name UNIQUE (Name)
    );

    SET @Message = 'Completed CREATE TABLE ddw1DW.DimCustomer.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
END
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed CREATE Table ddw1DW.FactSales.';

IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'ddw1DW.FactSales') AND type in (N'U'))
BEGIN
    SET @Message = 'Table ddw1DW.FactSales already exist, skipping....';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
END
ELSE
BEGIN
    CREATE TABLE ddw1DW.FactSales
    (
        OrderID INT NOT NULL,
        CustomerID TINYINT NOT NULL,
        ProductID TINYINT NOT NULL,
        TimeKey INT NOT NULL,
        TotalAmount MONEY NOT NULL,
        CONSTRAINT PK_FactSales_OrderID PRIMARY KEY CLUSTERED (OrderID)
    );

    SET @Message = 'Completed CREATE TABLE ddw1DW.FactSales.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
END
-------------------------------------------------------------------------------


SET @Message = 'Completed SP ' + @SP + '. Duration in minutes:  '   
   + CONVERT(VARCHAR(12), CONVERT(DECIMAL(6,2),datediff(mi, @StartTime, getdate())));   
RAISERROR(@Message, 0,1) WITH NOWAIT;

END TRY

BEGIN CATCH;
IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;

SET @ErrorText = 'Error: '+CONVERT(VARCHAR,ISNULL(ERROR_NUMBER(),'NULL'))      
                  +', Severity = '+CONVERT(VARCHAR,ISNULL(ERROR_SEVERITY(),'NULL'))      
                  +', State = '+CONVERT(VARCHAR,ISNULL(ERROR_STATE(),'NULL'))      
                  +', Line = '+CONVERT(VARCHAR,ISNULL(ERROR_LINE(),'NULL'))      
                  +', Procedure = '+CONVERT(VARCHAR,ISNULL(ERROR_PROCEDURE(),'NULL'))      
                  +', Server Error Message = '+CONVERT(VARCHAR(100),ISNULL(ERROR_MESSAGE(),'NULL'))      
                  +', SP Defined Error Text = '+@ErrorText;


RAISERROR(@ErrorText,18,127) WITH NOWAIT;
END CATCH;      

