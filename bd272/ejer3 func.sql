
create or replace function nroAutores_x_Artículo(xidarticulo in number) return number
is 
 xcantidad number;
 begin
   select count(*) into xcantidad
   from escribe_a
   where idarticulo=xidarticulo
   group by idarticulo;
RETURN xcantidad;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  RETURN 0;
  end nroAutores_x_Artículo;

  select nroAutores_x_Artículo(idarticulo)
  from escribe_a

  create or replace function nroRB_x_Articulo(xidarticulo in number,xque in number) RETURN number
  	is 
  	 xcantidad number;
  	 begin
  	  if xque=1 THEN
  	  select count(*) into xcantidad
  	  from refb_aa
  	  where idarticulo1=xidarticulo
  	  group by idarticulo1;
  	  end if;
  	  if xque=2 THEN
  	  select count(*) into xcantidad
  	  from refb_al
  	  where idarticulo=xidarticulo
  	  group by idarticulo;
  	  end if;
  	  if xque=3 THEN
  	  select (nroa+nrol) into xcantidad
  	  from ( select count(*) nroa
  	 		 from refb_aa
  	  		where idarticulo1=xidarticulo
  	  		group by idarticulo1) tmp, ( select count(*) nrol
  	  										from refb_al
  	 										 where idarticulo=xidarticulo
  	  										group by idarticulo) tmp2;
  	 end if;
  	 RETURN xcantidad;
  	 EXCEPTION
 WHEN NO_DATA_FOUND THEN
  RETURN 0;
 end nroRB_x_Articulo;

 select nroRB_x_Articulo(690,3) from dual

 1)

  select idautor
  from escribe_a
  group by idautor

  select idautor
  from escribe_l 
  group by idautor

  select apellido,nombre
  from autor
  where idautor in (  select idautor
  					from escribe_a
  					group by idautor)
  and idautor in (  select idautor
  					from escribe_l 
  					group by idautor)
  order by apellido
  

select apellido,nombre
from autor
where nroArticulos_x_Autor(idautor)>0
and nroLibros_x_Autor(idautor) >0
order by apellido

2)

select titulo,nroAutores_x_Artículo(idarticulo) nroArti,nroRB_x_Articulo(idarticulo,1) nrorefart
from articulo
where nroAutores_x_Artículo(idarticulo)>1
order by titulo


3)

select idautor
from escribe_a
where nroRB_x_Articulo(idarticulo,3)>5
group by idautor

select apellido,nombre
from autor
where idautor in (select idautor
				from escribe_a
				where nroRB_x_Articulo(idarticulo,3)>5)
order by apellido

select apellido,nombre
from autor a,(select idautor
              from escribe_a
              where nroRB_x_Articulo(idarticulo,3)>5) tmp
where a.idautor=tmp.idautor