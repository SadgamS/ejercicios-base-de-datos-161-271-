Select codeditorial, count(*)
From libro
group by codeditorial


select nombre, num
from editorial e, (Select codeditorial, count(*) as num
                From libro
                group by codeditorial) tmp
where e.codeditorial = tmp.codeditorial
order by nombre

select precio
from libro
order By precio desc

select max(precio)
from libro

select codlibro
from libro
where precio = (select max(precio)
                from libro)

select a.apellido,a.nombre
from autor a,escrito_por ep, (select codlibro
                        from libro
                        where precio = (select max(precio)
                                            from libro))tmp
where ep.codlibro = tmp.codlibro and a.codautor = ep.codautor
order by a.apellido



select nropedido,sum(cantidad) as total
from pedido_libros
group by nropedido
having sum(cantidad) >= 10 and sum(cantidad) <= 25

select c.apellido,c.nombre, tmp.total
from cliente c,pedido p, (select nropedido,sum(cantidad) as total
                            from pedido_libros
                            group by nropedido
                            having sum(cantidad) >= 10 and sum(cantidad) <= 25
                        )tmp
where p.nropedido = tmp.nropedido and p.codcliente = c.codcliente
order by c.apellido

select codlibro,count(*)
from escrito_por
group by codlibro
having count(*)>=2

select ep.codlibro, a.sexo
from escrito_por ep,autor a,(select codlibro,count(*)
                            from escrito_por
                            group by codlibro
                            having count(*)=2)tmp
where ep.codlibro = tmp.codlibro and a.codautor = ep.codautor and (a.sexo like 'Masculino' or a.sexo like 'Femenino')


Create or Replace Function nroDocumento_x_Edi(xidedi IN number) return number
IS
xnro number;
BEGIN

Select count(*) into xnro
from documento 
where xidedi = ideditorial
group by ideditorial;

Return xnro;
EXCEPTION
WHEN NO_DATA_FOUND THEN
RETURN 0;
END nroDocumento_x_Edi;

Select count(*)
from documento
group by ideditorial

	Select nombre,nroDocumento_x_Edi(ideditorial) nroDoc
	From editorial
	Order By nombre


select count(*)
from escribe_l
group by iddoc


Create or Replace Function nroAutores_x_Libro(xiddoc IN number) return number
IS
xnro number;
BEGIN

select count(*) into xnro
from escribe_l
where iddoc = xiddoc
group by iddoc;

Return xnro;
EXCEPTION
WHEN NO_DATA_FOUND THEN
RETURN 0;
END nroAutores_x_Libro;

select nombre, nroAutores_x_Libro(iddoc) nroautores
from documento

Create or Replace Function literal (xnumero IN number) return varchar2
IS
xlit varchar2(25);
BEGIN
	IF xnumero = 1 THEN
		xlit := 'UNO';
	END IF;

	IF xnumero = 2 THEN
		xlit := 'DOS';
	END IF;

	IF xnumero = 3 THEN
		xlit := 'TRES';
	END IF;
	IF xnumero = 4 THEN
		xlit := 'CUATRO';
	END IF;
	IF xnumero = 5 THEN
		xlit := 'CINCO';
	END IF;
	IF xnumero = 6 THEN
		xlit := 'SEIS';
	END IF;
	IF xnumero = 7 THEN
		xlit := 'SIETE';
	END IF;

	IF xnumero = 8 THEN
		xlit := 'OCHO';
	END IF;

		IF xnumero = 9 THEN
		xlit := 'NUEVE';
	END IF;
	
		IF xnumero = 10 THEN
		xlit := 'DIEZ';
	END IF;
	
return xlit;

END literal;

select literal(1) from dual

Select nombre,(literal(nroAutores_x_Libro(iddoc))) nro
From documento
order by nombre