/***************************************************************************************************
File: 02_InsertTables.sql
----------------------------------------------------------------------------------------------------
Create Date:    2020-09-01 (yyyy-mm-dd)
Author:         Surush Cyrus
Description:    Inserts needed rows to few tables 
Call by:        TBD, Add hoc
Steps:          N/A 
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

SET @SP = 'Script-03_InsertTables';
SET @StartTime = GETDATE();

SET @Message = 'Started SP ' + @SP + ' at ' + FORMAT(@StartTime , 'MM/dd/yyyy HH:mm:ss');   
RAISERROR (@Message, 0,1) WITH NOWAIT;

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed INSERT to table Product!';
INSERT INTO ddw1.Product
   (ProductID, Name)
VALUES
   (01, 'Product 01'),
   (02, 'Product 02'),
   (03, 'Product 03')

SET @Message = CONVERT(VARCHAR(10), @@ROWCOUNT) + ' rows effected. Completed INSERT to table Product';   
RAISERROR (@Message, 0,1) WITH NOWAIT;
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed INSERT to table Customer!';
INSERT INTO ddw1.Customer
   (CustomerID, Name)
VALUES
   (01, 'Customer 01'),
   (02, 'Customer 02'),
   (03, 'Customer 03')

SET @Message = CONVERT(VARCHAR(10), @@ROWCOUNT) + ' rows effected. Completed INSERT to table Customer';   
RAISERROR (@Message, 0,1) WITH NOWAIT;
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed INSERT to table Customer!';
INSERT INTO ddw1.[Order]
   (OrderID, CustomerID, ProductID, OrderDate, TotalAmount)
VALUES
   (01, 01, 01, '01/01/2021', 10),
   (02, 01, 02, '01/02/2021', 20),
   (03, 01, 02, '01/03/2021', 30),
   (04, 01, 01, '01/03/2021', 40),
   (05, 02, 01, '01/01/2021', 10),
   (06, 02, 02, '01/02/2021', 20),
   (07, 02, 03, '01/03/2021', 30),
   (08, 02, 02, '01/03/2021', 40),
   (09, 03, 02, '01/01/2021', 10),
   (10, 03, 02, '01/02/2021', 20),
   (11, 03, 01, '01/03/2021', 30),
   (12, 03, 01, '01/03/2021', 40)

SET @Message = CONVERT(VARCHAR(10), @@ROWCOUNT) + ' rows effected. Completed INSERT to table Customer';   
RAISERROR (@Message, 0,1) WITH NOWAIT;
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
