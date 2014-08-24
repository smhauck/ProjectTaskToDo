
create table product_status_type (
	id int not null auto_increment primary key,
	alive integer not null default '1',
	created_at datetime,
	updated_at datetime,
	title varchar(255),
	description text
);

create table sprint_status_type (
	id int not null auto_increment primary key,
	alive integer not null default '1',
	created_at datetime,
	updated_at datetime,
	title varchar(255),
	description text
);

create table story_status_type (
	id int not null auto_increment primary key,
	alive integer not null default '1',
	created_at datetime,
	updated_at datetime,
	title varchar(255),
	description text
);


create table product (
	id int not null auto_increment primary key,
	created_at datetime,
	updated_at datetime,
	product_status_type integer not null default 1,
	title varchar(255),
	description text
);

create table sprint (
	id int not null auto_increment primary key,
	created_at datetime,
	updated_at timestamp,
	sprint_status_type integer not null default 1,
	start_date date,
	end_date date,
	title varchar(255),
	description text
);

create table story (
	id int not null auto_increment primary key,
	created_at datetime,
	updated_at datetime,
	story_status_type integer not null default 1,
	requestor_id int,
	points decimal(10,2),
	hours decimal(10,2),
	product_id integer,
	sprint_id integer,
	title varchar(255),
	description text
);

alter table task change column task_description description text;
alter table task change column task_status_id task_status_type_id integer not null default 1;
alter table task add column created_at datetime after task_id;
alter table task add column updated_at datetime after created_at;
alter table task add column points decimal(10,2) after updated_at;
alter table task add column hours decimal(10,2) after points;
alter table task add column product_id integer after hours;
alter table task add column sprint_id integer after product_id;
alter table task add column story_id integer not null after sprint_id;


insert into schema_migration (version) values ('20140715105300');
