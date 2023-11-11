
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


   EXCEPTION            WHEN NO_DATA_FOUND THEN             RETURN 0; 
   
select
from