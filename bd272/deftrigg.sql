create table impuesto(
 idsector varchar2(15),
 nropuesto number,
 impuesto number);


create or replace trigger cal_impues
	before insert on compra
	for each row
	declare
	c number;
	xprecio number;
	begin
	    select precio into xprecio
	    from producto 
	    where idproducto=:new.idproducto;
	    c := (xprecio*:new.cantidad)*0.16;
	   insert into impuesto values(
	   	   :new.idsector,
	   	   :new.nropuesto,
	   	   c);
	end

	insert into compra values(54053,6,'I','P66',30);

	insert into compra values(55040,13,'N','P68',50);