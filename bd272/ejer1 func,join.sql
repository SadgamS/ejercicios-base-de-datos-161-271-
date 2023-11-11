1)

select count(*)
from documento
where ideditorial= 50
group by ideditorial


Create or Replace Function nroDocumento_x_Edi(xidedi IN number) return number 
IS  
xnro number; 
BEGIN 
	select count(*) into xnro
	from documento
	where ideditorial= xidedi
	group by ideditorial;   
Return xnro;  

  EXCEPTION    
  WHEN NO_DATA_FOUND THEN    
  RETURN 0;  
END nroDocumento_x_Edi;

Select nombre,nroDocumento_x_Edi(ideditorial) nroDoc 
From editorial 
Order By nombre

2)

select count(*)
from documento
group by ideditorial

select  e.nombre,nvl(tmp.nroDoc,0) as nroDoc
from (select ideditorial,count(*) nroDoc
	  from documento
	  group by ideditorial)tmp right join editorial e
on e.ideditorial=tmp.ideditorial
Order by e.nombre