drop trigger person_ai;
drop trigger person_au;

delimiter ;;

CREATE DEFINER=`projecttasktodo`@`localhost` trigger person_ai
after insert on person
for each row
begin
insert into user (id, active, username, full_name, contact_email, phone, registered) values (new.id, 1, new.username, new.full_name, new.office_email, new.mobile_phone, now());
end
;;


CREATE DEFINER=`projecttasktodo`@`localhost` trigger person_au
after update on person
for each row
begin
update user set active=new.active, username=new.username, full_name=new.full_name, contact_email=new.office_email, phone=new.mobile_phone where user.id=new.id;
end
;;

delimiter ;

insert into schema_migration (version) values ('20150307201900');
