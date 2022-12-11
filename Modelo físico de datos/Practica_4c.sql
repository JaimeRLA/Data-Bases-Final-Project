--centrales:
insert into centrales values('Kashiwazaki-Kariwa',20098,37.2478928,138.37092,'@kariwacentral_','+81 090182793',8212.37,'C-0001','@gmail.com','kariwa');
insert into centrales values('Hanul',19827,37.7872365,129.827163,'@hanul.central','+82 738276839 ',5908.1,'C-0002','@gmail.com','hanul');
insert into centrales values('Aldeadávila',28268,41.3874876,6.877263,'@aldeadavila__','+34 639829387',3789.28,'C-0003','@hotmail.es','centralaldeadavila');
insert into centrales values('Malacas',15368,7.0827398,100.011828,'@malacascentral','+06 638982739',2807,'C-0004','@gmail.com','malacascentral');
insert into centrales values('Bhatla',28922,27.986653,51.9898283,'@bhatla_central','+55 909728364',3267.6,'C-0005','@hotmail.com','bhatlacentral');
insert into centrales values('Jiuquan',29327,39.45673,120.873202,'@central.jiuquan','+86 192839878',2108.82,'C-0006','@gmail.com','centraljiuquan');
insert into centrales values('Xutulu',28921,72.9887263 ,90.873762,'@xutulucentral.89','+62 782383946',3451.88,'C-0007','@gmail.com','xutulucentral');
--aerogen:
insert into aerogeneradores values(72.6326765,108.276373,7623.28,'A-0001','C-0006');
insert into aerogeneradores values(72.6576473,108.145261,7598.79,'A-0002','C-0006');
insert into aerogeneradores values(72.5923768,108.188739,7602.1,'A-0003','C-0006');
insert into aerogeneradores values(72.6387683,107.989252,7209.92,'A-0004','C-0006'); 
--alertas:
insert into alertas values('AL-00001','H','IN-0002',41.5206081,-5.9718162,'C-0003');
insert into alertas values('AL-00002','H','IN-0002',41.5189273,-5.96789294,'C-0003');
insert into alertas values('AL-00003','H','IN-0021',41.4983828,-5.94998271,'C-0003');
insert into alertas values('AL-00001','E','IN-0008',89.8728377,63.6273772,'C-0006');
insert into alertas values('AL-00002','E','IN-0001',88.8732732,63.9718162,'C-0006');
insert into alertas values('AL-00001','T','IN-0017',26.7673468,101.767329,'C-0004');
insert into alertas values('AL-00001','S','IN-0014',67.8762647,-82.1718162,'C-0003');
insert into alertas values('AL-00002','S','IN-0001',67.8298399,-82.1563773,'C-0003');
insert into alertas values('AL-00001','S','IN-0108',43.7783681,95.8732872,'C-0003');
--produccionenergia:
insert into produccionenergia values('09-12-2022','18:00',21.3,'C-0002');
insert into produccionenergia values('09-12-2022','19:00',20.3,'C-0002');
insert into produccionenergia values('09-12-2022','20:00',19.3,'C-0002');
insert into produccionenergia values('09-11-2022','21:00',0,'C-0002');
insert into produccionenergia values('11-11-2022','10:00',18.9,'C-0002');
--pertenecer(propietarios-centrales):
insert into pertenecer values('84728834D','C-0002');
insert into pertenecer values('84728834D','C-0005');
insert into pertenecer values('79352082G','C-0001');

update pertenecer
set nif='56782381M'
where codcentral='C-0001';
--entregarelectricidad:
select * from entregarelectricidad;

insert into entregarelectricidad values(653.2,'E-0001','84728834D'); 
insert into entregarelectricidad values(653.2,'E-0001','79352082G');

savepoint postinsertentregarelectricidad;

delete from entregarelectricidad
where nif='84728834D';





savepoint postcentrales; --QUITAR PRODUCCION EN CENTRALES!!!!!!!


commit;