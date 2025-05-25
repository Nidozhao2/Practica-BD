--View

drop view if exists EmpleatsPerZona;
create view EmpleatsPerZona as
select distinct empleats.num_pass, empleats.nom_empleats, t.zona
from empleats
join(
    select assignacions.empl_ord as num_pass, assignacions.zona_assignacions as zona
    from assignacions where datafi is null

    union

    select zona_biocontencio.responsable as num_pass, zona_biocontencio.codi as zona
    from zona_biocontencio
) as t 
on empleats.num_pass = t.num_pass ;
