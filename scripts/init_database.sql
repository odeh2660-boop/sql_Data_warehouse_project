--create dwsql database
use master
create database DwSql;

use DwSql;
--create schema
create schema bronze;
go
create schema silver;
go
create schema gold;
go