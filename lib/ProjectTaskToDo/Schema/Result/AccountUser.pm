package ProjectTaskToDo::Schema::Result::AccountUser;

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

ProjectTaskToDo::Schema::Result::AccountUser

=cut

__PACKAGE__->table("account_user");

=head1 ACCESSORS

=head2 account_id

  data_type: 'bigint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 user_id

  data_type: 'bigint'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "account_id",
  {
    data_type => "bigint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "user_id",
  {
    data_type => "bigint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
);
__PACKAGE__->set_primary_key("account_id", "user_id");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2014-04-25 13:49:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XPaRb0eZiT6sz4pvgyv5Bg



__PACKAGE__->many_to_many('users', 'account_users', 'user');
__PACKAGE__->belongs_to('account' => 'ProjectTaskToDo::Schema::Result::Account', 'account_id');
__PACKAGE__->belongs_to('user' => 'ProjectTaskToDo::Schema::Result::User', 'user_id');





__PACKAGE__->meta->make_immutable;
1;
