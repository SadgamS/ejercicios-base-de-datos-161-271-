
select idarticulo1,count(*) 
from refb_aa
group by idarticulo1

select idarticulo,count(*)
from refb_al
group by idarticulo

select tmp.idarticulo1,NVl(tmp.nroaa+tmp1.nroal,0) total 
from (select idarticulo1,count(*) nroaa
		from refb_aa
group by idarticulo1) tmp left join (select idarticulo,count(*) nroal
									from refb_al
								group by idarticulo)tmp1
on tmp.idarticulo1=tmp1.idarticulo 

select tmp.idarticulo1
from (select idarticulo1,count(*) nroaa
		from refb_aa
group by idarticulo1) tmp , (select idarticulo,count(*) nroal
									from refb_al
								group by idarticulo)tmp1
where tmp.idarticulo1=tmp1.idarticulo and (tmp.nroaa+tmp1.nroal)>5


select idautor
from escribe_a
where idarticulo in (select tmp.idarticulo1
					from (select idarticulo1,count(*) nroaa
							from refb_aa
					group by idarticulo1) tmp , (select idarticulo,count(*) nroal
									from refb_al
								group by idarticulo)tmp1
					where tmp.idarticulo1=tmp1.idarticulo and (tmp.nroaa+tmp1.nroal)>5)


select apellido,nombre
from autor
where idautor in (select idautor
				 from escribe_a
				where idarticulo in (select tmp.idarticulo1
					from (select idarticulo1,count(*) nroaa
							from refb_aa
					group by idarticulo1) tmp , (select idarticulo,count(*) nroal
									from refb_al
								group by idarticulo)tmp1
					where tmp.idarticulo1=tmp1.idarticulo and (tmp.nroaa+tmp1.nroal)>5))

select apellido,nombre
from autor a,(select idautor
				 from escribe_a
				where idarticulo in (select tmp.idarticulo1
					from (select idarticulo1,count(*) nroaa
							from refb_aa
					group by idarticulo1) tmp , (select idarticulo,count(*) nroal
									from refb_al
								group by idarticulo)tmp1
					where tmp.idarticulo1=tmp1.idarticulo and (tmp.nroaa+tmp1.nroal)>5))tmp3

where a.idautor=tmp3.idautor
					