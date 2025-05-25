-- 4ta consulta

select ordinaris.num_pass,nom_empleats from ordinaris join empleats on ordinaris.num_pass = empleats.num_pass 
where not exists (select codi, codiLab from zona_biocontencio 
join laboratoris on (codiLab = codi_laboratoris) 
where nom_laboratoris = 'BCN-XXX' and not exists (select * from assignacions where empl_ord = ordinaris.num_pass and zona_assignacions = codi and lab_assignacions = codiLab));
