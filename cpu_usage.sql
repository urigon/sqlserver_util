select top 10 cpu,
req.spid,
Rtrim(req.hostname) as hostname,
Rtrim(req.program_name) as appname,
sdb.name as dbname,
sql.text
from sys.sysprocesses req
JOIN  sys.sysdatabases sdb ON req.dbid =  sdb.dbid
cross apply sys.dm_exec_sql_text(req.sql_handle) sql
where req.spid>50
order by req.cpu desc

