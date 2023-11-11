ESTUDIANTE (idestu, nombre, apellido, sexo, fecnaci,nacionalidad)
MATERIA(sigla, descripcion, semestre, credito , iddoc_cordi)
PARALELO(sigla, idparalelo, iddoc, diahora1, diahora2, idaula)
INSCRITO(idestu , sigla, idparalelo, nota1,nota2,nota3)
DOCENTE(iddoc, paterno,materno,nombre,fecnaci,sexo,titulo, ch)
AULA(idaula, capacidad , tipo)

SELECT nota3
From INSCRITO

SELECT e.apellido , e.nombre , i.nota3
From INSCRITO  i , ESTUDIANTE e
WHERE nota3 = (SELECT MAX(nota3)
		From INSCRITO )
AND i.idestu = e.idestu
AND i.sigla LIKE 'INF111'


//////////////

SELECT e.apellido , e.nombre , TO_CHAR(sysdate,'yyyy')-TO_CHAR(fecnaci , 'YYYY') edad
FROM  ESTUDIANTE e 
WHERE edad = (SELECT MAX (TO_CHAR(sysdate,'yyyy')-TO_CHAR(fecnaci , 'YYYY'))
			FROM ESTUDIANTE)

//////////////

SELECT sigla
FROM MATERIA

SELECT DISTINCT d.paterno , d.materno , d.nombre
FROM DOCENTE d , MATERIA m ,PARALELO p
WHERE p.sigla IN( SELECT sigla
				FROM MATERIA)
AND d.iddoc = p.iddoc
ORDER BY d.paterno

SELECT DISTINCT d.paterno , d.materno , d.nombre
FROM DOCENTE d 
WHERE iddoc NOT IN ( SELECT d.iddoc
			FROM DOCENTE d , MATERIA m ,PARALELO p
			WHERE p.sigla IN( SELECT sigla
				FROM MATERIA)
			AND d.iddoc = p.iddoc)
ORDER BY d.paterno

////////////////////////////////////////////////////

SELECT tipo
FROM AULA
WHERE TIPO = 'TEORICA'

SELECT m.sigla , m.descripcion
FROM MATERIA m , PARALELO p
WHERE p.idaula NOT IN (SELECT tipo
						FROM AULA 
						WHERE TIPO LIKE 'TEORICA')
AND p.sigla <>m.sigla



SELECT m.sigla , m.descripcion
FROM MATERIA m
WHERE m.sigla  IN (SELECT DISTINCT p.sigla
					FROM PARALELO p
					WHERE p.idaula NOT IN (SELECT tipo
										FROM AULA 
										WHERE TIPO LIKE 'TEORICA')

)

SELECT DISTINCT p.sigla
FROM PARALELO p
WHERE p.idaula NOT IN (SELECT tipo
						FROM AULA 
						WHERE TIPO ='TEORICA')



NOT IN

////////////////////////////////////////////////

////////////// 2 ///////////////////////////////

SELECT d.paterno , d.materno , d.nombre 
FROM DOCENTE d
WHERE sexo = 'MASCULINO' 
AND d.iddoc NOT IN (SELECT MATERIA m , DOCENTE d
			FROM m.iddoc_cordi = d.iddoc
			)
AND d.iddoc NOT IN (SELECT PARALELO p, DOCENTE d
			FROM p.iddoc = d.iddoc)



SELECT MATERIA m
FROM m.iddoc_cordi = d.iddoc

SELECT PARALELO p
FROM p.iddoc = d.iddoc


SELECT d.paterno , d.materno , d.nombre , tmp.horasdictadas
FROM DOCENTE d , (SELECT iddoc, count(*) horasdictadas
				FROM PARALELO p
				GROUP BY  iddoc) tmp
WHERE d.iddoc = tmp.iddoc
ORDER BY d.paterno

////////////////////////////////////////////////

SELECT d.paterno , d.materno , d.nombre 
FROM DOCENTE d
WHERE sexo = 'MASCULINO' 
AND d.iddoc NOT IN (SELECT MATERIA m 
			FROM m.iddoc_cordi = d.iddoc
			)
AND d.iddoc NOT IN (SELECT PARALELO p
			FROM p.iddoc = d.iddoc)


////////////// 3 ///////////////////////////////

SELECT DISTINCT e.apellido ,  e.nombre ,  tmp.nromaterias
FROM ESTUDIANTE e , MATERIA m , ( SELECT idestu , COUNT (*) nromaterias
					FROM INSCRITO i
					HAVING COUNT (*) > 3
					GROUP BY idestu ) tmp
WHERE e.idestu = tmp.idestu
ORDER BY e.apellido

////////////////////////////////////////////////

////////////// 4 ///////////////////////////////

SELECT e.apellido ,  e.nombre ,  tmp.nrocreditos
FROM ESTUDIANTE e , ( SELECT idestu , sum (credito) nrocreditos
			FROM INSCRITO i , MATERIA m
			WHERE i.sigla = m.sigla
			GROUP BY idestu ) tmp
WHERE e.idestu = tmp.idestu
ORDER BY tmp.nrocreditos

////////////////////////////////////////////////