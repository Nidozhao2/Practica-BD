-- 2na consulta

select nom_empleats from ordinaris join empleats on ordinaris.num_pass = empleats.num_pass
where ordinaris.num_pass not in(select empl_ord from assignacions,zona_biocontencio where( nivell='A' and zona_assignacions=codi and lab_assignacions=codiLab));
