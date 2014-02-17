package ProjectTaskToDo::Controller::Root;

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

use Moose;

# use the time functions
use POSIX qw/strftime/;

use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

ProjectTaskToDo::Controller::Root - Root Controller for ProjectTaskToDo

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS


=head2 about

=cut

sub about : Local {
    my ( $self, $c ) = @_;

    $c->stash->{template} = 'about.tt';
}


=head2 access_denied

=cut

sub access_denied : Private {
	my ($self, $c)=@_;
	$c->stash->{template}='denied.tt';
}


=head2 ack_note

=cut

sub ack_note : Local {
	my ($self, $c, $notification_id)=@_;
	my $notification_number=$c->request->body_params->{notification_number};

	if ($c->user_exists()) {
		if (($notification_id) && ($notification_id =~ /^\d+$/))
		{
			#grab the notification.id and check if user is authorized to delete it
			my $notification = $c->model('ProjectTaskToDoDB::Notification')->find({id=>$notification_id});
	
			if ($notification)
			{	
				if ($notification->user_to_notify == $c->user->id)
				{
					# if authorized, delete it
					$notification->delete();
					$c->response->redirect("/");
				}
				else
				{
					$c->flash->{message} = "You are not authorized to delete this notification.";
					$c->response->redirect($c->uri_for("/"));
				}
			}
			else
			{
				$c->flash->{message} = "This notification no longer exists.";
				$c->response->redirect($c->uri_for("/"));
			}
		}
		elsif ($notification_number eq "ALL")
		{
			# delete all notifications for the current user
			$c->user->notifications->delete;
			$c->response->redirect($c->uri_for("/"));
		}
	}
	else {
		$c->flash->{message} = "You are not authorized to delete this notification.";
		$c->response->redirect($c->uri_for("/"));
	}
}




=head2 authenticate

=cut

sub authenticate : Local {
	my ( $self, $c ) = @_;
	if (my $username = $c->req->param("username") and my $password = $c->req->param("password") )
	{
		if ( $c->authenticate({ username => $username,
					password => $password }))
		{
			#user authenticated
			$c->response->redirect('/');
		} else {
			# login incorrect
			$c->response->redirect('login');
		}
	} else {
		# invalid form input
		$c->response->redirect('login');
	}
}


=head2 default

=cut

sub default : Private {
	my ( $self, $c ) = @_;

	my $user_id='';	

	#grab the user's id for convenience
	if ($c->user) {
		$user_id = $c->user->id;

		#grab the current date
		my $cur_date = strftime "%Y-%m-%d", localtime();
	
		my $my_projects = $c->model('ProjectTaskToDoDB::Project')->search({
				'deleted' => { '<>' => 'y' },
				'project_complete' => { '<>' => 'y' }
				}
		);
	
		my @active_tasks = $my_projects->search_related('tasks', {
				'task_owner_id' => $user_id,
				'task_deleted' => { '<>' => 'y' },
				'task_complete' => { '<>' => 'y' },
				'task_sched_compl_date' => { '<' => $cur_date },
				},
				{ order_by => 'task_priority' }
		);

		my $num_late_tasks = 0;
	
		# FIX ME:  this is all active projects regardless of whether the user
		# is a project_user	
		$c->stash->{num_active_projects}=$my_projects;
		
		#number of active tasks (remember! zero-based arrays)
		$c->stash->{num_active_tasks}=$#active_tasks + 1;

		my @late_tasks = $c->model('ProjectTaskToDoDB')->num_my_late_tasks($user_id);
		$c->stash->{num_late_tasks}=$late_tasks[0][0];
	
		#notifications
		$c->stash->{notifications} = [$c->model('ProjectTaskToDoDB::Notification')->search({ user_to_notify => $c->user->id },{order_by => 'id desc'})];
	}

	$c->stash->{template} = 'default.tt';
}


=head2 help

=cut

sub help : Local {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'help.tt';
}


=head2 lessons_learned

=cut

sub lessons_learned : Local {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'lessons_learned.tt';
}

=head2 license

=cut

sub license : Local {
    my ( $self, $c ) = @_;

    $c->stash->{template} = 'license.tt';
}



=head2 login

=cut

sub login : Global {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'login.tt';
}


=head2 logout

=cut

sub logout : Global {
    my ( $self, $c ) = @_;
    $c->logout;
    $c->response->redirect($c->uri_for('/'));
}




=head2 new_user

=cut

sub new_user : Local {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'new_user.tt';
}


=head2 notifications

=cut

sub notifications : Local {
	my ($self, $c) = @_;
	if ($c->user_exists) {
		$c->stash->{notifications} = [$c->model('ProjectTaskToDoDB::Notification')->search->({ user_to_notify => $c->user->id })];
	}
	$c->stash->{template}='notifications.tt';
}



=head2 register

=cut

sub register : Local {
	my ($self, $c) = @_;
	my $username= $c->req->params->{username};
	my $password= $c->req->params->{password};
	my $full_name= $c->req->params->{full_name};
	my $email= $c->req->params->{email};

	my $salt=join '', ('.', '/', 0..9,'A'..'Z', 'a'..'z')[rand 64, rand 64];

	my $crypted_password=crypt($password,$salt);

	my $user = $c->model('ProjectTaskToDoDB::User')->create({
		username=>$username,
		password=>$crypted_password,
		full_name=>$full_name,
		contact_email=>$email,
	});

	my $uid = $user->id;

	my $user_role = $c->model('ProjectTaskToDoDB::UserRole')->create({
		user => $uid,
		role => '1'
	});
	$c->flash->{message}="Thank you for Registering.  Please log in to use the system.";
	$c->response->redirect($c->uri_for('/'));
	$c->detach();
}



=head2 unauthorized

=cut

sub unauthorized : Local {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'root/unauthorized.tt';
}


=head2 index

The root page (/)

=cut

#sub index :Path :Args(0) {
#    my ( $self, $c ) = @_;

#    # Hello World
#    $c->response->body( $c->welcome_message );
#}

=head2 default

Standard 404 error page

=cut

#sub default :Path {
#    my ( $self, $c ) = @_;
#    $c->response->body( 'Page not found' );
#    $c->response->status(404);
#}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

William B. Hauck

=cut

__PACKAGE__->meta->make_immutable;

1;
