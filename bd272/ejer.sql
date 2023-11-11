create or replace function cantidad(xclienteid integer) returns integer
	as
	$$
	declare
	  xcantidad integer;

	  begin

	   select count(*) into xcantidad
	   from ordenes 
	   where clienteid=xclienteid
	   group by clienteid;

	   return xcantidad;

    
     exception when no_data_found then
      return 0;
	  end;

	 $$
 language 'plpgsql'


select nombrecia,cantidad(clienteid)
from clientes


create or replace function prover(in xproductoid integer, out xnombre varchar,out xcontacto varchar )
	returns setof record
	as
	$$
	declare
	reg record;
	begin
	  for reg in

	  select pr.nombreprov N,pr.contacto C
	  from productos p,proveedores pr
	  where p.proveedorid=pr.proveedorid and p.productoid=xproductoid

	  loop
	   xnombre := reg.N;
	   xcontacto := reg.C;
	   return next;

	  end loop;


	return;
	end
	$$
	language 'plpgsql';  

	select descripcion,prover(productoid)
	from productos

create or replace function cursor_while() returns void as
	$body$
	declare
	