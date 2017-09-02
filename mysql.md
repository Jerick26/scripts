[find all the tables with specific column names](#find-all-the-tables-with-specific-column-names)

## find all the tables with specific column names
```
SELECT DISTINCT TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME IN ('columnA','ColumnB') AND TABLE_SCHEMA='YourDatabase';

SELECT TABLE_NAME, COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME LIKE '%wild%' AND TABLE_SCHEMA='YourDatabase';

SELECT * FROM information_schema.columns WHERE column_name = 'column_name';

SELECT table_name,table_schema FROM INFORMATION_SCHEMA.COLUMNS
WHERE column_name='sort_method'
```
