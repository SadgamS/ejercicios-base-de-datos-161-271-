1)

 declare 
  cursor l_libros is  select d.iddoc,d.nombre,r.fechaedicion,e.nombre
   						from documento d,revista r,editorial e
   						where d.iddoc=r.iddoc and d.ideditorial=e.ideditorial
   						order by d.nombre;
   xnombrel varchar2(75);
   xfechaedicion date;
   xnombree varchar2(75);
   xiddoc number;

   cursor l_articulos is select titulo,idioma
         					from articulo 
         					where iddoc=xiddoc;
  xtitulo varchar2(100);
  xidioma varchar2(75);

begin
   dbms_output.put_line('                              REVISTAS                                ');
   dbms_output.put_line('====================================================================');
   dbms_output.put_line('    Nombre                   Fecha de Edicion             Editorial        ');
   open l_libros;
   loop
     fetch l_libros into xiddoc,xnombrel,xfechaedicion,xnombree;
     exit when l_libros%notfound;

       dbms_output.put_line(xnombrel||'          '||xfechaedicion||'      '||xnombree);

       open l_articulos;
       loop
         fetch l_articulos into xtitulo,xidioma;
         exit when l_articulos%notfound;
           dbms_output.put_line('        '||xtitulo||'          '||xidioma);
        end loop;

       close l_articulos;    


    end loop;
    close l_libros;
end    

2)

  declare 
   cursor l_editorial is select ideditorial,nombre
                         from editorial;
   xideditorial number;
   xnombree varchar2(75);
   c number;

   cursor l_libro is  select iddoc,nombre
                      from documento 
                      where ideditorial=xideditorial and  iddoc in (select iddoc from libro);
    xiddocl number;
    xnombrel varchar2(75);

    cursor l_autores is select a.idautor,a.nombre,a.apellido
    					from escribe_l el,autor a
    					where el.idautor=a.idautor and el.iddoc=xiddocl;
    xidautor number;
    xnombrea varchar2(75);
    xapellidoa varchar2(75);

    cursor l_revista is     select iddoc,nombre
     						from documento
     						where ideditorial=xideditorial and iddoc in(select iddoc from revista);
    xiddocr number;
    xnombrer varchar2(75);

    cursor l_articulo is select titulo,tematica,idioma
     						from articulo
     						where iddoc=xiddocr;
    xtitulo varchar2(100);
    xtematica varchar2(25);
    xidioma varchar2(25);
    c1 number;

    begin
        c :=0;
        
        dbms_output.put_line('    LISTA EDITORIALES        ');
   		dbms_output.put_line('====================================================================');
   		
   		open l_editorial;
   		loop
   		   fetch l_editorial into xideditorial,xnombree;
   		   exit when l_editorial%notfound;
   		   c:=c+1;
   		   dbms_output.put_line(c||'     '||xnombree);

   		   open l_libro;
   		   loop 
   		     fetch l_libro into xiddocl,xnombrel;
   		     exit when l_libro%notfound;
   		     dbms_output.put_line('     Libro:   '||xnombrel);
   		     dbms_output.put_line('        Autores           ');
   		     dbms_output.put_line('        --------------------------' );
   		  
   		     open l_autores;
   		     loop
   		      fetch l_autores into xidautor,xnombrea,xapellidoa;
   		      exit when l_autores%notfound;

   		          dbms_output.put_line('     '||xidautor||'    '||xnombrea||'    '||xapellidoa);

   		     end loop;
   		     close l_autores;

   		   end loop;
   		   close l_libro;

   		   open l_revista;
   		   loop 
   		     fetch l_revista into xiddocr,xnombrer;
   		     exit when l_revista%notfound;
   		            dbms_output.put_line('   Revista:  '||xnombrer);
                   dbms_output.put_line('   Articulos:  ');
                    dbms_output.put_line('  --------------------------- ');
                    c1 :=0;
   		       open l_articulo;
   		       loop
   		         fetch l_articulo into xtitulo,xtematica,xidioma;
   		         exit when l_articulo%notfound;
   		          c1:=c1+1;
   		                dbms_output.put_line('     '||c1||'  titulo '||xtitulo||'    tematica  '||xtematica||'   idioma  '||xidioma);  

   		       end loop;
   		       close l_articulo;

   		   end loop;
   		   close l_revista;


   		end  loop;
   		close l_editorial;
   	end

 















