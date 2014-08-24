package ProjectTaskToDo::Schema::Result::WikiPage;

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

ProjectTaskToDo::Schema::Result::WikiPage

=cut

__PACKAGE__->table("wiki_page");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 body

  data_type: 'text'
  is_nullable: 1

=head2 version

  data_type: 'integer'
  is_nullable: 1

=head2 wiki_id

  data_type: 'integer'
  is_nullable: 0

=head2 product_id

  data_type: 'integer'
  is_nullable: 1

=head2 story_id

  data_type: 'integer'
  is_nullable: 1

=head2 task_id

  data_type: 'integer'
  is_nullable: 1

=head2 user_id

  data_type: 'integer'
  is_nullable: 1

=head2 created_at

  data_type: 'datetime'
  is_nullable: 1

=head2 updated_at

  data_type: 'datetime'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "body",
  { data_type => "text", is_nullable => 1 },
  "version",
  { data_type => "integer", is_nullable => 1 },
  "wiki_id",
  { data_type => "integer", is_nullable => 0 },
  "product_id",
  { data_type => "integer", is_nullable => 1 },
  "story_id",
  { data_type => "integer", is_nullable => 1 },
  "task_id",
  { data_type => "integer", is_nullable => 1 },
  "user_id",
  { data_type => "integer", is_nullable => 1 },
  "created_at",
  { data_type => "datetime", is_nullable => 1 },
  "updated_at",
  { data_type => "datetime", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2014-08-24 18:35:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:bzdxZTXH1aMwR54rUA28Kw


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
