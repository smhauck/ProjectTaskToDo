package ProjectTaskToDo::Controller::Organization;


use Moose;
use namespace::autoclean;
use POSIX qw/strftime/;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

ProjectTaskToDo::Controller::Organization - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut



=head2 search

=cut

sub search : Local {
    my ( $self, $c ) = @_;

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

    my ( $name) = undef;

    my $url_params = '';

    $name = $c->req->params->{name};



    # build the where clause for the search
    my %where_clause = ();

    if ($name) {
        $where_clause{name} = { -like => "\%$name\%" };
        $url_params .= "&name=$name";
    }

    if (%where_clause) {

    my $organizations = [
        $c->model('ProjectTaskToDoDB::Organization')->search(
            {%where_clause},
            {
                select => [
                    { distinct => ['id'] }, 'name', 'parent_org_id'
                ],
                as => [
                    qw/id name parent_org_id/
                ],
                order_by => 'name',
                page     => $page,
                rows     => $rows,
            }
        )
    ];

    $c->stash->{organization_count} = @$organizations;
    $c->stash->{organizations}      = $organizations;

    $c->stash->{url_params} = $url_params;
    }

    $c->stash->{template} = 'organization/search.tt';
}






=head2 update

=cut

sub update : Local {
    my ( $self, $c ) = @_;
    my $creator_id = $c->user->id,

      my $cur_date = strftime "%Y-%m-%d", localtime();
      my $organization_id = $c->req->params->{id};

    my $organization = $c->model('ProjectTaskToDoDB::Organization')->find( { id => $organization_id } );

    my $name       = $c->req->params->{name};
        $name = localtime() unless $name;

        my $country_id = $c->req->params->{country_id};
	$country_id = '' unless $country_id;

    my $description       = $c->req->params->{description};
    my $notes = $c->req->params->{notes};
    my $recorded = strftime "%Y-%m-%d %H-%M-%S", localtime();


        $organization->update(
		{
            name                => $name,
            description         => $description,
            notes               => $notes,
            recorded            => $recorded,
        }
    );

    $organization_id = $organization->id;

    $c->response->redirect( $c->uri_for("/organization/$organization_id") );
    $c->detach();
}



=head2 insert_organization

=cut

sub insert_organization : Local {
    my ( $self, $c ) = @_;
    my $creator_id = $c->user->id,

      my $cur_date = strftime "%Y-%m-%d", localtime();

    my $name       = $c->req->params->{name};
        my $country_id = $c->req->params->{country_id};
	$country_id = '' unless $country_id;

    if ( !$name ) {
        $name = localtime();
    }

    my $description       = $c->req->params->{description};
    my $notes = $c->req->params->{notes};
    my $recorded = strftime "%Y-%m-%d %H-%M-%S", localtime();

    my $organization = $c->model('ProjectTaskToDoDB::Organization')->create(
        {
            name                => $name,
            description         => $description,
            notes               => $notes,
            recorded            => $recorded,
        }
    );

    my $organization_id = $organization->id;

    $c->response->redirect( $c->uri_for("/organization/$organization_id") );
    $c->detach();
}


=head2 new_organization

=cut

sub new_organization : Chained('organization_base') : PathPart('new') : Args(0) {
    my ( $self, $c ) = @_;

    # tell the template which tab to highlight and page title
    $c->stash->{whichtab}  = 'create_new_organization';
    $c->stash->{pagetitle} = 'Create New Organization';

    $c->stash->{users} =
      [ $c->model('ProjectTaskToDoDB::User')->search( { active => '1' }, { order_by => 'full_name' } ) ];
    $c->stash->{template} = 'organization/new_organization.tt';
}


=head2 list

=cut

sub list : Local {
    my ( $self, $c ) = @_;
    $c->stash->{organizations} =
      [ $c->model('ProjectTaskToDoDB::Organization')
          ->search( { }, { order_by => 'name' } ) ];
    $c->stash->{template} = 'organization/list.tt';
}


=sub notes

=cut

sub notes : Chained('organization_object') : PathPart('notes') : Args(0) {
    my ( $self, $c ) = @_;

    my $organization = $c->stash->{organization};
    my $organization_id = $organization->id;

    my $user_id = $c->user->id;


    # show the details if $c->user is a team member
    if ( $c->user_exists ) {
        if ( $c->check_user_roles('member') )
        {
                $c->stash->{authorized} = 1;

        $c->stash->{notes_public} =
          [ $c->model('ProjectTaskToDoDB::Note')
              ->search( { client_organization_id => $organization_id, public=> 1 } ) ];
        
	      $c->stash->{notes_personal} =
          [ $c->model('ProjectTaskToDoDB::Note')
              ->search( { client_organization_id => $organization_id, creator_id=> $c->user->id, public=> 0 } ) ];

        $c->stash->{pagetitle} = $organization->name . " : Notes";
        $c->stash->{template}  = 'organization/notes.tt';

    }
    }
    else {

        # $c->user is not a team member
        $c->flash->{message} = "You are not authorized to view this client's notes.";
        $c->response->redirect( $c->uri_for("/") );
    }
}






=head2 name_lookup

=cut

sub name_lookup : Local {
	my ($self, $c) = @_;
	my @results = ();
	my $name= $c->req->query_parameters->{term};

	my $organizations = $c->model('ProjectTaskToDoDB::Organization')->search ( { name => { -like => "\%$name\%" } } );

	while (my $cur_organization = $organizations->next) {
		my $label = $cur_organization->name ;
		push (@results, { id => $cur_organization->name, label => $label, value => $cur_organization->id } );
	}
	$c->stash->{json} = \@results;
	$c->forward('View::JSON');
}


=head2 organization_base

=cut

sub organization_base : Chained('/') :PathPart('organization') :CaptureArgs(0) {
    my ($self, $c) = @_;
    $c->stash(organization_rs => $c->model('ProjectTaskToDoDB::Organization'));
}


=head2 details

=cut

sub details : Chained('organization_object') :PathPart('') :Args(0) {
    my ( $self, $c) = @_;
    #my $organization = $c->stash->{organization};
    $c->stash->{template} = 'organization/details.tt';
}

=head2 edit

=cut

sub edit : Chained('organization_object') :PathPart('edit') :Args(0) {
    my ( $self, $c) = @_;
    $c->stash->{template} = 'organization/edit.tt';
}


=head2 organization_object

=cut

sub organization_object : Chained('organization_base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;
    my $organization = $c->stash->{organization_rs}->find( { id => $id } );
    if (! $organization)
    {
    	$c->response->redirect($c->uri_for("/"));
	$c->detach();
    }
    $c->stash(organization => $organization);
}




=head2 projects

=cut

sub projects : Chained('organization_object') :PathPart('projects') :Args(1) {
    my ( $self, $c, $status) = @_;
    my $organization = $c->stash->{organization};

		my $user_projects_rs = $c->model('ProjectTaskToDoDB::ProjectUser')->search(
			{ project_user_user_id => $c->user->id }
		);
		if ($status eq 'active') {
			$c->stash->{projects} = [$user_projects_rs->search_related('project')->search(
				{ project_alive => 1, list_type => 1, client_organization_id => $organization->id },
				{ order_by => 'project_name' }
			)];
		} elsif ($status eq 'complete') {
			$c->stash->{projects} = [$user_projects_rs->search_related('project')->search(
				{ project_alive => 0, status_id => 2, list_type => 1, client_organization_id => $organization->id },
				{ order_by => 'project_name' }
			)];
		}
    $c->stash->{template} = 'organization/projects.tt';
}


=head2 tasks

=cut

sub tasks :Chained('organization_object') :PathPart('tasks') :Args(1) {
    my ( $self, $c, $status) = @_;
    my @tasks=();
    my $organization = $c->stash->{organization};
    my $the_org_id = $organization->id;

    my $user_id = $c->user->id;
    my $cur_date = strftime "%Y-%m-%d", localtime();

    my $org_projects = $c->model('ProjectTaskToDoDB::Project')->search(
        {
            'client_organization_id' => { '=' => $the_org_id },
            'deleted'        => { '<>' => 'y' },
            'project_alive ' => { '='  => '1' }
        }
    );

    if ($status eq 'active') {
	@tasks = $org_projects->search_related(
          'tasks',
        	{
            		'task_alive'    => { '=' => '1' },
        	},
        	{ order_by => 'task_name' }
    		);
	} elsif ($status eq 'complete') {
	@tasks = $org_projects->search_related(
          'tasks',
        	{
            		'task_alive'    => { '=' => '0' },
            		'tasks.deleted'    => { '<>' => 'y' },
        	},
        	{ order_by => 'task_name' }
    		);
	}

    $c->stash->{num_tasks} = $#tasks + 1;
    $c->stash->{tasks}     = \@tasks;

    $c->stash->{template} = 'organization/tasks.tt';
}



=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ProjectTaskToDo::Controller::Organization in Organization.');
}


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
