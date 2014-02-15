package ProjectTaskToDo::Schema::Result::Note;

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

ProjectTaskToDo::Schema::Result::Note

=cut

__PACKAGE__->table("note");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 active

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 creator_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 created

  data_type: 'datetime'
  is_nullable: 0

=head2 last_modified

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0

=head2 project_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 client_contact_person_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 client_organization_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 client_person_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 task_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 public

  data_type: 'char'
  default_value: 0
  is_nullable: 0
  size: 1

=head2 date_selected

  data_type: 'date'
  is_nullable: 1

=head2 title

  data_type: 'tinyblob'
  is_nullable: 1

=head2 body

  data_type: 'longblob'
  is_nullable: 1

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
  { data_type => "char", is_nullable => 1, size => 1 },
  "creator_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 0 },
  "created",
  { data_type => "datetime", is_nullable => 0 },
  "last_modified",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
  },
  "project_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 1 },
  "client_contact_person_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 1 },
  "client_organization_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 1 },
  "client_person_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 1 },
  "task_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 1 },
  "public",
  { data_type => "char", default_value => 0, is_nullable => 0, size => 1 },
  "date_selected",
  { data_type => "date", is_nullable => 1 },
  "title",
  { data_type => "tinyblob", is_nullable => 1 },
  "body",
  { data_type => "longblob", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2013-09-12 15:17:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:pvIgn5ZTz5/KqOCoEXZu3w


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
	date_selected => { data_type => 'date', inflate_datetime => 0 },
);

__PACKAGE__->belongs_to('creator' => 'ProjectTaskToDo::Schema::Result::Person', 'creator_id');
__PACKAGE__->belongs_to('client_organization' => 'ProjectTaskToDo::Schema::Result::Organization', 'client_organization_id');
__PACKAGE__->belongs_to('client_person' => 'ProjectTaskToDo::Schema::Result::Person', 'client_person_id');
__PACKAGE__->belongs_to('client_contact_person' => 'ProjectTaskToDo::Schema::Result::Person', 'client_contact_person_id');
__PACKAGE__->belongs_to('project' => 'ProjectTaskToDo::Schema::Result::Project', 'project_id');
__PACKAGE__->belongs_to('task' => 'ProjectTaskToDo::Schema::Result::Task', 'task_id');


__PACKAGE__->meta->make_immutable;
1;
