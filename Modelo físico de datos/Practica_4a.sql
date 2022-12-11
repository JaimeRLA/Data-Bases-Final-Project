CREATE TABLE Centrales
(
  Denom VARCHAR(50) NOT NULL,
  DirPostal NUMERIC(5,0) NOT NULL,
  Latitud NUMERIC(12,10) NOT NULL,
  Longitud NUMERIC(13,10) NOT NULL,
  CuentaTwitter VARCHAR(50) NOT NULL,
  Whatsapp VARCHAR(13) NOT NULL,
  CodCentral VARCHAR(6) NOT NULL,
  Dominio VARCHAR(20) NOT NULL,
  NombreUsuario VARCHAR(30) NOT NULL,
  PRIMARY KEY (CodCentral)
);

CREATE TABLE CentralesHidroelectricas
(
  VolMax NUMERIC(9,2) NOT NULL,
  Nº_turbinas NUMERIC(7,0) NOT NULL,
  CodCentral VARCHAR(6) NOT NULL,
  PRIMARY KEY (CodCentral),
  FOREIGN KEY (CodCentral) REFERENCES Centrales(CodCentral)
);

CREATE TABLE CentralesSolares
(
  SuperficiePaneles NUMERIC(9,2) NOT NULL,
  HorasRadiacion NUMERIC(9,2) NOT NULL,
  CodCentral VARCHAR(6) NOT NULL,
  PRIMARY KEY (CodCentral),
  FOREIGN KEY (CodCentral) REFERENCES Centrales(CodCentral)
);

CREATE TABLE CentralesNucleares
(
  NumReactores NUMERIC(2,0) NOT NULL,
  MineralConsumido NUMERIC(9,2) NOT NULL,
  CodCentral VARCHAR(6) NOT NULL,
  PRIMARY KEY (CodCentral),
  FOREIGN KEY (CodCentral) REFERENCES Centrales(CodCentral)
);

CREATE TABLE CentralesTermicas
(
  GasNaturalConsumido NUMERIC(9,2) NOT NULL,
  VolAcumuladoCO2Emititdo NUMERIC(9,2) NOT NULL,
  TAcumuladoInyeccionEnergiaEnRedElectrica NUMERIC(9,2) NOT NULL,
  TipoCiclo VARCHAR(20) NOT NULL,
  CodCentral VARCHAR(6) NOT NULL,
  PRIMARY KEY (CodCentral),
  FOREIGN KEY (CodCentral) REFERENCES Centrales(CodCentral)
);

CREATE TABLE CentralesEolicas
(
  TAcumuladoViento NUMERIC(9,2) NOT NULL,
  CodCentral VARCHAR(6) NOT NULL,
  PRIMARY KEY (CodCentral),
  FOREIGN KEY (CodCentral) REFERENCES Centrales(CodCentral)
);

CREATE TABLE Suministrador
(
  Nombre VARCHAR(30) NOT NULL,
  País VARCHAR(20) NOT NULL,
  NIF VARCHAR(9) NOT NULL,
  PRIMARY KEY (NIF)
);

CREATE TABLE Estaciones
(
  CodEstacion VARCHAR(6) NOT NULL,
  PRIMARY KEY (CodEstacion)
);

CREATE TABLE Responsable
(
  NIF VARCHAR(9) NOT NULL,
  Nombre VARCHAR(20) NOT NULL,
  Apell1 VARCHAR(20) NOT NULL,
  Apell2 VARCHAR(20) NOT NULL,
  DenomCargo VARCHAR(30) NOT NULL,
  Calle VARCHAR(30) NOT NULL,
  Nº NUMERIC(4,0) NOT NULL,
  Provincia VARCHAR(20) NOT NULL,
  País VARCHAR(20) NOT NULL,
  Letra CHAR(1),
  Piso NUMERIC(3,0),
  IdPais NUMERIC(3,0) NOT NULL,
  IdRegion VARCHAR(3) NOT NULL,
  NumTlf NUMERIC(7,0) NOT NULL,
  NombreUsuarioCU VARCHAR(30) NOT NULL,
  DominioCU VARCHAR(20) NOT NULL,
  NombreUsuarioCI VARCHAR(30) NOT NULL,
  DominioCI VARCHAR(20) NOT NULL,
  CodCentral VARCHAR(6) NOT NULL,
  PRIMARY KEY (NIF),
  FOREIGN KEY (CodCentral) REFERENCES Centrales(CodCentral)
);

SAVEPOINT postcreateresponsable;

CREATE TABLE EmpresaTransporte
(
  Nombre VARCHAR(20) NOT NULL,
  NIF VARCHAR(9) NOT NULL,
  CodAutoriz VARCHAR(7) NOT NULL,
  ValidezAutoriz DATE NOT NULL,
  NombreUsuario VARCHAR(30) NOT NULL,
  Dominio VARCHAR(20) NOT NULL,
  PRIMARY KEY (NIF)
);

CREATE TABLE EstacionesPrimarias
(
  NombreEstacion VARCHAR(35) NOT NULL,
  NumTransformadores NUMERIC(4,0) NOT NULL,
  CodEstacion VARCHAR(6) NOT NULL,
  PRIMARY KEY (CodEstacion),
  FOREIGN KEY (CodEstacion) REFERENCES Estaciones(CodEstacion)
);

CREATE TABLE Provincias
(
  CodProvincia VARCHAR(5) NOT NULL,
  Nombre VARCHAR(30) NOT NULL,
  PRIMARY KEY (CodProvincia)
);

CREATE TABLE Alertas
(
  CodAlerta VARCHAR(8) NOT NULL,
  Tipo CHAR(1) NOT NULL,
  Intervencion VARCHAR(7) NOT NULL,
  Latitud NUMERIC(10,8) NOT NULL,
  Longitud NUMERIC(11,8) NOT NULL,
  CodCentral VARCHAR(6) NOT NULL,
  PRIMARY KEY (CodAlerta, CodCentral),
  FOREIGN KEY (CodCentral) REFERENCES Centrales(CodCentral)
);

CREATE TABLE CentralesFotovoltaicas
(
  NumBaterias NUMERIC(5,0) NOT NULL,
  CodCentral VARCHAR(6) NOT NULL,
  PRIMARY KEY (CodCentral),
  FOREIGN KEY (CodCentral) REFERENCES CentralesSolares(CodCentral)
);

CREATE TABLE CentralesTermodinamicas
(
  NumDepositosAgua NUMERIC(4,0) NOT NULL,
  CodCentral VARCHAR(6) NOT NULL,
  PRIMARY KEY (CodCentral),
  FOREIGN KEY (CodCentral) REFERENCES CentralesSolares(CodCentral)
);

CREATE TABLE TlfResponsable
(
  IdPais NUMERIC(3,0) NOT NULL,
  IdRegion VARCHAR(3) NOT NULL,
  NumTlf NUMERIC(7,0) NOT NULL,
  NIF VARCHAR(9) NOT NULL,
  PRIMARY KEY (IdPais, IdRegion, NumTlf),
  FOREIGN KEY (NIF) REFERENCES Responsable(NIF)
);

CREATE TABLE TlfEmpTte
(
  IdRegion VARCHAR(3) NOT NULL,
  IdPais NUMERIC(3,0) NOT NULL,
  NumTlf NUMERIC(7,0) NOT NULL,
  NIF VARCHAR(9) NOT NULL,
  PRIMARY KEY (IdRegion, IdPais, NumTlf),
  FOREIGN KEY (NIF) REFERENCES EmpresaTransporte(NIF)
);

CREATE TABLE Propietarios
(
  NIF VARCHAR(9) NOT NULL,
  PRIMARY KEY (NIF)
);

CREATE TABLE Productores
(
  CodAutoriz VARCHAR(6),
  Denom VARCHAR(20) NOT NULL,
  Calle VARCHAR(20) NOT NULL,
  Nº NUMERIC(4,0) NOT NULL,
  Provincia VARCHAR(20) NOT NULL,
  Letra CHAR(1),
  Piso NUMERIC(3,0),
  País VARCHAR(20) NOT NULL,
  FechaValidezCodAutoriz DATE NOT NULL,
  FechaCaducidadCodAutoriz DATE NOT NULL,
  Tipo VARCHAR(20),
  NIF VARCHAR(9) NOT NULL,
  PRIMARY KEY (NIF),
  FOREIGN KEY (NIF) REFERENCES Propietarios(NIF)
);

SAVEPOINT postcreateproductores;

CREATE TABLE CompañiasElectricas
(
  NumEmpleados NUMERIC(6,0) NOT NULL,
  NIF VARCHAR(9) NOT NULL,
  PRIMARY KEY (NIF),
  FOREIGN KEY (NIF) REFERENCES Productores(NIF)
);

CREATE TABLE NoProductores
(
  Tipo VARCHAR(20) NOT NULL,
  Denom VARCHAR(50) NOT NULL,
  NIF VARCHAR(9) NOT NULL,
  PRIMARY KEY (NIF),
  FOREIGN KEY (NIF) REFERENCES Propietarios(NIF)
);

CREATE TABLE Aerogeneradores
(
  Latitud NUMERIC(10,8) NOT NULL,
  Longitud NUMERIC(11,8) NOT NULL,
  VMaxRotacion NUMERIC(9,2) NOT NULL,
  CodAerogenerador VARCHAR(6) NOT NULL,
  CodCentral VARCHAR(6) NOT NULL,
  PRIMARY KEY (CodAerogenerador, CodCentral),
  FOREIGN KEY (CodCentral) REFERENCES CentralesEolicas(CodCentral)
);

CREATE TABLE Suministrar
(
  NIF VARCHAR(9) NOT NULL,
  NIF VARCHAR(9) NOT NULL,
  PRIMARY KEY (NIF, NIF),
  FOREIGN KEY (NIF) REFERENCES EmpresaTransporte(NIF),
  FOREIGN KEY (NIF) REFERENCES Suministrador(NIF)
);

CREATE TABLE ProveerUranio
(
  FechaSuministro DATE NOT NULL,
  Cantidad NUMERIC(9,2) NOT NULL,
  NIF VARCHAR(9) NOT NULL,
  CodCentral VARCHAR(6) NOT NULL,
  PRIMARY KEY (NIF, CodCentral),
  FOREIGN KEY (NIF) REFERENCES Suministrador(NIF),
  FOREIGN KEY (CodCentral) REFERENCES CentralesNucleares(CodCentral)
);

CREATE TABLE Pertenecer
(
  NIF VARCHAR(9) NOT NULL,
  CodCentral VARCHAR(6) NOT NULL,
  PRIMARY KEY (NIF, CodCentral),
  FOREIGN KEY (NIF) REFERENCES Propietarios(NIF),
  FOREIGN KEY (CodCentral) REFERENCES Centrales(CodCentral)
);

CREATE TABLE EntregarElectricidad
(
  CantidadEnergía NUMERIC(9,2) NOT NULL,
  CodEstacion VARCHAR(6) NOT NULL,
  NIF VARCHAR(9) NOT NULL,
  PRIMARY KEY (CodEstacion, NIF),
  FOREIGN KEY (CodEstacion) REFERENCES EstacionesPrimarias(CodEstacion),
  FOREIGN KEY (NIF) REFERENCES Productores(NIF)
);

CREATE TABLE ZonasServicio
(
  ConsumoMedio NUMERIC(9,2) NOT NULL,
  NumConsumidores NUMERIC(8,0) NOT NULL,
  CodZonaServicio VARCHAR(6) NOT NULL,
  CodProvincia VARCHAR(6) NOT NULL,
  PRIMARY KEY (CodZonaServicio),
  FOREIGN KEY (CodProvincia) REFERENCES Provincias(CodProvincia)
);

CREATE TABLE Consumidor
(
  NIF VARCHAR(9) NOT NULL,
  Tipo VARCHAR(20) NOT NULL,
  CodZonaServicio VARCHAR(6) NOT NULL,
  PRIMARY KEY (NIF),
  FOREIGN KEY (CodZonaServicio) REFERENCES ZonasServicio(CodZonaServicio)
);

CREATE TABLE CorreoProductor
(
  NombreUsuario VARCHAR(30) NOT NULL,
  Dominio VARCHAR(20) NOT NULL,
  NIF VARCHAR(9) NOT NULL,
  PRIMARY KEY (NombreUsuario,Dominio),
  FOREIGN KEY (NIF) REFERENCES Productores(NIF),
);

CREATE TABLE TlfProductor
(
  IdPais NUMERIC(3,0) NOT NULL,
  IdRegion VARCHAR(3) NOT NULL,
  NumTlf NUMERIC(7,0) NOT NULL,
  NIF VARCHAR(9) NOT NULL,
  PRIMARY KEY (IdPais, IdRegion, NumTlf),
  FOREIGN KEY (NIF) REFERENCES Productores(NIF)
);

CREATE TABLE RedesDistribucion
(
  NumRed VARCHAR(6) NOT NULL,
  CodEstacion VARCHAR(6) NOT NULL,
  IntercambiarEnergia_NumRed VARCHAR(6),
  PRIMARY KEY (NumRed),
  FOREIGN KEY (CodEstacion) REFERENCES EstacionesPrimarias(CodEstacion),
  FOREIGN KEY (IntercambiarEnergia_NumRed) REFERENCES RedesDistribucion(NumRed)
);

CREATE TABLE Linea
(
  NumLinea VARCHAR(6) NOT NULL,
  NumRed VARCHAR(6) NOT NULL,
  PRIMARY KEY (NumLinea, NumRed),
  FOREIGN KEY (NumRed) REFERENCES RedesDistribucion(NumRed)
);

CREATE TABLE Subestaciones
(
  NombreSubestacion VARCHAR(35) NOT NULL,
  CodEstacion VARCHAR(6) NOT NULL,
  NumLinea VARCHAR(6) NOT NULL,
  NumRed VARCHAR(6) NOT NULL,
  PRIMARY KEY (CodEstacion),
  FOREIGN KEY (CodEstacion) REFERENCES Estaciones(CodEstacion),
  FOREIGN KEY (NumLinea, NumRed) REFERENCES Linea(NumLinea, NumRed)
);

CREATE TABLE Distribuir
(
  CodEstacion VARCHAR(6) NOT NULL,
  CodZonaServicio VARCHAR(6) NOT NULL,
  PRIMARY KEY (CodEstacion, CodZonaServicio),
  FOREIGN KEY (CodEstacion) REFERENCES Subestaciones(CodEstacion),
  FOREIGN KEY (CodZonaServicio) REFERENCES ZonasServicio(CodZonaServicio)
);

CREATE TABLE SerPropietario
(
  NumRed VARCHAR(6) NOT NULL,
  NIF VARCHAR(9) NOT NULL,
  PRIMARY KEY (NumRed, NIF),
  FOREIGN KEY (NumRed) REFERENCES RedesDistribucion(NumRed),
  FOREIGN KEY (NIF) REFERENCES CompañiasElectricas(NIF)
);

CREATE TABLE ProduccionEnergia
(
  Fecha DATE NOT NULL,
  Hora VARCHAR(5) NOT NULL,
  Cantidad NUMERIC(9,2) DEFAULT 0,
  CodCentral VARCHAR(6) NOT NULL,
  PRIMARY KEY (Fecha, Hora, CodCentral),
  FOREIGN KEY (CodCentral) REFERENCES Centrales(CodCentral)
);

CREATE TABLE RESIDUOS
(
  Fecha DATE NOT NULL,
  Hora VARCHAR(5) NOT NULL,
  Cantidad NUMERIC(9,2) DEFAULT 0,
  CodCentral VARCHAR(6) NOT NULL,
  PRIMARY KEY (Fecha, Hora, CodCentral),
  FOREIGN KEY (CodCentral) REFERENCES Centrales(CodCentral)
);

CREATE TABLE ALMACENAJEAGUA
(
  Fecha DATE NOT NULL,
  Hora VARCHAR(5) NOT NULL,
  Cantidad NUMERIC(9,2) DEFAULT 0,
  CodCentral VARCHAR(6) NOT NULL,
  PRIMARY KEY (Fecha, Hora, CodCentral),
  FOREIGN KEY (CodCentral) REFERENCES Centrales(CodCentral)
);

COMMIT;
