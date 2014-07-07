package ProjectTaskToDo::Schema::Result::Task;

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

ProjectTaskToDo::Schema::Result::Task

=cut

__PACKAGE__->table("task");

=head1 ACCESSORS

=head2 task_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 task_project_id

  data_type: 'integer'
  is_nullable: 1

=head2 task_status_id

  data_type: 'smallint'
  default_value: 1
  extra: {unsigned => 1}
  is_nullable: 0

=head2 on_project_plan

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 task_order

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 task_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 task_creator_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 task_owner_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 task_project

  data_type: 'char'
  default_value: 0
  is_nullable: 0
  size: 1

=head2 task_priority

  data_type: 'smallint'
  default_value: 10
  extra: {unsigned => 1}
  is_nullable: 0

=head2 task_description

  data_type: 'text'
  is_nullable: 1

=head2 task_sched_start_date

  data_type: 'date'
  is_nullable: 1

=head2 task_actual_start_date

  data_type: 'date'
  is_nullable: 1

=head2 task_start_date_diff

  data_type: 'integer'
  is_nullable: 1

=head2 task_sched_compl_date

  data_type: 'date'
  is_nullable: 1

=head2 task_actual_compl_date

  data_type: 'date'
  is_nullable: 1

=head2 task_compl_date_diff

  data_type: 'integer'
  is_nullable: 1

=head2 task_deletion_date

  data_type: 'date'
  is_nullable: 1

=head2 difficulty

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 task_complete

  data_type: 'char'
  default_value: 'n'
  is_nullable: 0
  size: 1

=head2 task_deleted

  data_type: 'char'
  default_value: 'n'
  is_nullable: 0
  size: 1

=head2 task_recorded

  data_type: 'datetime'
  is_nullable: 1

=head2 task_last_modified

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0

=head2 task_modified_by_user_id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 task_completion_notes

  data_type: 'text'
  is_nullable: 1

=head2 task_deletion_notes

  data_type: 'text'
  is_nullable: 1

=head2 task_alive

  data_type: 'char'
  default_value: 1
  is_nullable: 0
  size: 1

=head2 task_alive_modified

  data_type: 'datetime'
  is_nullable: 1

=head2 task_last_activity

  data_type: 'datetime'
  is_nullable: 1

=head2 task_duration

  data_type: 'integer'
  is_nullable: 1

=head2 time_estimate

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "task_id",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "task_project_id",
  { data_type => "integer", is_nullable => 1 },
  "task_status_id",
  {
    data_type => "smallint",
    default_value => 1,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "on_project_plan",
  { data_type => "char", is_nullable => 0, size => 1 },
  "task_order",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "task_name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "task_creator_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 0 },
  "task_owner_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 0 },
  "task_project",
  { data_type => "char", default_value => 0, is_nullable => 0, size => 1 },
  "task_priority",
  {
    data_type => "smallint",
    default_value => 10,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "task_description",
  { data_type => "text", is_nullable => 1 },
  "task_sched_start_date",
  { data_type => "date", is_nullable => 1 },
  "task_actual_start_date",
  { data_type => "date", is_nullable => 1 },
  "task_start_date_diff",
  { data_type => "integer", is_nullable => 1 },
  "task_sched_compl_date",
  { data_type => "date", is_nullable => 1 },
  "task_actual_compl_date",
  { data_type => "date", is_nullable => 1 },
  "task_compl_date_diff",
  { data_type => "integer", is_nullable => 1 },
  "task_deletion_date",
  { data_type => "date", is_nullable => 1 },
  "difficulty",
  { data_type => "tinyint", extra => { unsigned => 1 }, is_nullable => 1 },
  "task_complete",
  { data_type => "char", default_value => "n", is_nullable => 0, size => 1 },
  "task_deleted",
  { data_type => "char", default_value => "n", is_nullable => 0, size => 1 },
  "task_recorded",
  { data_type => "datetime", is_nullable => 1 },
  "task_last_modified",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
  },
  "task_modified_by_user_id",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 1 },
  "task_completion_notes",
  { data_type => "text", is_nullable => 1 },
  "task_deletion_notes",
  { data_type => "text", is_nullable => 1 },
  "task_alive",
  { data_type => "char", default_value => 1, is_nullable => 0, size => 1 },
  "task_alive_modified",
  { data_type => "datetime", is_nullable => 1 },
  "task_last_activity",
  { data_type => "datetime", is_nullable => 1 },
  "task_duration",
  { data_type => "integer", is_nullable => 1 },
  "time_estimate",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
);
__PACKAGE__->set_primary_key("task_id");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2013-09-12 15:17:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5vHOWCZyhVqOddLITeUrNA



__PACKAGE__->add_columns(
        task_recorded => { data_type => 'datetime', inflate_datetime => 0 },
        task_last_modified => { data_type => 'datetime', inflate_datetime => 0 },
        task_sched_start_date => { data_type => 'datetime', inflate_datetime => 0 },
        task_actual_start_date => { data_type => 'datetime', inflate_datetime => 0 },
        task_sched_compl_date => { data_type => 'datetime', inflate_datetime => 0 },
        task_actual_compl_date => { data_type => 'datetime', inflate_datetime => 0 },
        task_last_activity => { data_type => 'datetime', inflate_datetime => 0 },
      );



use POSIX qw/strftime/;

#grab the current date
my $cur_date = strftime "%Y-%m-%d", localtime();


__PACKAGE__->belongs_to('creator' => 'ProjectTaskToDo::Schema::Result::User', 'task_creator_id');
__PACKAGE__->belongs_to('owner' => 'ProjectTaskToDo::Schema::Result::User', 'task_owner_id');
__PACKAGE__->belongs_to('project' => 'ProjectTaskToDo::Schema::Result::Project', 'task_project_id');
__PACKAGE__->belongs_to('status' => 'ProjectTaskToDo::Schema::Result::TaskStatusType', 'task_status_id');
__PACKAGE__->has_many('task_users' => 'ProjectTaskToDo::Schema::Result::TaskUser', 'task_id');
__PACKAGE__->has_many('task_comments' => 'ProjectTaskToDo::Schema::Result::TaskComment', 'task_comment_task_id');


sub has_user {
  my ($self, $user) = @_;
  my $users = $self->task_users->find({task_user_user_id => $user->id });
  return $users;
}


sub total_project_time {
  my ($self, $project_id) = @_;


  # select sum(task_comment_time_worked) div 60, sum(task_comment_time_worked) mod 60 from task_comment, task where task_comment.task_comment_task_id = task.task_id and task.task_project_id = ?;

  my $users = $self->tasks->find({ task_project_id => $project_id });
  return $users;
}


__PACKAGE__->meta->make_immutable;
1;


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
