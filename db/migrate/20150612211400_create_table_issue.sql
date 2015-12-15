


create table issue (
id int not null auto_increment primary key,
alive tinyint(1),
name varchar(255),
description text,
created_by int not null,
created_at datetime,
updated_at timestamp
);


insert into schema_migration (version) values ('20150612211400');

