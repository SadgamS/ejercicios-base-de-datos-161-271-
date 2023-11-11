1)

  declare 
  cursor l_autores is select *
                      from autor
                      order by apellido;
     tautor autor%rowtype;
 begin 
    dbms_output.put_line('Codigo     Apellido y Nombre    Nacionalidad');
    dbms_output.put_line('=============================================');
    open l_autores;
    loop
          Fetch l_autores into tautor;
          exit when l_autores%Notfound;
             dbms_output.put_line(tautor.idautor||'     '||tautor.apellido||'    '||tautor.nombre||'        '||tautor.nacionalidad);
    end loop;
 close l_autores;
end       
 
2)

  declare 
  cursor l_autores is select *
                      from autor
                      order by apellido;
     tautor autor%rowtype;
     c number;
     nra number;
 begin 
    c :=0;
    select nroautores into nra
    from dual;
    dbms_output.put_line('TOTAL AUTORES   '||nra);
    dbms_output.put_line('Nro     Apellido y Nombre    Nacionalidad');
    dbms_output.put_line('=============================================');

    open l_autores;
    loop
          Fetch l_autores into tautor;
          exit when l_autores%Notfound;
             c :=c+1;
             dbms_output.put_line(c||'     '||tautor.apellido||'    '||tautor.nombre||'        '||tautor.nacionalidad);
    end loop;
 close l_autores;
end       



create or replace function nroautores return number
	is
	xc number;
	begin 
	  select count(*) into xc
      from autor;
    return xc;
    end nroautores;

    select nroautores
    from dual


3)

 declare 
  cursor l_revistas is select d.nombre,r.pais,e.nombre
						from documento d,revista r,editorial e
						where d.iddoc=r.iddoc and d.ideditorial=e.ideditorial;
     xnombre varchar2(75);
     xpais varchar2(50);
     xnombreed varchar2(50);
     c number;
 begin 
    c :=0;
    dbms_output.put_line('===============================================================');
    dbms_output.put_line('Nro  Nombre                         Pais                Editorial');
    dbms_output.put_line('==============================================================');

    open l_revistas;
    loop
          Fetch l_revistas into xnombre,xpais,xnombreed;
          exit when l_revistas%Notfound;
             c :=c+1;
             dbms_output.put_line(c||'   '||xnombre||'                   '||xpais||'                    '||xnombreed);
    end loop;
 close l_revistas;
end       

select d.nombre,r.pais,e.nombre
from documento d,revista r,editorial e
where d.iddoc=r.iddoc and d.ideditorial=e.ideditorial

4)
 

create or replace function nrolib(xidbiblio in number )return number
 is 
  cantidad number;
  begin
   	select count(*) into cantidad
	from se_encuentra
	where idbiblio=xidbiblio
	group by idbiblio;

    return cantidad;
    
    exception when no_data_found then
    return 0;
  end nrolib;

select nombre,nrolib(idbiblio)
from biblioteca 

declare
 cursor l_biblio is select *
                    from biblioteca;
  tbiblio biblioteca%rowtype;
  cant number;
  c number;
  begin
    c:=0;
     dbms_output.put_line('                                 BIBLIOTECA                            ');
     dbms_output.put_line('===============================================================');
     dbms_output.put_line('Nro  Nombre                        Direccion               Nro Libros');
     dbms_output.put_line('==============================================================');
    
    open l_biblio;
    loop 
          Fetch l_biblio into tbiblio ;
          select nrolib(tbiblio.idbiblio) into cant
          from dual;
          exit when l_biblio%Notfound;
           c :=c+1;
           dbms_output.put_line(c||'   '||tbiblio.nombre||'                   '||tbiblio.direccion||'                    '||cant);
    end loop;
    close l_biblio;
    end


