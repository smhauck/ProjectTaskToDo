package ProjectTaskToDo::Controller::Note;


use Moose;
use POSIX qw/strftime/;
use Date::Manip;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

ProjectTaskToDo::Controller::Note - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 delete

FIX ME: need to make sure user is authorized to edit note

=cut

sub delete : Chained('note_object') : PathPart('delete') : Args(0) {
    my ( $self, $c, $link_id ) = @_;

    # grab the note from the stash
    my $note = $c->stash->{note};

    # get the note.id from the note
    my $note_id = $note->id;

    # if $c->user is note creator allow to delete
    if ( $c->user_exists ) {
        if (   ( $note->creator_id ==  $c->user->id )
            || ( $c->check_user_roles('administrator') ) )
        {
            {
                $c->stash->{authorized} = 1;
            }

        $note->delete;

        $c->response->redirect(
            $c->uri_for("/note") );
        $c->detach();
	}
	}
    else {

        # $c->user is not note creator
        $c->flash->{message} = "You are not authorized to edit that Note.";
        $c->response->redirect( $c->uri_for("/") );
    }
}



=head2 all_public

=cut

sub all_public : Chained('note_base') : PathPart('all_public') : Args(0) {
    my ( $self, $c ) = @_;
	$c->stash->{notes} = [$c->model('ProjectTaskToDoDB::Note')->search(
	{
		public => { '=' => 1 }
	},
	{
		order_by => 'title'
	})];

	$c->stash->{template}='note/all.tt';
}



=head2 search

=cut

sub search : Local {
    my ( $self, $c ) = @_;

    my $user_id = $c->user->id;

    #################################################################
    # grab the page to display and the number of records per page

    my ( $page, $rows ) = 0;

    $page = $c->req->params->{page};
    $rows = $c->req->params->{rows};

    # only digits for page and rows
    $page =~ s/[^[:digit:]]//;
    $rows =~ s/[^[:digit:]]//;

    # default to first page
    $page = 1  unless $page;
    $rows = 25 unless $rows;

    # FIX ME: this should go in a configuration database table
    # max 100 rows
    $rows = 100 unless ( $rows <= 100 );

    # stash them for the next request
    $c->stash->{page} = $page;
    $c->stash->{rows} = $rows;
    #################################################################

    my ( $date_start, $date_end, $title, $body )
      = undef;

    my $url_params = '';

    $date_start = $c->req->params->{date_start};
    $date_end   = $c->req->params->{date_end};

    #shortcut to clean data
    $date_start =~ s/[^[:digit:]\-]//g
      if $date_start;
    $date_end =~ s/[^[:digit:]\-]//g if $date_end;

    $title = $c->req->params->{title};
    $title =~ s/[^[:alnum:]\:\-\_\.\,\s]//g if $title;

    $body = $c->req->params->{body};
    $body =~ s/[^[:alnum:]\:\-\_\.\,\s]//g if $body;

    # build the where clause for the search
    my %where_clause = ();

#    if ( $date_start || $date_end || $title || $body )
#    {
#    	$where_clause{public} = { '=' => 1 };
#	}

    if ( $date_start && $date_end ) {
        $where_clause{date_selected} =
          { -between => [ $date_start, $date_end ]
          };
        $url_params .= "&date_start=$date_start&date_end=$date_end";
    }

    if ($title) {
        $where_clause{title} = { -like => "\%$title\%" };
        $url_params .= "&title=$title";
    }

    if ($body) {
        $where_clause{body} = { -like => "\%$body\%" };
        $url_params .= "&body=$body";
    }


	# if not in administrator role, limit to person's own notes
	#if (! $c->check_user_roles('administrator')) {
		#	$where_clause{creator_id} = $user_id };
		#$url_params .= "&body=$body";
		#}


	if (%where_clause) {

	%where_clause =
	(
		%where_clause,
		-or =>
			[
				-and =>
				[
					creator_id => { '=', $user_id },
					public => { '!=', '1' },
				],
				public => '1',
			],
		
	);
    my $notes = [
        $c->model('ProjectTaskToDoDB::Note')->search(
            {%where_clause},
            {
                select => [
                    { distinct => ['id'] }, 'title' 
                ],
                as => [
                    qw/id title/
                ],
                order_by => 'title'
                #page     => $page,
                #rows     => $rows,
            }
        )
    ];


    $c->stash->{note_count} = @$notes;
    $c->stash->{notes}      = $notes;

    $c->stash->{url_params} = $url_params;

	};

    $c->stash->{template} = 'note/search.tt';
}


sub results : Local {
	my ($self, $c) = @_;
	my $criteria="";
	$criteria = $c->req->params->{criteria};
	$c->stash->{criteria} = $criteria;
	if ($criteria)
	{
	#$c->stash->{projects} = [$c->model('ProjectTaskToDoDB::Project')->search_like( criteria=> ("\%$criteria\%" ))];
	$c->stash->{projects} = [$c->model('ProjectTaskToDoDB::Project')->search_literal('match (name, description) against (?)',$criteria)];
	}
	$c->stash->{template} = 'search/results.tt2';
}






=head2 my_all

=cut

sub my_all : Chained('note_base') : PathPart('my_all') : Args(0) {
    my ( $self, $c ) = @_;
	$c->stash->{notes} = [$c->model('ProjectTaskToDoDB::Note')->search(
	{
		creator_id => $c->user->id
	},
	{
		order_by => 'title'
	})];

	$c->stash->{template}='note/all.tt';
}


=head2 my_personal

=cut

sub my_personal : Chained('note_base') : PathPart('my_personal') : Args(0) {
    my ( $self, $c ) = @_;
	$c->stash->{notes} = [$c->model('ProjectTaskToDoDB::Note')->search(
	{
		creator_id => $c->user->id,
		public => { '!=' => 1 }
	},
	{
		order_by => 'title'
	})];

	$c->stash->{template}='note/all.tt';
}



=head2 my_public

=cut

sub my_public : Chained('note_base') : PathPart('my_public') : Args(0) {
    my ( $self, $c ) = @_;
	$c->stash->{notes} = [$c->model('ProjectTaskToDoDB::Note')->search(
	{
		creator_id => $c->user->id,
		public => { '=' => 1 }
	},
	{
		order_by => 'title'
	})];

	$c->stash->{template}='note/all.tt';
}



=head2 base

=cut

sub note_base : Chained('/') : PathPart('note') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->stash( note_rs => $c->model('ProjectTaskToDoDB::Note') );
}




=head2 details

=cut

sub details : Chained('note_object') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
	my $note = $c->stash->{note};

	$c->stash->{template}='note/details.tt';
}


=head2 edit

=cut

sub edit : Chained('note_object') : PathPart('edit') : Args(0) {
    my ( $self, $c ) = @_;
    my $note = $c->stash->{note};
        $c->stash->{projects}      = [ $c->model('ProjectTaskToDoDB::Project')->search({ status_id => { '!=' => 3 } }, { order_by => 'project_short_name' }) ];
        $c->stash->{tasks}      = [ $c->model('ProjectTaskToDoDB::Task')->search({ deleted => { '=' => 'n'} } , {order_by => 'task_name'} ) ];
        $c->stash->{organizations}      = [ $c->model('ProjectTaskToDoDB::Organization')->search({},{ order_by => 'name' }) ];
        $c->stash->{persons}      = [ $c->model('ProjectTaskToDoDB::Person')->search({},{ order_by => 'full_name' }) ];
	$c->stash->{template}='note/edit.tt';
}


=head2 new

=cut

sub new_note :Path('/note') :Args(0) {
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
	$c->stash->{template}='note/new_note.tt';
}



=head2 note_object

=cut

sub note_object : Chained('note_base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $note_id ) = @_;
    my $note =
      $c->stash->{note_rs}->find( { id => $note_id } );
    if ( !$note) {
        $c->response->redirect( $c->uri_for('/') );
        $c->detach();
    }
    $c->stash( note => $note );
}



=head2 insert_note

=cut

sub insert_note :Path('/note/insert_note') :Args(0) {
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


	my $note = $c->model('ProjectTaskToDoDB::Note')->create({
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

	my $note_id=$note->id;
        $c->response->redirect("/note/$note_id");

}




=head2 update

=cut

sub update :Chained('note_object') : PathPart('update') : Args(0) {
	my ($self, $c) = @_;
	my $now = strftime "%Y-%m-%d %H:%M:%S", localtime();

	my $note = $c->stash->{note};
	my $note_id=$note->id;

    my $public= $c->req->params->{public};
    $public = 0 unless $public;
    my $body= $c->req->params->{body};
    # clean the dangerous tags from the body
    # i'd like to do this in the CKEditor, but can't right now
    $body =~ s/<script>/&lt;script&gt;/g;
    $body =~ s/<\/script>/&lt;\/script&gt;/g;
    $body =~ s/<iframe>/&lt;iframe&gt;/g;
    $body =~ s/<\/iframe>/&lt;\/iframe&gt;/g;
    $body =~ s/<frameset>/&lt;frameset&gt;/g;
    $body =~ s/<\/frameset>/&lt;\/frameset&gt;/g;

    my $project_id= $c->req->params->{project_id};
    $project_id = '' unless $project_id;
    my $task_id= $c->req->params->{task_id};
    $task_id = '' unless $task_id;
    my $client_organization_id = $c->req->params->{client_organization_id};
    $client_organization_id = '' unless $client_organization_id;
    my $client_person_id = $c->req->params->{client_person_id};
    $client_person_id = '' unless $client_person_id;
    my $client_contact_person_id = $c->req->params->{client_contact_person_id};
    $client_contact_person_id = '' unless $client_contact_person_id;
    my $date_selected = $c->req->params->{date_selected};
    my $title= $c->req->params->{title};


	$note->update({
		active => '1',
		creator_id => $c->user->id,
		created => $now,
		project_id => $project_id,
		client_organization_id => $client_organization_id,
		client_person_id => $client_person_id,
		client_contact_person_id => $client_contact_person_id,
		task_id => $task_id,
		date_selected => $date_selected,
		public => $public,
		title => $title,
		body => $body
	});

        $c->response->redirect("/note/$note_id");

}



=head2 index

=cut

#sub index :Path :Args(0) {
#    my ( $self, $c ) = @_;
#    $c->response->body('Matched ProjectTaskToDo::Controller::Note in Note.');
#}


=head1 AUTHOR

William B. Hauck

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
