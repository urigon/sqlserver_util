select sum(memusage) as memtotal,
COUNT(*) as processnum,
Rtrim(hostname) as hostname,
Rtrim(program_name) as appname
from sys.sysprocesses
group by hostname,program_name
order by memtotal desc

