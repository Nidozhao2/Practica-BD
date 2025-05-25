-- 3ra consulta

select codi, nom_laboratoris from qualificats 

join zona_biocontencio on (zona_assignada = codi and lab = codiLab)
join laboratoris on (codiLab = codi_laboratoris) 

group by codi, nom_laboratoris having count(*) >= 3 order by nom_laboratoris, codi;
