select * from centraleseolicas c
inner join produccionenergia pe on pe.codcentral = c.codcentral
where extract (month from pe.fecha)=extract(month from '2022-12-09') and extract(year from pe.fecha ) = extract (year from '2022-12-09');

SAVEPOINT PREROLES;

CREATE ROLE PROPIETARIO;
GRANT CONNECT TO PROPIETARIO;

CREATE ROLE PRODUCTOR;
GRANT INSERT,UPDATE,DELETE ON PRODUCCIONENERGIA TO PRODUCTOR;
GRANT INSERT,UPDATE,DELETE ON CENTRALES TO PRODUCTOR;

CREATE ROLE RESPONSABLE;
GRANT RESOURCE TO RESPONSABLE;

SAVEPOINT POSTROLES;

CREATE VIEW productor(Denominacion,Tipo)
AS
SELECT Denom,Tipo
FROM productores;

--???? 
CREATE VIEW vistacentrales(Nombre,Propietario,Produccion,Pais)
AS
SELECT c.denom,prop.denom,pr.cantidad,c.pais FROM centrales c INNER JOIN productores prop ON c.codcentral=

COMMIT;