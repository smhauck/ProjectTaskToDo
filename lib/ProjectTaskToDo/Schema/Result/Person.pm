package ProjectTaskToDo::Schema::Result::Person;

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

ProjectTaskToDo::Schema::Result::Person

=cut

__PACKAGE__->table("person");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 username

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=head2 full_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 first_name

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 last_name

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 office_phone

  data_type: 'varchar'
  is_nullable: 1
  size: 25

=head2 office_floor

  data_type: 'varchar'
  is_nullable: 1
  size: 25

=head2 office_address1

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 office_address2

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 office_address3

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 office_city

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 office_state

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 office_postal_code

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 offie_country

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 mobile_phone

  data_type: 'varchar'
  is_nullable: 1
  size: 25

=head2 skype_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 aim_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 timezone

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

=head2 active

  data_type: 'char'
  default_value: 1
  is_nullable: 0
  size: 1

=head2 office_email

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 office_department

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 headshot

  data_type: 'mediumblob'
  is_nullable: 1

=head2 office_country

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 job_title_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 job_title

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 hire_date_text

  data_type: 'varchar'
  is_nullable: 1
  size: 15

=head2 admin_notes

  data_type: 'longtext'
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
  "username",
  { data_type => "varchar", is_nullable => 0, size => 32 },
  "full_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "first_name",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "last_name",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "office_phone",
  { data_type => "varchar", is_nullable => 1, size => 25 },
  "office_floor",
  { data_type => "varchar", is_nullable => 1, size => 25 },
  "office_address1",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "office_address2",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "office_address3",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "office_city",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "office_state",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "office_postal_code",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "offie_country",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "mobile_phone",
  { data_type => "varchar", is_nullable => 1, size => 25 },
  "skype_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "aim_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "timezone",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "registered",
  { data_type => "datetime", is_nullable => 1 },
  "last_modified",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
  },
  "active",
  { data_type => "char", default_value => 1, is_nullable => 0, size => 1 },
  "office_email",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "office_department",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "headshot",
  { data_type => "mediumblob", is_nullable => 1 },
  "office_country",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "job_title_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "job_title",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "hire_date_text",
  { data_type => "varchar", is_nullable => 1, size => 15 },
  "admin_notes",
  { data_type => "longtext", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("username_unique", ["username"]);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2014-02-17 12:42:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:UTiPNx7eim5JhLEGgcfleg


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


__PACKAGE__->add_columns(
	registered => { data_type => 'datetime', inflate_datetime => 0 },
	last_modified => { data_type => 'datetime', inflate_datetime => 0 }
);


__PACKAGE__->meta->make_immutable;
1;
