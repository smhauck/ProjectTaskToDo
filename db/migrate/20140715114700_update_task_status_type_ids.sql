update task_status_type set name='Not Started' where id=1;
update task_status_type set name='In Progress' where id=2;
update task_status_type set name='Product Owner Review' where id=3;
update task_status_type set name='Client Review' where id=4;
update task_status_type set name='Wait for Production Deployment' where id=5;
insert into task_status_type (name, living) values ('Production Check',1);
insert into task_status_type (name, living) values ('Complete',0);
insert into task_status_type (name, living) values ('Cancelled',0);
insert into task_status_type (name, living) values ('Deleted',0);
insert into task_status_type (name, living) values ('Deferred',1);



update task set task_status_type_id=10 where task_status_type_id=5;
update task set task_status_type_id=8 where task_status_type_id=4;
update task set task_status_type_id=9 where task_status_type_id=3;
update task set task_status_type_id=7 where task_status_type_id=2;
update task set task_status_type_id=2 where task_status_type_id=1;

insert into schema_migration (version) values ('20140715114700');
