package ProjectTaskToDo::Controller::Meeting;
use Moose;
use POSIX qw/strftime/;
use Date::Manip;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

ProjectTaskToDo::Controller::Meeting - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ProjectTaskToDo::Controller::Meeting in Meeting.');
}


=head2 new

=cut

sub new_meeting :Path('/meeting') :Args(0) {
    my ( $self, $c ) = @_;
    	my $project_id = $c->req->params->{project};
    	my $task_id = $c->req->params->{task};
	if ($project_id)
	{
        	$c->stash->{projects} = [ $c->model('ProjectTaskToDoDB::Project')->find({project_id => $project_id}) ];
        	$c->stash->{tasks} = [ $c->model('ProjectTaskToDoDB::Task')->search({task_project_id => $project_id}) ];
	}
	elsif ($task_id)
	{
        	$c->stash->{tasks} = [ $c->model('ProjectTaskToDoDB::Task')->find({task_id => $task_id}) ];
	}
	else
	{
        	$c->stash->{projects} = [ $c->model('ProjectTaskToDoDB::Project')->search( { status_id => {'=' => 1 } }, { order_by => 'project_name' } ) ];
        	$c->stash->{tasks} = [ $c->model('ProjectTaskToDoDB::Task')->search( { task_owner_id => $c->user->id, task_alive => {'=' => 1 }  } ) ];
	}
        $c->stash->{organizations}      = [ $c->model('ProjectTaskToDoDB::Organization')->search({},{ order_by => 'name' }) ];
        $c->stash->{persons}      = [ $c->model('ProjectTaskToDoDB::Person')->search({ active => { '=' => '1' } },{ order_by => 'full_name' }) ];
	$c->stash->{template}='meeting/new_meeting.tt';
}



=head2 insert_meeting

=cut

sub insert_meeting :Path('/meeting/insert_meeting') :Args(0) {
	my ($self, $c) = @_;
	my $now = strftime "%Y-%m-%d %H:%M:%S", localtime();

    my $public = $c->req->params->{public};
    $public = 0 unless $public;
    my $date_selected = $c->req->params->{date_selected};
    my $body= $c->req->params->{body};
    # clean the dangerous tags from the body
    # i'd like to do this in the CKEditor, but can't right now
    $body =~ s/<script>/&lt;script&gt;/g;
    $body =~ s/<\/script>/&lt;\/script&gt\;/g;
    $body =~ s/<iframe>/&lt;iframe&gt;/g;
    $body =~ s/<\/iframe>/&lt;\/iframe&gt;/g;
    $body =~ s/<frameset>/&lt;frameset&gt;/g;
    $body =~ s/<\/frameset>/&lt;\/frameset&gt;/g;

    my $project_id= $c->req->params->{project_id};
    my $client_organization_id = $c->req->params->{client_organization_id};
    $client_organization_id = '' unless $client_organization_id;
    my $client_person_id = $c->req->params->{client_person_id};
    $client_person_id = '' unless $client_person_id;
    my $client_contact_person_id = $c->req->params->{client_contact_person_id};
    $client_contact_person_id = '' unless $client_contact_person_id;
    my $task_id= $c->req->params->{task_id};
    my $title= $c->req->params->{title};
    $title = $now unless $title;


	my $meeting = $c->model('ProjectTaskToDoDB::Meeting')->create({
		active => '1',
		creator_id => $c->user->id,
		created => $now,
		project_id => $project_id,
		client_organization_id => $client_organization_id,
		client_person_id => $client_person_id,
		client_contact_person_id => $client_contact_person_id,
		task_id => $task_id,
		public => $public,
		date_selected => $date_selected,
		title => $title,
		body => $body
	});

	my $meeting_id=$meeting->id;
        $c->response->redirect("/meeting/$meeting_id");

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
