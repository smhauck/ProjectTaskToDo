package ProjectTaskToDo::Schema::Result::Story;

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

ProjectTaskToDo::Schema::Result::Story

=cut

__PACKAGE__->table("story");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 created_at

  data_type: 'datetime'
  is_nullable: 1

=head2 updated_at

  data_type: 'datetime'
  is_nullable: 1

=head2 story_status_type

  data_type: 'integer'
  default_value: 1
  is_nullable: 0

=head2 requestor_id

  data_type: 'integer'
  is_nullable: 1

=head2 points

  data_type: 'decimal'
  is_nullable: 1
  size: [10,2]

=head2 hours

  data_type: 'decimal'
  is_nullable: 1
  size: [10,2]

=head2 product_id

  data_type: 'integer'
  is_nullable: 1

=head2 sprint_id

  data_type: 'integer'
  is_nullable: 1

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 description

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "created_at",
  { data_type => "datetime", is_nullable => 1 },
  "updated_at",
  { data_type => "datetime", is_nullable => 1 },
  "story_status_type",
  { data_type => "integer", default_value => 1, is_nullable => 0 },
  "requestor_id",
  { data_type => "integer", is_nullable => 1 },
  "points",
  { data_type => "decimal", is_nullable => 1, size => [10, 2] },
  "hours",
  { data_type => "decimal", is_nullable => 1, size => [10, 2] },
  "product_id",
  { data_type => "integer", is_nullable => 1 },
  "sprint_id",
  { data_type => "integer", is_nullable => 1 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "description",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2014-07-15 12:22:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:eXqEeGtx+ojT5IkdlAaDtQ


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
