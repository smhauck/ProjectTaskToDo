package ProjectTaskToDo::Schema::Result::Account;

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

ProjectTaskToDo::Schema::Result::Account

=cut

__PACKAGE__->table("account");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 creator_id

  data_type: 'bigint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 owner_id

  data_type: 'bigint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 registered

  data_type: 'datetime'
  is_nullable: 1

=head2 last_modified

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0

=head2 description

  data_type: 'text'
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
  "creator_id",
  {
    data_type => "bigint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "owner_id",
  {
    data_type => "bigint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "title",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "registered",
  { data_type => "datetime", is_nullable => 1 },
  "last_modified",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
  },
  "description",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2014-04-25 13:49:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Hmn/yGHWxbd7T0otxZA77Q


__PACKAGE__->add_columns(
        registered => { data_type => 'datetime', inflate_datetime => 0 },
);


__PACKAGE__->has_many('map_account_user' => 'ProjectTaskToDo::Schema::Result::AccountUser', 'account_id');
__PACKAGE__->many_to_many('users' => 'map_account_user', 'user');

__PACKAGE__->belongs_to('creator' => 'ProjectTaskToDo::Schema::Result::User', 'creator_id');
__PACKAGE__->belongs_to('owner' => 'ProjectTaskToDo::Schema::Result::User', 'owner_id');




sub has_user {
  my ($self, $user) = @_;
  return $self->users->find({ id => $user->id });
}


__PACKAGE__->meta->make_immutable;
1;
