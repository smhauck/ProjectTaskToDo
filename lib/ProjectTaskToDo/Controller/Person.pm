package ProjectTaskToDo::Controller::Person;

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
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

ProjectTaskToDo::Controller::Person - Catalyst Controller

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

    my ( $username, $full_name, $first_name, $last_name, $office_country)
      = undef;

    my $url_params = '';

    $username = $c->req->params->{username};
    $full_name = $c->req->params->{full_name};
    $first_name = $c->req->params->{first_name};
    $last_name = $c->req->params->{last_name};



    # build the where clause for the search
    my %where_clause = ();

    if ($username) {
        $where_clause{username} = { -like => "\%$username\%" };
        $url_params .= "&username=$username";
    }

    if ($full_name) {
        $where_clause{full_name} = { -like => "\%$full_name\%" };
        $url_params .= "&full_name=$full_name";
    }

    if ($first_name) {
        $where_clause{first_name} = { -like => "\%$first_name\%" };
        $url_params .= "&first_name=$first_name";
    }

    if ($last_name) {
        $where_clause{last_name} = { -like => "\%$last_name\%" };
        $url_params .= "&last_name=$last_name";
    }


    if (%where_clause) {
    # no inactive users
    $where_clause{active} = { '=' => '1' };

    my $persons= [
        $c->model('ProjectTaskToDoDB::Person')->search(
            {%where_clause},
            {
                select => [
                    { distinct => ['id'] }, 'username', 'full_name', 'first_name', 'last_name',
                ],
                as => [
                    qw/id username full_name first_name last_name/
                ],
                order_by => 'full_name',
                page     => $page,
                rows     => $rows,
            }
        )
    ];

    $c->stash->{person_count} = @$persons;
    $c->stash->{persons}      = $persons;

    $c->stash->{url_params} = $url_params;
    }

    $c->stash->{template} = 'person/search.tt';
}



=head2 add_headshot

=cut

sub add_headshot : Chained('person_object') : PathPart('add_headshot') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'person/add_headshot.tt';
}


=head2 add

=cut

sub add : Local {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'person/add.tt';
}

=head2 base

=cut

sub person_base : Chained('/') : PathPart('person') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->stash( person_rs => $c->model('ProjectTaskToDoDB::Person') );
}

=head2 details

=cut

sub details : Chained('person_object') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    if ( $c->user_exists ) {
        if (
               ( $c->check_user_roles('administrator') )
            || ( $c->check_user_roles('user_maintainer') )

          )
        {
            $c->stash->{authorized} = 1;
        }
    }

    $c->stash->{template} = 'person/details.tt';
}

=head2 edit

=cut

sub edit : Chained('person_object') : PathPart('edit') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'person/edit.tt';
}


=head2 insert

=cut

sub insert : Local {
    my ( $self, $c ) = @_;

    if ( $c->user_exists ) {
        if (
               ( $c->check_user_roles('administrator') )
            || ( $c->check_user_roles('user_maintainer') )

          )
        {
            $c->stash->{authorized} = 1;

            my $username           = $c->req->params->{username};
            my $full_name          = $c->req->params->{full_name};
            my $first_name         = $c->req->params->{first_name};
            my $last_name          = $c->req->params->{last_name};
            my $office_email       = $c->req->params->{office_email};
            my $office_phone       = $c->req->params->{office_phone};
            my $office_floor       = $c->req->params->{office_floor};
            my $office_department  = $c->req->params->{office_department};
            my $office_address1    = $c->req->params->{office_address1};
            my $office_address2    = $c->req->params->{office_address2};
            my $office_address3    = $c->req->params->{office_address3};
            my $office_city        = $c->req->params->{office_city};
            my $office_state       = $c->req->params->{office_state};
            my $office_postal_code = $c->req->params->{office_postal_code};
            my $office_country     = $c->req->params->{office_country};
            my $mobile_phone       = $c->req->params->{mobile_phone};
            my $skype_name         = $c->req->params->{skype_name};
            my $aim_name           = $c->req->params->{aim_name};
            my $nnit_initials      = $c->req->params->{nnit_initials};

            my $person = $c->model('ProjectTaskToDoDB::Person')->create(
                {
                    username          => $username,
                    full_name         => $full_name,
                    first_name        => $first_name,
                    last_name         => $last_name,
                    office_email      => $office_email,
                    office_phone      => $office_phone,
                    office_floor      => $office_floor,
                    office_department => $office_department,
                    office_address1   => $office_address1,
                    office_address2    => $office_address2,
                    office_address3    => $office_address3,
                    office_city        => $office_city,
                    office_state       => $office_state,
                    office_postal_code => $office_postal_code,
                    office_country     => $office_country,
                    mobile_phone       => $mobile_phone,
                    skype_name         => $skype_name,
                    aim_name           => $aim_name,
                    nnit_initials      => $nnit_initials,
                }
            );

            my $person_id = $person->id;

            $c->response->redirect( $c->uri_for("/person/$person_id") );
            $c->detach();

        }
        $c->flash->{message} = 'You are not authorized to create new People';
        $c->response->redirect( $c->uri_for("/") );
        $c->detach();
    }

    else {
        $c->flash->{message} = 'You are not authorized to create new People';
        $c->response->redirect( $c->uri_for("/") );
        $c->detach();

    }
}

=head2 list

=cut

sub list : Chained('person_base') : PathPart('list') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{persons} =
      [ $c->model('ProjectTaskToDoDB::Person')
          ->search( { active => 1 }, { order_by => 'full_name' } ) ];
    $c->stash->{template} = 'person/list.tt';
}

=head2 name_lookup

=cut

sub name_lookup : Local {
    my ( $self, $c ) = @_;
    my @results = ();
    my $cname   = $c->req->query_parameters->{term};

    my $persons =
      $c->model('ProjectTaskToDoDB::Person')
      ->search( { full_name => { -like => "\%$cname\%" }, active => '1' },
        { order_by => 'full_name' } );

    while ( my $cur_person = $persons->next ) {

  # my $label = $cur_person->full_name . " (" . $cur_person->office_email . ")";
        my $label = $cur_person->full_name;
        push(
            @results,
            {
                id    => $cur_person->full_name,
                label => $label,
                value => $cur_person->id
            }
        );
    }
    $c->stash->{json} = \@results;
    $c->forward('View::JSON');
}

=head2 object

=cut

sub person_object : Chained('person_base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;
    my $person = $c->stash->{person_rs}->find( { id => $id } );
    if ( !$person ) {
        $c->response->redirect( $c->uri_for("/") );
        $c->detach();
    }
    $c->stash( person => $person );
}

=head2 update

=cut

sub update : Chained('person_object') : PathPart('update') : Args(0) {
    my ( $self, $c ) = @_;

    #grab the person from the stash
    my $person    = $c->stash->{person};
    my $person_id = $person->id;

    if ( $c->user_exists ) {
        if (
	       	( $c->check_user_roles('administrator') )
	       	|| ( $c->check_user_roles('user_maintainer') )
	       	|| ( $c->user->id == $person_id ) ) {
            $c->stash->{authorized} = 1;

            my $active             = $c->req->params->{active};
            my $full_name          = $c->req->params->{full_name};
            my $first_name         = $c->req->params->{first_name};
            my $last_name          = $c->req->params->{last_name};
            my $job_title          = $c->req->params->{job_title};
            my $hire_date_text     = $c->req->params->{hire_date_text};
            my $office_email       = $c->req->params->{office_email};
            my $office_phone       = $c->req->params->{office_phone};
            my $office_floor       = $c->req->params->{office_floor};
            my $office_department  = $c->req->params->{office_department};
            my $office_address1    = $c->req->params->{office_address1};
            my $office_address2    = $c->req->params->{office_address2};
            my $office_address3    = $c->req->params->{office_address3};
            my $office_city        = $c->req->params->{office_city};
            my $office_state       = $c->req->params->{office_state};
            my $office_postal_code = $c->req->params->{office_postal_code};
            my $office_country     = $c->req->params->{office_country};
            my $mobile_phone       = $c->req->params->{mobile_phone};
            my $skype_name         = $c->req->params->{skype_name};
            my $aim_name           = $c->req->params->{aim_name};
            my $nnit_initials      = $c->req->params->{nnit_initials};
            my $admin_notes        = $c->req->params->{admin_notes};

            $person->update(
                {
                    active            => $active,
                    full_name         => $full_name,
                    first_name        => $first_name,
                    last_name         => $last_name,
                    job_title         => $job_title,
                    hire_date_text    => $hire_date_text,
                    office_email      => $office_email,
                    office_phone      => $office_phone,
                    office_floor      => $office_floor,
                    office_department => $office_department,
                    office_address1   =>,
                    $office_address1,
                    office_address2    => $office_address2,
                    office_address3    => $office_address3,
                    office_city        => $office_city,
                    office_state       => $office_state,
                    office_postal_code => $office_postal_code,
                    office_country     => $office_country,
                    mobile_phone       => $mobile_phone,
                    skype_name         => $skype_name,
                    aim_name           => $aim_name,
                    nnit_initials      => $nnit_initials,
                    admin_notes        => $admin_notes
                }
            );
            $c->stash->{person} = $person;
            $c->response->redirect( $c->uri_for("/person/$person_id") );
            $c->detach();

        }

    }
    else {
        $c->flash->{message} = "You are not authorized to edit this user.";
        $c->response->redirect( $c->uri_for("/person/$person_id") );
            $c->detach();
    }
        $c->flash->{message} = "NEITHER";
        $c->response->redirect( $c->uri_for("/person/$person_id") );

}


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ProjectTaskToDo::Controller::Person in Person.');
}


=head1 AUTHOR

William B. Hauck

=cut

__PACKAGE__->meta->make_immutable;

1;
