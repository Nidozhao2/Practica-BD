--5a consulta

select nom_empleats, count(distinct zona_assignacions, lab_assignacions) as num_zones
from ordinaris 
join empleats on ordinaris.num_pass = empleats.num_pass
join assignacions on ordinaris.num_pass = assignacions.empl_ord
group by ordinaris.num_pass, nom_empleats
having count(distinct zona_assignacions, lab_assignacions)> (
    select count(distinct zona_assignacions, lab_assignacions) from assignacions 
    join empleats on assignacions.empl_ord = empleats.num_pass
    where nom_empleats = 'Jordi Guasch'
)
order by num_zones desc;

