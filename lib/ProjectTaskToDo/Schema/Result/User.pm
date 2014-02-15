package ProjectTaskToDo::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "PK::Auto");

=head1 NAME

ProjectTaskToDo::Schema::Result::User

=cut

__PACKAGE__->table("user");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 active

  data_type: 'tinyint'
  default_value: 1
  extra: {unsigned => 1}
  is_nullable: 0

=head2 username

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=head2 password

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 32

=head2 full_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 contact_email

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 phone

  data_type: 'varchar'
  is_nullable: 1
  size: 25

=head2 department

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 registered

  data_type: 'datetime'
  is_nullable: 1

=head2 last_modified

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "active",
  {
    data_type => "tinyint",
    default_value => 1,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "username",
  { data_type => "varchar", is_nullable => 0, size => 32 },
  "password",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 32 },
  "full_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "contact_email",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "phone",
  { data_type => "varchar", is_nullable => 1, size => 25 },
  "department",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "registered",
  { data_type => "datetime", is_nullable => 1 },
  "last_modified",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("username_unique", ["username"]);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2013-09-12 15:17:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:9YGSLxlboVtTIlMdjwRhGw


=head1 LICENSE

This file is part of ProjectTaskToDo.

ProjectTaskToDo is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

ProjectTaskToDo is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with ProjectTaskToDo.  If not, see <http://www.gnu.org/licenses/>.

=cut


__PACKAGE__->add_columns(
	registered => { data_type => 'datetime', inflate_datetime => 0 },
	last_modified => { data_type => 'datetime', inflate_datetime => 0 }
);

__PACKAGE__->has_many(project_users => 'ProjectTaskToDo::Schema::Result::ProjectUser', 'project_user_user_id');
__PACKAGE__->has_many(map_user_role => 'ProjectTaskToDo::Schema::Result::UserRole', 'user');
__PACKAGE__->many_to_many(roles => 'map_user_role', 'role');
__PACKAGE__->has_many(notifications => 'ProjectTaskToDo::Schema::Result::Notification', 'user_to_notify');
__PACKAGE__->has_many(taskusers => 'ProjectTaskToDo::Schema::Result::TaskUser', 'user_id');
__PACKAGE__->has_many('time_palette' => 'ProjectTaskToDo::Schema::Result::TimePaletteProject', 'user_id');


__PACKAGE__->meta->make_immutable;
1;
