package ProjectTaskToDo::Controller::TaskComment;

use Moose;
use POSIX qw/strftime/;
use Date::Manip;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

ProjectTaskToDo::Controller::TaskComment - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut





=head2 edit

=cut

sub edit : Local {
	my ($self, $c, $task_comment_id)=@_;
	my $now = strftime "%Y-%m-%d %H:%M:%S", localtime();
	my $secs_to_edit = 60*30;

	my $task_comment = $c->model('ProjectTaskToDoDB::TaskComment')->find(
		{
			task_comment_id=>$task_comment_id
		}
	);
	my $task_comment_task_id = $task_comment->task_comment_task_id;
	my $cur_user_id = $c->user->id;

	if ($task_comment->task_comment_user_id == $c->user->id) {
		my $date_diff = DateCalc($task_comment->task_comment_recorded, $now);

		my $task_comment_secs = UnixDate($task_comment->task_comment_recorded,'%s');
		my $now_secs = UnixDate($now,'%s');

		my $secs_diff = $now_secs - $task_comment_secs;

		if ($secs_diff < $secs_to_edit) {
	        $c->stash->{task_comment_types}=[$c->model('ProjectTaskToDoDB::TaskCommentType')->search->all()];
		$c->stash->{tc} = $task_comment;
		$c->stash->{template} = 'taskcomment/edit.tt';
		}
		else {
		$c->flash->{message}="Sorry, the time limit for editing this Comment has expired.";
		$c->response->redirect($c->uri_for("/task/$task_comment_task_id/comments"));
		}
	}
	else {
		$c->flash->{message}="Only the person who created a comment can edit it.";
		$c->response->redirect($c->uri_for("/task/$task_comment_task_id/comments"));
	}
}




=head2 update

=cut

sub update : Local {
	my ($self, $c)=@_;

	my $cur_date = strftime "%Y-%m-%d", localtime();
	my $alive = undef;

	#grab the task_comment_id and check if the user is authorized to update the task
	my $task_comment_id = $c->req->params->{task_comment_id};
	my $tc = $c->model('ProjectTaskToDoDB::TaskComment')->find( { task_comment_id => $task_comment_id});

	my $task_comment_task_id = $tc->task_comment_task_id;

	if ($tc->task_comment_user_id == $c->user->id) {
		my $task_comment_body = $c->req->params->{task_comment_body};
		my $task_comment_type_id = $c->req->params->{task_comment_type_id};
		my $billable = $c->req->params->{billable};
		my $task_comment_time_worked_hours = $c->req->params->{task_comment_time_worked_hours};
		my $task_comment_time_worked_minutes = $c->req->params->{task_comment_time_worked_minutes};
		my $task_comment_user_id = $c->user->id;

		my $task_comment_time_worked = ($task_comment_time_worked_hours * 60) + $task_comment_time_worked_minutes;


		my $task_comment_date_of_work = $c->req->params->{task_comment_date_of_work};
		if (lc($task_comment_date_of_work) eq "today") {
			$task_comment_date_of_work = $cur_date;
		}
	
#		my $task = $c->model('ProjectTaskToDoDB::Task')->search({task_id=>$task_id});
	
		$tc->update({
			task_comment_body => $task_comment_body,
			task_comment_type_id => $task_comment_type_id,
			task_comment_user_id => $task_comment_user_id,
			task_comment_time_worked => $task_comment_time_worked,
			task_comment_date_of_work => $task_comment_date_of_work,
			billable => $billable
		});


		# create a notification for each project user
#		my $project = $c->model('ProjectTaskToDoDB::Project')->find({ project_id => $project_id });
#	
#		for my $pu ($project->project_users) {
#	
#			$c->model('ProjectTaskToDoDB::Notification')->create({
#				user_to_notify => $pu->user->id,
#				user_making_modification => $c->user->id,
#				notification_type => 3,
#				task_id => $task_id,
#				body => $description
#			});
#		}

	}
	else {
		$c->flash->{message}="You are not authorized to edit this task comment.";
		$c->response->redirect($c->uri_for("/task/details/$task_comment_task_id"));
	}

	$c->stash->{task}=$c->model('ProjectTaskToDoDB::Task')->find({task_id=>$task_comment_task_id});
	$c->stash->{num_comments}=$c->model('ProjectTaskToDoDB::TaskComment')->search(
		{task_comment_task_id=>$task_comment_task_id},
		{
			select => [ { count => 'task_comment_task_id' } ],
			as => ['count']
		}
	);
	$c->response->redirect($c->uri_for("/task/$task_comment_task_id/comments"));
	$c->detach();
}


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ProjectTaskToDo::Controller::TaskComment in TaskComment.');
}



=head1 AUTHOR

William B. Hauck

=cut

=head1 COPYRIGHT

Copyright (C) 2008 - 2015 William B. Hauck, http://wbhauck.com

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

__PACKAGE__->meta->make_immutable;

1;
