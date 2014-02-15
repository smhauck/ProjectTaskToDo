package ProjectTaskToDo::Schema::Result::Role;

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

ProjectTaskToDo::Schema::Result::Role

=cut

__PACKAGE__->table("role");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 custom_role

  data_type: 'integer'
  default_value: 1
  is_nullable: 0

=head2 role

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 capability

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 project_related

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

=head2 display_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 description

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "custom_role",
  { data_type => "integer", default_value => 1, is_nullable => 0 },
  "role",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "capability",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 1 },
  "project_related",
  { data_type => "tinyint", default_value => 0, is_nullable => 0 },
  "display_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "description",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2013-09-12 15:17:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:C4+z1+c7Ln2E39rTQJSFow


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


__PACKAGE__->has_many(map_user_role => 'ProjectTaskToDo::Schema::Result::UserRole' => 'role');


__PACKAGE__->meta->make_immutable;
1;
