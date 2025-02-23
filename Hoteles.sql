use hoteles;

create table empleados(
DNI char(9) not null,
nombre varchar(20) not null,
constraint pk_empleados primary key (DNI)
);

create table actividades(
id_actividad tinyint not null auto_increment,
nombre varchar(40) not null,
constraint pk_actividades primary key (id_actividad)
);

create table agencias(
id_agencia smallint not null auto_increment,
nombre varchar(30) not null,
constraint pk_agencias primary key (id_agencia)
);

create table ciudades(
id_ciudad smallint not null auto_increment,
nombre varchar(20) not null,
constraint pk_ciudades primary key (id_ciudad)
);

create table cadenas_hoteleras(
id_cadena smallint not null auto_increment,
CIF char(9) unique not null,
nombre varchar(30) not null,
direccion_fiscal varchar(70),
constraint pk_cadenas_hoteleras primary key (id_cadena)
);

create table delegaciones(
id_agencia smallint not null,
numero smallint,
nombre varchar(30) not null,
id_ciudad smallint not null,
constraint pk_delegaciones primary key (id_agencia, numero),
constraint fk_delegaciones_agencias foreign key (id_agencia) references agencias(id_agencia),
constraint fk_delegaciones_ciudades foreign key (id_ciudad) references ciudades(id_ciudad)
);

create table hoteles(
id_ciudad smallint not null,
nombre varchar(30) not null,
categoria tinyint not null,
direccion varchar(70) not null,
telefono int,
id_cadena smallint null,
constraint pk_hoteles primary key (id_ciudad, nombre),
constraint fk_hoteles_ciudades foreign key (id_ciudad) references ciudades(id_ciudad),
constraint fk_hoteles_cadenas_hoteleras foreign key (id_cadena) references cadenas_hoteleras(id_cadena)
);

create table h_playa(
nombre varchar(30) not null,
playa_privada boolean not null,
alquilar_embarcaciones boolean not null,
id_ciudad smallint not null,
constraint pk_h_playa primary key (id_ciudad, nombre),
constraint fk_h_playa_hoteles foreign key (id_ciudad, nombre) references hoteles(id_ciudad, nombre),
);

create table h_montana(
nombre varchar(30) not null,
piscina boolean not null,
id_ciudad smallint not null,
constraint pk_h_montana primary key (id_ciudad, nombre),
constraint fk_h_montana_hoteles foreign key (id_ciudad, nombre) references hoteles(id_ciudad, nombre)
);

create table equivalencia(
id_equivalencia smallint not null auto_increment,
id_ciudad smallint not null,
nombre varchar(30) not null,
constraint pk_equivalencia primary key (id_equivalencia, id_ciudad, nombre),
constraint fk_equivalencia_hoteles foreign key (id_ciudad, nombre) references hoteles(id_ciudad, nombre)
);

create table organizar(
id_actividad tinyint not null,
id_ciudad smallint not null,
nombre varchar(30) not null,
calidad tinyint,
constraint pk_organizar primary key (id_actividad, id_ciudad, nombre),
constraint fk_organizar_hoteles foreign key (id_ciudad, nombre) references hoteles(id_ciudad, nombre),
constraint fk_organizar_actividades foreign key (id_actividad) references actividades(id_actividad)
);

create table asignar(
id_agencia smallint not null,
id_ciudad smallint not null,
nombre varchar(30) not null,
mes varchar(10),
cantidad smallint,
constraint pk_asignar primary key (id_agencia, id_ciudad, nombre, mes),
constraint fk_asignar_hoteles foreign key (id_ciudad, nombre) references hoteles(id_ciudad, nombre),
constraint fk_asignar_agencia foreign key (id_agencia) references agencias(id_agencia)
);

create table contratar(
DNI char(9) not null,
id_cadena smallint not null,
fecha date,
constraint pk_contratar primary key (DNI, id_cadena, fecha),
constraint fk_contratar_cadenas_hoteleras foreign key (id_cadena) references cadenas_hoteleras(id_cadena),
constraint fk_contratar_empleados foreign key (DNI) references empleados(DNI)
);

create table trabajar(
DNI char(9) not null,
id_ciudad smallint not null,
nombre varchar(30) not null,
fecha date,
constraint pk_trabajar primary key (DNI, id_ciudad, nombre, fecha),
constraint fk_trabajar_hoteles foreign key (id_ciudad, nombre) references hoteles(id_ciudad, nombre),
constraint fk_trabajar_empleados foreign key (DNI) references empleados(DNI)
);
