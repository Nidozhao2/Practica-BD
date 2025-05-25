-- 1ra consulta
select nom_laboratoris,codi_laboratoris from laboratoris 
where (select codiLab from zona_biocontencio 
    where nivell = 'A' and codiLab = codi_laboratoris)
    
order by nom_laboratoris;
