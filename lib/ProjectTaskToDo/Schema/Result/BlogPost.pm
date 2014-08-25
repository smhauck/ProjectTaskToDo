package ProjectTaskToDo::Schema::Result::BlogPost;

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

ProjectTaskToDo::Schema::Result::BlogPost

=cut

__PACKAGE__->table("blog_post");

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

=head2 publish_date

  data_type: 'date'
  is_nullable: 1

=head2 blog_id

  data_type: 'integer'
  is_nullable: 1

=head2 author_id

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
  "publish_date",
  { data_type => "date", is_nullable => 1 },
  "blog_id",
  { data_type => "integer", is_nullable => 1 },
  "author_id",
  { data_type => "integer", is_nullable => 1 },
  "created_at",
  { data_type => "datetime", is_nullable => 1 },
  "updated_at",
  { data_type => "datetime", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2014-08-24 23:57:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:R4erP+iZPzyDNsKbLONZuA

__PACKAGE__->add_columns(
        created_at => { data_type => 'datetime', inflate_datetime => 0 },
        updated_at => { data_type => 'datetime', inflate_datetime => 0 },
        publish_date => { data_type => 'datetime', inflate_datetime => 0 },
);

__PACKAGE__->belongs_to('author' => 'ProjectTaskToDo::Schema::Result::User', 'author_id');

__PACKAGE__->meta->make_immutable;
1;
