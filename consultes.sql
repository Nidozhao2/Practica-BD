-- 1ra consulta
select nom_laboratoris,codi_laboratoris from laboratoris where (select codiLab from zona_biocontencio where nivell = 'A' and codiLab = codi_laboratoris);

-- 2na consulta

select nom_empleats from ordinaris join empleats on ordinaris.num_pass = empleats.num_pass
where ordinaris.num_pass not in(select empl_ord from assignacions,zona_biocontencio where( nivell='A' and zona_assignacions=codi and lab_assignacions=codiLab));

-- 3ra consulta

select codi, nom_laboratoris from qualificats 

join zona_biocontencio on (zona_assignada = codi and lab = codiLab)
join laboratoris on (codiLab = codi_laboratoris) 

group by codi, nom_laboratoris having count(*) >= 3 order by nom_laboratoris, codi;

-- 4ta consulta
 Obtenir quins empleats ordinaris han estat en totes les zones de biocontenció
del laboratori que té per nom ‘BCN-XXX

select ordinaris.num_pass,nom_empleats from ordinaris join empleats on ordinaris.num_pass = empleats.num_pass 
where not exists (select codi, codiLab from zona_biocontencio 
join laboratoris on (codiLab = codi_laboratoris) 
where nom_laboratoris = 'BCN-XXX' and not exists (select * from assignacions where empl_ord = ordinaris.num_pass and zona_assignacions = codi and lab_assignacions = codiLab));


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



CREATE VIEW EmpleatsPerZona AS
SELECT DISTINCT e.num_pass, e.nom_empleats, t.zona
FROM empleats e
JOIN (
    -- Empleats ordinaris assignats a zones
    SELECT a.empl_ord AS num_pass, a.zona_assignacions AS zona
    FROM assignacions a

    UNION

    -- Responsables de zona (1 per zona)
    SELECT z.responsable AS num_pass, z.codi AS zona
    FROM zona_biocontencio z
) AS t
ON e.num_pass = t.num_pass;



































