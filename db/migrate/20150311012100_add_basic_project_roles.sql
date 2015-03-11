
# Add the basic roles that every project needs

insert into role (custom_role, role, project_related, display_name) values (0,'project_creator',1,'Project Creator');
insert into role (custom_role, role, project_related, display_name) values (0,'project_owner',1,'Project Owner');
insert into role (custom_role, role, project_related, display_name) values (0,'project_member',1,'Project Member');
insert into schema_migration (version) values ('20150311012100');
