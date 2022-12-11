--I
select pr.denom,pr.codautoriz,pr.calle,pr.nº,pr.provincia,pr.letra,pr.piso,pr.fechavalidezcodautoriz,pr.fechacaducidadcodautoriz,pr.país,tipo,pr.nif,count(p.nif) as "NumCentrales" from pertenecer p
inner join productores pr on pr.nif = p.nif
where pr.tipo = 'S.A.' and pr.fechacaducidadcodautoriz > sysdate group by pr.denom,pr.codautoriz,pr.calle,pr.nº,pr.provincia,pr.letra,pr.piso,pr.fechavalidezcodautoriz,pr.fechacaducidadcodautoriz,pr.país,tipo,pr.nif
having count(p.nif) > 1;

--II
select avg(p.cantidad),c.codcentral from centralesnucleares c inner join produccionenergia p on pe.codcentral=c.codcentral  
where extract(month from p.fecha) = extract(month from sysdate) and extract(year from p.fecha) = extract(year from sysdate)
group by c.codcentral having avg(cantidad) > all(select avg(cantidad) from produccionenergia);

--III                                               
create or replace procedure media_produccionC(v_codcentral in VARCHAR2) is 
cursor prod is 
select avg(cantidad) from produccionenergia where codcentral=v_codcentral;
cant produccionenergia.cantidad%type;
begin
open prod;
loop
    fetch prod into cant;
    exit when prod%notfound;
    DBMS_OUTPUT.PUT_LINE(cant);
end loop;
close prod;
end;

select * from produccionenergia;

call media_produccionC('C-0001');


create or replace procedure media_residuos(v_codcentral in VARCHAR2) is 
cursor prod is 
select avg(cantidad) from residuos where codcentral=v_codcentral;
cant residuos.cantidad%type;
begin
open prod;
loop
    fetch prod into cant;
    exit when prod%notfound;
    DBMS_OUTPUT.PUT_LINE(cant);
end loop;
close prod;
end;

select * from residuos;

call media_residuos('C-0002');

savepoint preceduremedia;


create or replace procedure media_aguaA(v_codcentral in VARCHAR2) is 
cursor prod is 
select avg(cantidad) from residuos where codcentral=v_codcentral;
c almacenajeagua.cantidad%type;
begin
open prod;
loop
    fetch prod into c;
    exit when prod%notfound;
    DBMS_OUTPUT.PUT_LINE(c);
end loop;
close prod;
end;

insert into almacenajeagua values('09-12-2022','18:00',21.3,'C-0003');
insert into almacenajeagua values('09-12-2022','19:00',50.3,'C-0003');
insert into almacenajeagua values('09-12-2022','20:00',12.8,'C-0003');

call media_aguaA('C-0003');


create or replace procedure max_aguaA(v_codcentral in VARCHAR2) is 
cursor prod is 
select max(cantidad) from residuos where codcentral=v_codcentral;
c almacenajeagua.cantidad%type;
begin
open prod;
loop
    fetch prod into c;
    exit when prod%notfound;
    DBMS_OUTPUT.PUT_LINE(c);
end loop;
close prod;
end;

call max_aguaA('C-0003');

commit;

--IV                                                 
create or replace trigger alerta_nuclear
after insert on alertas
declare cursor alertas_n is 
select tipo,codalerta,codcentral,intervencion,latitud,longitud from alertas
where tipo='N';
tp alertas.tipo%type;
ca alertas.codalerta%type;
cc alertas.codcentral%type;
interv alertas.intervencion%type;
lat alertas.latitud%type;
lon alertas.longitud%type;
begin
if inserting then
open alertas_n;
loop
    fetch alertas_n into tp,ca,cc,interv,lat,lon;
    exit when alertas_n%notfound;
    dbms_output.put_line(tp);
    dbms_output.put_line(ca);
    dbms_output.put_line(cc);
    dbms_output.put_line(interv);
    dbms_output.put_line(lat);
    dbms_output.put_line(lon);   
end loop;
close alertas_n;
end if;
end; 

insert into alertas values('AL-00029','N','IN-0002',41.5206081,-5.9718162,'C-0001');
delete alertas where tipo='N' and codalerta='AL-00029';

savepoint post4iv;

--V
declare
    est_prim varchar(6) := &valor;
    central varchar(6);
    cursor curs is
    select p.codcentral into central from propietarios pr 
    inner join pertenecer p on p.nif = pr.nif
    inner join entregarelectricidad e on pr.nif = e.nif
    where e.codestacion = est_prim;
    cc centrales.codcentral%type;
begin
    open curs;
    loop
        fetch curs into cc;
        exit when curs%notfound;
        dbms_output.put_line('Las centrales conectadas a la estacion primaria ' || est_prim || ' son: ' || cc);
    end loop;
    close curs;
end;

--VI                                                     por hacer
declare
    aser varchar(6) := &valor1;
    prov varchar(6) := &valor2;
    est varchar(6);
    subest varchar(6);
    l varchar(6);
begin
    select ses.codestacion into est from subestaciones ses 
    inner join distribuir d on d.codestacion=ses.codestacion
    inner join entregarelectricidad e on pr.nif = e.nif
    where e.codestacion=;
    dbms_output.put_line('anacho ' || est_prim || ' son:' || central);
end;

commit;