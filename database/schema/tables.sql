-- table train_type
create table if not exists train_type
(
	id serial not null
		constraint train_type_pk
			primary key,
	type varchar(255) not null,
	surcharge integer default 0
);

alter table train_type owner to postgres;

create unique index if not exists train_type_id_uindex
	on train_type (id);

create unique index if not exists train_type_type_uindex
	on train_type (type);


-- table carriage_type
create table if not exists carriage_type
(
	id serial not null
		constraint carriage_type_pk
			primary key,
	type varchar(255) not null,
	surcharge integer default 0 not null
);

alter table carriage_type owner to postgres;

create unique index if not exists carriage_type_id_uindex
	on carriage_type (id);

create unique index if not exists carriage_type_type_uindex
	on carriage_type (type);


-- table carriage
create table if not exists carriage
(
	id serial not null
		constraint carriage_pk
			primary key,
	carriage_type_id integer not null
		constraint carriage_carriage_type_id_fk
			references carriage_type
				on delete set null
);

alter table carriage owner to postgres;

create unique index if not exists carriage_id_uindex
	on carriage (id);

create unique index if not exists carriage_id_uindex_2
	on carriage (id);


-- table destination
create table if not exists destination
(
	id serial not null
		constraint destination_pk
			primary key,
	name varchar(255) not null
);

alter table destination owner to postgres;

create unique index if not exists destination_id_uindex
	on destination (id);


-- table address
create table if not exists address
(
	id serial not null
		constraint address_pk
			primary key,
	country varchar(255) not null,
	region varchar(255) not null,
	place varchar(255) not null,
	details varchar(255) not null,
	street varchar(255) not null
);

alter table address owner to postgres;

create table if not exists passenger
(
	id serial not null
		constraint passenger_pk
			primary key,
	phone_number varchar(15),
	first_name varchar(255) not null,
	last_name varchar(255) not null,
	middle_name varchar(255),
	address_id integer
		constraint passenger_address_id_fk
			references address
);

alter table passenger owner to postgres;

create unique index if not exists passenger_id_uindex
	on passenger (id);

create unique index if not exists address_id_uindex
	on address (id);


-- table destination_edge
create table if not exists destination_edge
(
	id serial not null
		constraint destination_edge_pk
			primary key,
	destination_from_id integer not null
		constraint destination_edge_destination_from_id_fk
			references destination,
	destination_to_id integer not null
		constraint destination_edge_destination_to_id_fk
			references destination,
	distance double precision not null
);

alter table destination_edge owner to postgres;

create unique index if not exists destination_edge_id_uindex
	on destination_edge (id);


-- table path
create table if not exists path
(
	id serial not null
		constraint path_route_pk
			primary key,
	cost_per_km double precision not null
);

alter table path owner to postgres;

create unique index if not exists path_route_id_uindex
	on path (id);


-- table path_destination_edge
create table if not exists path_destination_edge
(
	id serial not null
		constraint path_destination_pk
			primary key,
	path_id integer not null
		constraint path_destination_path_id_fk
			references path,
	position integer not null,
	destination_edge_id integer not null
		constraint path_destination_edge_destination_edge_id_fk
			references destination_edge
);

alter table path_destination_edge owner to postgres;

create unique index if not exists path_destination_id_uindex
	on path_destination_edge (id);


-- table locomotive
create table if not exists locomotive
(
	id serial not null
		constraint locomotive_pk
			primary key
);

alter table locomotive owner to postgres;


-- table train
create table if not exists train
(
	id serial not null
		constraint train_pk
			primary key,
	train_type_id integer not null
		constraint train_train_type_id_fk
			references train_type
				on delete set null,
	number integer not null,
	locomotive_id integer not null
		constraint train_locomotive_id_fk
			references locomotive
);

alter table train owner to postgres;

create unique index if not exists train_id_uindex
	on train (id);

create unique index if not exists train_number_uindex
	on train (number);


-- table departure
create table if not exists departure
(
	id serial not null
		constraint departure_pk
			primary key,
	train_id integer not null
		constraint departure_fk
			references train,
	departure_datetime timestamp not null,
	arrival_datetime timestamp not null,
	path_id integer not null
		constraint departure_path_id_fk
			references path
);

alter table departure owner to postgres;

create unique index if not exists departure_id_uindex
	on departure (id);


-- table ticket
create table if not exists ticket
(
	id serial not null
		constraint order_pk
			primary key,
	passenger_id integer not null
		constraint order_passenger_id_fk
			references passenger,
	departure_id integer not null
		constraint order_departure_id_fk
			references departure,
	carriage_number integer not null,
	surcharge_for_urgency double precision default 0,
	seat_number integer
);

alter table ticket owner to postgres;

create unique index if not exists order_id_uindex
	on ticket (id);


-- table train_carriage
create table if not exists train_carriage
(
	id serial not null
		constraint train_carriage_pk
			primary key,
	train_id integer not null
		constraint train_carriage_train_id_fk
			references train,
	carriage_id integer not null
		constraint train_carriage_carriage_id_fk
			references carriage,
	position integer not null
);

alter table train_carriage owner to postgres;

create unique index if not exists train_carriage_int_uindex
	on train_carriage (id);

create unique index if not exists locomotive_id_uindex
	on locomotive (id);

