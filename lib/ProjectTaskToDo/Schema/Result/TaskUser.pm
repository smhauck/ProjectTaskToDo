package ProjectTaskToDo::Schema::Result::TaskUser;

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

ProjectTaskToDo::Schema::Result::TaskUser

=cut

__PACKAGE__->table("task_user");

=head1 ACCESSORS

=head2 task_user_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 task_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 user_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 role_id

  data_type: 'mediumint'
  is_nullable: 0

=head2 recorded

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "task_user_id",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "task_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 0 },
  "user_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 0 },
  "role_id",
  { data_type => "mediumint", is_nullable => 0 },
  "recorded",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
  },
);
__PACKAGE__->set_primary_key("task_user_id");
__PACKAGE__->add_unique_constraint("task_user_role", ["task_id", "user_id", "role_id"]);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2013-09-12 15:17:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:E6IoaxvcpIhZTxaLyWfrpQ


=head1 COPYRIGHT

Copyright (C) 2008 - 2014 William B. Hauck, http://wbhauck.com

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


__PACKAGE__->belongs_to(task => 'ProjectTaskToDo::Schema::Result::Task', 'task_id');
__PACKAGE__->belongs_to(user => 'ProjectTaskToDo::Schema::Result::Task', 'user_id');


__PACKAGE__->meta->make_immutable;
1;
