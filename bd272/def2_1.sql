
1)
create or replace function cantidad_produ(xnropuesto in number,xidsector in varchar2) return number
is
 cantidad number;
 begin 

  select count(*) into cantidad
  from ofrecep
  where nropuesto=xnropuesto and idsector=xidsector;
  return cantidad;
  end cantidad_produ;

  create or replace function capital(xnropuesto in number,xidsector in varchar2) return number
  	is
  	  xcapital number;
      begin
  	   select sum(tmp.stock*p.precio) into xcapital
       from producto p,(select idproducto,stock
  	   					from ofrecep
       					where nropuesto=xnropuesto and idsector=xidsector)tmp
       where p.idproducto=tmp.idproducto;

       return xcapital;
       end capital;

 create or replace procedure ficha_x_puesto(xnropuesto in number,xidsector in varchar2,
 	xnombre out varchar2,
 	xcantpro out number,
 	xcapital out number)
 is
  begin
   select nombre into xnombre
   from puesto
   where nropuesto=xnropuesto and idsector=xidsector;

   select cantidad_produ(xnropuesto,xidsector) into xcantpro
   from dual;

   select capital(xnropuesto,xidsector) into xcapital
   from dual;

   end ficha_x_puesto;

 declare 
 xidsector varchar2(50);
 xnropuesto number;
 xcantpro number;
 xnombre varchar2(50); 
 xcapital number;
 begin
  xidsector := 'A';
  xnropuesto :=2; 
  ficha_x_puesto(xnropuesto,xidsector,xnombre,xcantpro,xcapital); 
  dbms_output.put_line('SECTOR: '||xidsector|| '       Puesto: '||xnropuesto ); 
  dbms_output.put_line('Nombre:'||xnombre); 
  dbms_output.put_line('Cantidad de Pruductos que ofrece: '||xcantpro);
   dbms_output.put_line('Capital: '||xcapital);
   end

   declare 
 xidsector varchar2(50);
 xnropuesto number;
 xcantpro number;
 xnombre varchar2(50); 
 xcapital number;
 begin
  xidsector := 'H';
  xnropuesto :=9; 
  ficha_x_puesto(xnropuesto,xidsector,xnombre,xcantpro,xcapital); 
  dbms_output.put_line('SECTOR: '||xidsector|| '       Puesto:  '||xnropuesto ); 
  dbms_output.put_line('Nombre:'||xnombre); 
  dbms_output.put_line('Cantidad de Pruductos que ofrece: '||xcantpro);
   dbms_output.put_line('Capital: '||xcapital);
   end

   declare 
 xidsector varchar2(50);
 xnropuesto number;
 xcantpro number;
 xnombre varchar2(50); 
 xcapital number;
 begin
  xidsector := 'E';
  xnropuesto :=3; 
  ficha_x_puesto(xnropuesto,xidsector,xnombre,xcantpro,xcapital); 
  dbms_output.put_line('SECTOR: '||xidsector|| '       Puesto: '||xnropuesto ); 
  dbms_output.put_line('Nombre:'||xnombre); 
  dbms_output.put_line('Cantidad de Pruductos que ofrece: '||xcantpro);
   dbms_output.put_line('Capital: '||xcapital);
   end

2)

create or replace function cant_gart(xci in number) return number
is
 cantidad number;
 begin
  select count(*) into cantidad
  from garante 
  where cigarante =xci
  group by cigarante ;

  return cantidad;

  exception when no_data_found 
  then return 0;

  end cant_gart;

  create or replace function es_garante(xci in number) return varchar2
  	is
  	 mensaje varchar2(50);
  	 xc number;
   begin 
   select count(*) into xc
   from garante
   where cigarante=xci
   group by cigarante ;
   
  if xc>0 then
   mensaje:='SI';
   end if;
   return mensaje;
    exception when no_data_found 
  then return 'NO';

  end es_garante;

create or replace function cant_compra(xci in number) return varchar2
	is
	mens varchar2(50);
	xcantidad number;
	begin
	select count(*) into xcantidad
	from compra
	where cicliente=xci
	group by idproducto;

	if xcantidad>0 then
	mens :=xcantidad||' Productos';
	end if;

	return mens;
	 exception when no_data_found 
  then return 'NO TIENE COMPRAS';
  end cant_compra;


  create or replace procedure ficha_x_clinte(xci in number,
  	xnombre out varchar2,
  	xapellido out varchar2,
  	xgarante out varchar2,
  	xcantgar out number,
  	xcantpro out varchar2)
  is
   begin
   select apellido,nombre into xapellido,xnombre
   from persona
   where ci=xci;

   select es_garante(xci) into xgarante
   from dual;

   select cant_gart(xci) into xcantgar
   from dual;

   select cant_compra(xci) into xcantpro
   from dual;

   end ficha_x_clinte;

 declare 
 xnombre varchar2(50);
 xci number;
 xcantgar number;
 xgarante varchar2(50); 
  xapellido varchar2(50);
  xcantpro varchar2(50); 
  begin
  xci := '92807';
  ficha_x_clinte(xci,xnombre,xapellido,xgarante,xcantgar,xcantpro); 
  dbms_output.put_line('ci '||xci); 
  dbms_output.put_line('Apellidos y Nombre:'||xapellido||'  '||xnombre); 
  dbms_output.put_line('Es garante '||xgarante||'     '||xcantgar||'  personas');
   dbms_output.put_line('Cantidad de productos comprados: '||xcantpro);
   end

   declare 
 xnombre varchar2(50);
 xci number;
 xcantgar number;
 xgarante varchar2(50); 
  xapellido varchar2(50);
  xcantpro varchar2(50); 
  begin
  xci := '70102';
  ficha_x_clinte(xci,xnombre,xapellido,xgarante,xcantgar,xcantpro); 
  dbms_output.put_line('ci '||xci); 
  dbms_output.put_line('Apellidos y Nombre:'||xapellido||'  '||xnombre); 
  dbms_output.put_line('Es garante '||xgarante||'     '||xcantgar||'  personas');
   dbms_output.put_line('Cantidad de productos comprados: '||xcantpro);
   end

    declare 
 xnombre varchar2(50);
 xci number;
 xcantgar number;
 xgarante varchar2(50); 
  xapellido varchar2(50);
  xcantpro varchar2(50); 
  begin
  xci := '87617';
  ficha_x_clinte(xci,xnombre,xapellido,xgarante,xcantgar,xcantpro); 
  dbms_output.put_line('ci '||xci); 
  dbms_output.put_line('Apellidos y Nombre:'||xapellido||'  '||xnombre); 
  dbms_output.put_line('Es garante '||xgarante||'     '||xcantgar||'  personas');
   dbms_output.put_line('Cantidad de productos comprados: '||xcantpro);
   end