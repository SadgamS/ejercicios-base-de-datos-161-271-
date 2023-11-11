
1)
create or replace function nroAutore_x_Libros(xiddoc IN number) RETURN number
IS
xcantidad number;
begin 
 select count(*) into xcantidad
 from escribe_l
 where iddoc=xiddoc
 group by iddoc;
RETURN xcantidad;

EXCEPTION
 WHEN NO_DATA_FOUND THEN
  RETURN 0;

end nroAutore_x_Libros

select nroAutore_x_Libros(iddoc)
from escribe_l

create or replace function literal(xnumero in number) RETURN varchar2
IS
 xliteral varchar2(50);
 
 begin
     if xnumero = 0 THEN
      xliteral:='CERO';
     end if;
     if xnumero = 1 THEN
      xliteral:='UNO';
     end if;
       if xnumero = 2 THEN
      xliteral:='DOS';
     end if;
       if xnumero = 3 THEN
      xliteral:='TRES';
     end if;
       if xnumero = 4 THEN
      xliteral:='CUATRO';
     end if;
       if xnumero = 5 THEN
      xliteral:='CINCO';
     end if;
       if xnumero = 6 THEN
      xliteral:='SIETE';
     end if;
       if xnumero = 8 THEN
      xliteral:='NUEVE';
     end if;
       if xnumero = 10 THEN
      xliteral:='DIEZ';
     end if;
      if xnumero > 10 THEN
      xliteral:='FUERA DE DOMINIO';
     end if;
   RETURN xliteral;

       
   end literal

select literal(1) from dual

select d.nombre,(literal(nroAutore_x_Libros(l.iddoc))) nroautores
from documento d,libro l
where d.iddoc=l.iddoc
order by nombre

2)

create or replace function nroLibros_x_Autor(xidautor in number) RETURN number
 IS
   xcantidad number;
   begin
    select count(*) into xcantidad
    from escribe_l
    where idautor=xidautor
    group by idautor;
   RETURN xcantidad;

   EXCEPTION WHEN NO_DATA_FOUND THEN
  RETURN 0;

  end nroLibros_x_Autor

create or replace function nroArticulos_x_Autor(xidautor in number) RETURN number
 IS
   xcantidad number;
   begin
    select count(*) into xcantidad
    from escribe_a
    where idautor=xidautor
    group by idautor;
   RETURN xcantidad;

   EXCEPTION WHEN NO_DATA_FOUND THEN
  RETURN 0;

  end nroArticulos_x_Autor


 select apellido,nombre,nroLibros_x_Autor(idautor) mrolibro,nroArticulos_x_Autor(idautor) nroarticulo,nroLibros_x_Autor(idautor)+nroArticulos_x_Autor(idautor) total
 from autor
 order by apellido

