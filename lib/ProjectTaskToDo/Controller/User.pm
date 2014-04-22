package ProjectTaskToDo::Controller::User;

use Moose;
use Mail::Sendmail;

use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

my $webserver  = `hostname`;
my $mailserver = "localhost";


=head1 NAME

ProjectTaskToDo::Controller::User - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut



=head2 user_base

=cut

sub user_base : Chained('/') : PathPart('user') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->stash( user_rs => $c->model('ProjectTaskToDoDB::User') );
}


=head2 user_object

=cut

sub user_object : Chained('user_base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;
    my $user = $c->stash->{user_rs}->find( { id => $id } );
    if ( !$user ) {
        $c->response->redirect( $c->uri_for("/") );
        $c->detach();
    }
    $c->stash( user => $user );
}


=head2 reset_password

=cut

sub reset_password : Local {
	my ($self, $c) = @_;
	my $bad_passwords=0;
	my $verification=0;
	my $old_password="";
	$old_password= $c->req->params->{old_password};
	my $new_password1= $c->req->params->{new_password1};
	my $new_password2= $c->req->params->{new_password2};

	if ($old_password && $new_password1 && $new_password2)
	{
		if ($new_password1 eq $new_password2)
		{
			my $salt=join '', ('.', '/', 0..9, 'A'..'Z', 'a'..'z')[rand 64, rand 64];
			my $new_crypted_password=crypt($new_password1,$salt);

			my $user= $c->model('ProjectTaskToDoDB::User')->find({id => $c->user->id});
			my $existing_crypted_password=$user->password;
			if (crypt($old_password, $existing_crypted_password) eq $existing_crypted_password)
			{
				$user= $c->model('ProjectTaskToDoDB::User')->find({username => $c->user->username});

				$user->update({
					password=>$new_crypted_password,
				});

				# password changed
				$c->flash->{message}="Your password has been changed.";
				#$c->flash->{message}="verification: $verification";
				$c->response->redirect('user/details');
			} else {
				$bad_passwords=1;
			}
		} else {
			$bad_passwords=1;
		}
	} else {
		$bad_passwords=1;
	}

	if ($bad_passwords)
	{
		# new passwords do not match incorrect
		$c->flash->{message}="There was a problem with the passwords you entered.  Please try again.";
		$c->response->redirect('/user/change_password');
		$c->detach();
	}

	$c->response->redirect($c->uri_for('/user/details'));
	$c->detach();
}


=head2 change_password

Displays a simple form for the user to change his own password

=cut

sub change_password : Chained('user_object') : PathPart('change_password') : Args(0) {
    my ( $self, $c ) = @_;
    my $user_to_display = $c->stash->{user};
    if ($c->user_exists) {
	    if ( ( $c->user->id == $user_to_display->id ) || ( $c->check_user_roles('admin') ) ) {
    		$c->stash->{template} = 'user/change_password.tt';
            } else {
		$c->response->redirect($c->uri_for('/user/details'));
	    }
    } else {
	$c->response->redirect($c->uri_for('/user/details'));
    }
}



=head2 forgot_password

User forgot password and needs new one. Form allows user
to enter their username to have a new password generated
and emailed to their address on file in their user account.

=cut

sub forgot_password : Global {
	my ( $self, $c ) = @_;
	$c->stash->{template} = 'user/forgot_password.tt';
}


=head2 send_new_password

Creates a new password and emails it to the user based on the email
address in the user's record.

=cut

sub send_new_password : Global {
	my ($self, $c) = @_;
	my $username= $c->req->params->{username};
	my $email= $c->req->params->{email};

	my $salt=join '', ('.', '/', 0..9,'A'..'Z', 'a'..'z')[rand 64, rand 64];
	my $password=join '', ('.', '/', 0..9,'A'..'Z', 'a'..'z')[rand 64, rand 64, rand 64, rand 64, rand 64, rand 64, rand 64, rand 64];
	my $crypted_password=crypt($password,$salt);

	my $user= $c->model('ProjectTaskToDoDB::User')->find({username => $username});

	$user->update({
		password=>$crypted_password,
	});


	my $recipient = $user->contact_email;


	my %mail = ( To      => "$recipient",
		From    => 'no-reply@projecttasktodo.org',
		Subject => 'Requested Password Update',
		Message => "New Password:  $password"
	);
	sendmail(%mail) or die $Mail::Sendmail::error;

	$c->response->redirect($c->uri_for('/'));
	#$c->detach();
}




=head2 update

=cut

sub update : Local {
	my ($self, $c)=@_;

	my $user_id=$c->user->id;
	my $u = $c->model('ProjectTaskToDoDB::User')->find({id => $user_id});

	if ($u->id == $user_id) {
		my $full_name = $c->req->params->{full_name};
		my $contact_email = $c->req->params->{contact_email};
		my $phone = $c->req->params->{phone};
	
		$u->update({
			full_name=>$full_name,
			contact_email => $contact_email,
			phone=>$phone,
		});
	}
	else {
		$c->flash->{message}="You are not authorized to edit this user.";
		$c->response->redirect($c->uri_for("/user/details/$user_id"));
	}

	$c->stash->{user}=$c->model('ProjectTaskToDoDB::User')->find({id=>$user_id});
	$c->response->redirect($c->uri_for("/user/details/$user_id"));
	$c->detach();
}

=head2 update_roles

=cut

sub update_roles : Chained('user_object') : PathPart('update_roles') : Args(0) {
    my ( $self, $c ) = @_;
    my $user_to_display = $c->stash->{user};
    my $user_to_display_id = $user_to_display->id;

	# if user_to_display has role user_maintenance
	if ( $c->user_exists() ) {
        	if ( $c->check_user_roles('user_maintainer' ) ) {

			# update user_to_display's roles
			my @keepers = $c->req->param('roles_assigned');

                	$user_to_display->user_roles->delete;

	                for my $keeper (@keepers) {
                        	$user_to_display->user_roles->create({ role => $keeper });
                	}

			$c->response->redirect($c->uri_for("/user/$user_to_display_id"));
			$c->detach();
		}
		else {
			$c->flash->{message}="You are not authorized to edit this user.";
			$c->response->redirect($c->uri_for("/user/$user_to_display_id"));
		}
	}
	else {
		$c->flash->{message}="You are not authorized to edit this user.";
		$c->response->redirect($c->uri_for("/user/$user_to_display_id"));
	}

	return();
}



=head2 edit

=cut

sub edit : Local {
	my ($self, $c)=@_;
	my $user_id = $c->user->id;

	my $u = $c->model('ProjectTaskToDoDB::User')->find({id => $user_id});

	if ($u->id == $c->user->id) {
		$c->stash->{user} = $c->model('ProjectTaskToDoDB::User')->find({id=>$user_id});
		$c->stash->{template} = 'user/edit.tt';
	}
	else {
		$c->flash->{message}="You are not authorized to edit this task.";
		$c->response->redirect($c->uri_for("/user/details/$user_id"));
	}
}

=head2 edit_roles

=cut

sub edit_roles : Chained('user_object') : PathPart('edit_roles') : Args(0) {
    my ( $self, $c ) = @_;
    my $user_to_display = $c->stash->{user};
    my $user_to_display_id = $user_to_display->id;

	if ( $c->user_exists() ) {
        	if ( $c->check_user_roles('user_maintainer' ) ) {
			$c->stash->{user} = $user_to_display;
			$c->stash->{roles} = [$c->model('ProjectTaskToDoDB::Role')->search({}, { order_by => 'display_name' })];
			$c->stash->{template} = 'user/edit_roles.tt';
		}
	}
	else {
		$c->flash->{message}="You are not authorized to edit this user.";
		$c->response->redirect($c->uri_for("/user/details/$user_to_display_id"));
	}
	return();
}



=head2 details

=cut

sub details : Local {
    my ( $self, $c ) = @_;
	my $user_id = $c->user->id;

	$c->stash->{user}=$c->model('ProjectTaskToDoDB::User')->find({id=>$user_id});
	$c->stash->{template}='user/details.tt';
}




=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ProjectTaskToDo::Controller::User in User.');
}

=head1 AUTHOR

William B. Hauck, <http://wbhauck.com/>

=head1 COPYRIGHT

Copyright (C) 2008 - 2014 William B. Hauck, <http://wbhauck.com/>

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
