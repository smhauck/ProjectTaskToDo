
create table meeting (
	id int not null auto_increment primary key,
	scheduled datetime,
	name varchar(255),
	subject varchar(255),
	host int,
	description text,
	minutes text,
	created_at datetime,
	updated_at timestamp
);



insert into schema_migration (version) values ('20150612210800');
