select spid, hostname, program_name, hostprocess, dbname, text, required_memory_kb, query_cost, wait_time_ms
from (
    SELECT distinct spid, sp.hostname, sp.program_name, sp.hostprocess, db.name as dbname, mg.required_memory_kb, mg.query_cost, mg.wait_time_ms, mg.sql_handle
    FROM sys.dm_exec_query_memory_grants mg
    inner join sys.sysprocesses sp
    on mg.session_id=sp.spid
    inner join sys.databases db
    on sp.dbid = db.database_id
    ) mem
CROSS APPLY sys.dm_exec_sql_text(sql_handle) -- shows query text
order by required_memory_kb desc
