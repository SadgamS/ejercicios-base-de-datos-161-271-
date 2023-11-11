create or replace function cant_platos(xidcliente integer) returns integer
	as
	 $$
	  declare
	   cantidad integer;
	    begin
              select count(*) into cantidad
              from consume
              where idcliente=xidcliente
              group by idcliente;

          return cantidad;
          exception when no_data_found then
          return 0;
	     end;
	     $$
	     language plpgsql;
	 252    
select idplato
from v_plato
where idcliente=16

create or replace function precio_plato(xidcliente integer) returns integer
	as
	 $$
	  declare 
	   monto integer;

	   begin

	    select sum(p.precio*v.cantidad) into monto
       from v_plato v,plato p
       where p.idplato=v.idplato and v.idcliente=xidcliente;
	    
      return monto;

	    end;

	    $$

	   language plpgsql;

	 create or replace function ficha_x_cliente(in xidcliente integer,out xnombre varchar,out xcantidad varchar,out xmonto varchar)
	 		returns setof record
	as
	$$
	declare
	reg record;
	begin
	  for reg in
	      select nombre N,cant_platos(idcliente) C,precio_plato(idcliente) P
	      from cliente
	      where idcliente=xidcliente
  loop
	   xnombre := 'Cliente:  '||reg.N;
	   xcantidad := 'cantidad De platos consumidos:  '||reg.C;
	   xmonto :='monto total:  '||reg.P;
	   return next;

	  end loop;
	  return;
	end
	$$
	language 'plpgsql';  

